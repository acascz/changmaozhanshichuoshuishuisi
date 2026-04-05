package com.pdd.mall.config;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pdd.mall.entity.DeliveryOrder;
import com.pdd.mall.entity.LogisticsTrack;
import com.pdd.mall.entity.TrackInfo;
import com.pdd.mall.service.DeliveryOrderService;
import com.pdd.mall.service.LogisticsTrackService;
import com.pdd.mall.service.LogisticsWebSocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 物流轨迹自动拉取定时任务
 * 定时调用物流 API 获取最新轨迹，并推送给用户
 */
@Component
@Slf4j
public class LogisticsAutoFetchScheduler {
    
    @Autowired
    private DeliveryOrderService deliveryOrderService;
    
    @Autowired
    private LogisticsTrackService logisticsTrackService;
    
    @Autowired
    private LogisticsWebSocketService webSocketService;
    
    @Autowired
    private RestTemplate restTemplate;
    
    @Autowired
    private ObjectMapper objectMapper;
    
    @Value("${logistics.api.enabled:false}")
    private boolean apiEnabled;
    
    @Value("${logistics.api.kuaidi100.customer:}")
    private String kuaidi100Customer;
    
    @Value("${logistics.api.kuaidi100.key:}")
    private String kuaidi100Key;
    
    /**
     * 每 30 分钟拉取一次物流轨迹
     * 可以调整为使用 cron 表达式
     */
    @Scheduled(fixedRate = 1800000) // 30 分钟
    public void autoFetchLogistics() {
        if (!apiEnabled) {
            log.debug("物流 API 未启用，跳过自动拉取");
            return;
        }
        
        log.info("开始自动拉取物流轨迹...");
        
        try {
            // 1. 获取所有已发货但未签收的订单
            List<DeliveryOrder> pendingDeliveries = deliveryOrderService.findPendingDeliveries();
            
            for (DeliveryOrder delivery : pendingDeliveries) {
                try {
                    // 2. 调用快递 100 API 查询轨迹
                    String logisticsNo = delivery.getLogisticsNo();
                    String logisticsCompany = delivery.getLogisticsCompany();
                    
                    if (logisticsNo == null || logisticsNo.isEmpty()) {
                        continue;
                    }
                    
                    // 3. 查询快递 100 API
                    String trackData = queryKuaidi100(logisticsCompany, logisticsNo);
                    
                    if (trackData != null && !trackData.isEmpty()) {
                        // 4. 解析轨迹数据
                        List<TrackInfo> trackInfos = parseKuaidi100Response(trackData);
                        
                        // 5. 保存轨迹到数据库
                        if (!trackInfos.isEmpty()) {
                            LogisticsTrack track = new LogisticsTrack();
                            track.setLogisticsNo(logisticsNo);
                            track.setOrderId(delivery.getOrderId());
                            
                            // 设置最新轨迹
                            TrackInfo latest = trackInfos.get(0);
                            track.setTrackContent(latest.getDescription());
                            track.setTrackStatus(mapStatusToInt(latest.getStatus()));
                            track.setTrackTime(LocalDateTime.now());
                            track.setUpdateTime(LocalDateTime.now());
                            
                            logisticsTrackService.batchAddTrack(List.of(track));
                            
                            // 6. 推送给用户
                            Map<String, Object> update = new java.util.HashMap<>();
                            update.put("orderId", delivery.getOrderId());
                            update.put("logisticsNo", logisticsNo);
                            update.put("trackInfo", latest.getDescription());
                            update.put("status", "运输中");
                            webSocketService.pushLogisticsUpdate(logisticsNo, update);
                            
                            log.info("物流轨迹更新：orderId={}, logisticsNo={}, trackInfo={}", 
                                    delivery.getOrderId(), logisticsNo, latest.getDescription());
                        }
                    }
                } catch (Exception e) {
                    log.error("拉取物流轨迹失败：orderId={}, logisticsNo={}", 
                            delivery.getOrderId(), delivery.getLogisticsNo(), e);
                }
            }
            
            log.info("物流轨迹自动拉取完成");
            
        } catch (Exception e) {
            log.error("物流轨迹自动拉取异常", e);
        }
    }
    
    /**
     * 查询快递 100 API
     */
    private String queryKuaidi100(String logisticsCompany, String logisticsNo) {
        try {
            // 快递 100 查询 API
            String url = String.format(
                "http://poll.kuaidi100.com/poll/query.do?customer=%s&num=%s&com=%s&key=%s",
                kuaidi100Customer, logisticsNo, logisticsCompany, kuaidi100Key
            );
            
            @SuppressWarnings("unchecked")
            String response = restTemplate.postForObject(url, null, String.class);
            
            if (response != null && response.contains("\"message\":\"ok\"")) {
                return response;
            }
            
            log.warn("快递 100 查询失败：logisticsNo={}, response={}", logisticsNo, response);
            
        } catch (Exception e) {
            log.error("快递 100 API 调用失败：logisticsNo={}", logisticsNo, e);
        }
        
        return null;
    }
    
    /**
     * 解析快递 100 响应
     */
    private List<TrackInfo> parseKuaidi100Response(String response) {
        List<TrackInfo> trackInfos = new ArrayList<>();
        
        try {
            // 使用 Jackson 解析 JSON
            JsonNode rootNode = objectMapper.readTree(response);
            
            // 检查响应状态
            if (!rootNode.has("message") || !"ok".equals(rootNode.get("message").asText())) {
                log.warn("快递 100 响应异常：{}", response);
                return trackInfos;
            }
            
            // 获取物流单号（用于日志记录）
            String logisticsNo = rootNode.has("nu") ? rootNode.get("nu").asText() : "";
            
            // 获取状态
            String status = rootNode.has("status") ? rootNode.get("status").asText() : "";
            
            log.debug("解析物流轨迹：logisticsNo={}, status={}", logisticsNo, status);
            
            // 解析轨迹数据
            if (rootNode.has("data") && rootNode.get("data").isArray()) {
                JsonNode dataArray = rootNode.get("data");
                
                for (JsonNode item : dataArray) {
                    TrackInfo trackInfo = new TrackInfo();
                    
                    String time = item.has("time") ? item.get("time").asText() : "";
                    String context = item.has("context") ? item.get("context").asText() : "";
                    String ftime = item.has("ftime") ? item.get("ftime").asText() : time;
                    
                    trackInfo.setTime(time);
                    trackInfo.setDescription(context);
                    trackInfo.setUpdateTime(ftime);
                    trackInfo.setStatus(mapStatus(status));
                    
                    trackInfos.add(trackInfo);
                }
            }
            
        } catch (Exception e) {
            log.error("解析快递 100 响应失败", e);
        }
        
        return trackInfos;
    }
    
    /**
     * 映射快递 100 状态码到系统状态
     */
    private String mapStatus(String kuaidi100Status) {
        if ("50".equals(kuaidi100Status)) {
            return "已签收";
        } else if ("40".equals(kuaidi100Status)) {
            return "运输中";
        } else if ("30".equals(kuaidi100Status)) {
            return "已收件";
        } else if ("20".equals(kuaidi100Status)) {
            return "已揽收";
        } else if ("10".equals(kuaidi100Status)) {
            return "待揽收";
        } else {
            return "未知";
        }
    }
    
    /**
     * 映射状态文本到整数状态
     */
    private int mapStatusToInt(String status) {
        if ("已签收".equals(status)) {
            return 5;
        } else if ("运输中".equals(status)) {
            return 4;
        } else if ("已收件".equals(status)) {
            return 3;
        } else if ("已揽收".equals(status)) {
            return 2;
        } else if ("待揽收".equals(status)) {
            return 1;
        } else {
            return 0;
        }
    }
}

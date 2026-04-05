package com.pdd.mall.service.impl;

import com.pdd.mall.entity.LogisticsTrack;
import com.pdd.mall.entity.TrackStatistics;
import com.pdd.mall.mapper.LogisticsTrackMapper;
import com.pdd.mall.service.LogisticsTrackService;
import com.pdd.mall.service.LogisticsWebSocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 物流追踪服务实现类
 */
@Slf4j
@Service
public class LogisticsTrackServiceImpl implements LogisticsTrackService {

    @Autowired
    private LogisticsTrackMapper logisticsTrackMapper;

    @Autowired
    private LogisticsWebSocketService webSocketService;

    @Override
    public LogisticsTrack getTrackByLogisticsNo(String logisticsNo) {
        log.info("查询物流轨迹 - 物流单号：{}", logisticsNo);
        return logisticsTrackMapper.getTrackByLogisticsNo(logisticsNo);
    }

    @Override
    public LogisticsTrack getTrackByOrderId(Long orderId) {
        log.info("查询物流轨迹 - 订单 ID: {}", orderId);
        return logisticsTrackMapper.getTrackByOrderId(orderId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void batchAddTrack(List<LogisticsTrack> tracks) {
        log.info("批量添加物流轨迹 - 数量：{}", tracks.size());
        
        // 生成 ID
        long currentTime = System.currentTimeMillis();
        for (int i = 0; i < tracks.size(); i++) {
            tracks.get(i).setId(currentTime + i);
        }
        
        logisticsTrackMapper.batchAddTrack(tracks);
        
        // 推送 WebSocket 更新
        for (LogisticsTrack track : tracks) {
            try {
                Map<String, Object> trackData = new HashMap<>();
                trackData.put("trackStatus", track.getTrackStatus());
                trackData.put("trackContent", track.getTrackContent());
                trackData.put("trackLocation", track.getTrackLocation());
                trackData.put("trackTime", track.getTrackTime() != null ? 
                        track.getTrackTime().toString() : LocalDateTime.now().toString());
                
                webSocketService.pushLogisticsUpdate(track.getLogisticsNo(), trackData.toString());
                log.info("已推送物流轨迹更新：{}", track.getLogisticsNo());
            } catch (Exception e) {
                log.error("推送物流轨迹更新失败：{}", e.getMessage(), e);
            }
        }
    }

    @Override
    public LogisticsTrack getLatestTrack(String logisticsNo) {
        log.info("获取最新轨迹 - 物流单号：{}", logisticsNo);
        return logisticsTrackMapper.getLatestTrack(logisticsNo);
    }

    @Override
    public TrackStatistics getTrackStatistics(String logisticsNo) {
        log.info("获取轨迹统计 - 物流单号：{}", logisticsNo);
        
        return logisticsTrackMapper.getTrackStatistics(logisticsNo);
    }
}

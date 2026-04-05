package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.DeliveryOrder;
import com.pdd.mall.entity.LogisticsTrack;
import com.pdd.mall.entity.TrackInfo;
import com.pdd.mall.entity.User;
import com.pdd.mall.service.DeliveryOrderService;
import com.pdd.mall.service.LogisticsTrackService;
import com.pdd.mall.service.LogisticsWebSocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 发货单 Controller
 * 仅限商家后台使用，需要商家权限验证
 */
@RestController
@RequestMapping("/api/delivery")
@CrossOrigin
@Slf4j
public class DeliveryController {
    
    @Autowired
    private DeliveryOrderService deliveryOrderService;
    
    @Autowired
    private LogisticsTrackService logisticsTrackService;
    
    @Autowired
    private LogisticsWebSocketService webSocketService;
    
    @PostMapping("/create")
    public Result<DeliveryOrder> createDelivery(@RequestBody DeliveryOrder order) {
        try {
            DeliveryOrder delivery = deliveryOrderService.createDeliveryOrder(order);
            return Result.success(delivery);
        } catch (Exception e) {
            return Result.error("创建发货单失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/order/{orderId}")
    public Result<DeliveryOrder> getDeliveryByOrder(@PathVariable Long orderId) {
        DeliveryOrder delivery = deliveryOrderService.getDeliveryByOrderId(orderId);
        if (delivery != null) {
            return Result.success(delivery);
        }
        return Result.error("发货单不存在");
    }
    
    @PostMapping("/ship/{id}")
    public Result<DeliveryOrder> ship(@PathVariable Long id,
                                      @RequestParam String logisticsCompany,
                                      @RequestParam String logisticsNo,
                                      HttpServletRequest request) {
        try {
            // 1. 验证商家权限（从 session 获取用户角色）
            HttpSession session = request.getSession(false);
            if (session == null) {
                return Result.error("请先登录");
            }
            
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
                return Result.error("请先登录");
            }
            
            String userRole = currentUser.getRole();
            if (userRole == null || (!"MERCHANT".equals(userRole) && !"ADMIN".equals(userRole))) {
                return Result.error("权限不足：只有商家才能发货");
            }
            
            // 2. 执行发货
            DeliveryOrder delivery = deliveryOrderService.shipOrder(id, logisticsCompany, logisticsNo);
            
            // 3. 创建初始物流轨迹
            LogisticsTrack track = new LogisticsTrack();
            track.setLogisticsNo(logisticsNo);
            track.setOrderId(delivery.getOrderId());
            track.setTrackContent("商家已发货，等待快递员揽收");
            track.setTrackStatus(1); // 已发货
            track.setTrackTime(LocalDateTime.now());
            logisticsTrackService.batchAddTrack(List.of(track));
            
            // 4. 通过 WebSocket 推送给用户
            try {
                String message = String.format(
                    "{\"orderId\":%d,\"logisticsNo\":\"%s\",\"logisticsCompany\":\"%s\",\"status\":\"已发货\"}",
                    delivery.getOrderId(), logisticsNo, logisticsCompany
                );
                // 使用 orderId 作为用户的标识
                webSocketService.pushLogisticsUpdate(logisticsNo, message);
                log.info("WebSocket 推送成功：orderId={}", delivery.getOrderId());
            } catch (Exception e) {
                log.warn("WebSocket 推送失败：orderId={}", delivery.getOrderId(), e);
            }
            
            log.info("发货成功：id={}, orderId={}, logisticsNo={}", id, delivery.getOrderId(), logisticsNo);
            return Result.success(delivery);
            
        } catch (Exception e) {
            log.error("发货失败：id={}, logisticsNo={}", id, logisticsNo, e);
            return Result.error("发货失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/logistics/{logisticsNo}")
    public Result<List<DeliveryOrder>> getByLogisticsNo(@PathVariable String logisticsNo) {
        return Result.success(deliveryOrderService.getDeliveriesByLogisticsNo(logisticsNo));
    }
}

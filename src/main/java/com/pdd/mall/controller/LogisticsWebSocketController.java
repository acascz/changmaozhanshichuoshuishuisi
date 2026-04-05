package com.pdd.mall.controller;

import com.pdd.mall.service.LogisticsWebSocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 物流 WebSocket 控制器
 */
@RestController
@RequestMapping("/api/ws")
@Slf4j
public class LogisticsWebSocketController {

    @Autowired
    private LogisticsWebSocketService webSocketService;

    /**
     * 获取订阅统计
     */
    @GetMapping("/stats")
    public Map<String, Object> getStats() {
        return webSocketService.getStats();
    }

    /**
     * 手动推送物流更新（测试用）
     */
    @PostMapping("/push/{logisticsNo}")
    public boolean pushLogisticsUpdate(@PathVariable String logisticsNo,
                                       @RequestBody Map<String, Object> update) {
        log.info("手动推送物流更新：logisticsNo={}, update={}", logisticsNo, update);
        webSocketService.pushLogisticsUpdate(logisticsNo, update);
        return true;
    }

    /**
     * 处理订阅请求
     */
    @MessageMapping("/subscribe/{logisticsNo}")
    public void subscribe(@DestinationVariable String logisticsNo,
                          @Payload Map<String, String> payload) {
        String userId = payload.get("userId");
        log.info("订阅物流单：logisticsNo={}, userId={}", logisticsNo, userId);
        webSocketService.subscribe(logisticsNo, userId);
    }

    /**
     * 处理取消订阅请求
     */
    @MessageMapping("/unsubscribe/{logisticsNo}")
    public void unsubscribe(@DestinationVariable String logisticsNo,
                            @Payload Map<String, String> payload) {
        String userId = payload.get("userId");
        log.info("取消订阅：logisticsNo={}, userId={}", logisticsNo, userId);
        webSocketService.unsubscribe(logisticsNo, userId);
    }

    /**
     * 处理连接确认
     */
    @MessageMapping("/connect")
    public void onConnect(@Payload Map<String, String> payload) {
        String userId = payload.get("userId");
        log.info("用户连接：userId={}", userId);
    }

    /**
     * 处理断开连接
     */
    @MessageMapping("/disconnect")
    public void onDisconnect(@Payload Map<String, String> payload) {
        String userId = payload.get("userId");
        log.info("用户断开：userId={}", userId);
        webSocketService.handleDisconnect(userId);
    }
}

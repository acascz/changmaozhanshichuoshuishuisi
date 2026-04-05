package com.pdd.mall.service.impl;

import com.pdd.mall.service.LogisticsWebSocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 物流 WebSocket 服务实现
 */
@Slf4j
@Service
public class LogisticsWebSocketServiceImpl implements LogisticsWebSocketService {
    
    private final Map<String, Map<String, String>> subscriptions = new ConcurrentHashMap<>();
    private final Map<String, Integer> subscribeCount = new ConcurrentHashMap<>();

    @Override
    public void pushLogisticsUpdate(String logisticsNo, String message) {
        log.info("推送物流更新 - 物流单号：{}, 消息：{}", logisticsNo, message);
    }
    
    /**
     * 推送物流更新（Map 版本）
     */
    public void pushLogisticsUpdate(String logisticsNo, Map<String, Object> update) {
        log.info("推送物流更新 - 物流单号：{}, 更新：{}", logisticsNo, update);
    }
    
    /**
     * 订阅物流单
     */
    public void subscribe(String logisticsNo, String userId) {
        log.info("订阅物流单：logisticsNo={}, userId={}", logisticsNo, userId);
        subscriptions.computeIfAbsent(logisticsNo, k -> new ConcurrentHashMap<>()).put(userId, userId);
        subscribeCount.put(logisticsNo, subscriptions.get(logisticsNo).size());
    }
    
    /**
     * 取消订阅
     */
    public void unsubscribe(String logisticsNo, String userId) {
        log.info("取消订阅：logisticsNo={}, userId={}", logisticsNo, userId);
        Map<String, String> users = subscriptions.get(logisticsNo);
        if (users != null) {
            users.remove(userId);
            subscribeCount.put(logisticsNo, users.size());
        }
    }
    
    /**
     * 处理断开连接
     */
    public void handleDisconnect(String userId) {
        log.info("处理断开连接：userId={}", userId);
        subscriptions.forEach((logisticsNo, users) -> {
            if (users.remove(userId) != null) {
                subscribeCount.put(logisticsNo, users.size());
            }
        });
    }
    
    /**
     * 获取统计信息
     */
    public Map<String, Object> getStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalSubscriptions", subscribeCount.values().stream().mapToInt(Integer::intValue).sum());
        stats.put("logisticsNoCount", subscriptions.size());
        stats.put("subscribeCount", subscribeCount);
        return stats;
    }
}

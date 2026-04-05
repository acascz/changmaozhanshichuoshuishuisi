package com.pdd.mall.service;

import java.util.Map;

/**
 * 物流 WebSocket 服务
 */
public interface LogisticsWebSocketService {

    /**
     * 推送物流更新
     */
    void pushLogisticsUpdate(String logisticsNo, String message);
    
    /**
     * 推送物流更新（Map 版本）
     */
    void pushLogisticsUpdate(String logisticsNo, Map<String, Object> update);
    
    /**
     * 订阅物流单
     */
    void subscribe(String logisticsNo, String userId);
    
    /**
     * 取消订阅
     */
    void unsubscribe(String logisticsNo, String userId);
    
    /**
     * 处理断开连接
     */
    void handleDisconnect(String userId);
    
    /**
     * 获取统计信息
     */
    Map<String, Object> getStats();
}

package com.pdd.mall.service;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.entity.WebSocketMessage;

import java.util.Map;

/**
 * 聊天 WebSocket 服务接口
 */
public interface ChatWebSocketService {

    /**
     * 推送新消息
     * 
     * @param receiverId 接收者 ID
     * @param message 聊天消息
     */
    void pushMessage(Long receiverId, ChatMessage message);
    
    /**
     * 推送消息到会话
     * 
     * @param sessionId 会话 ID
     * @param message WebSocket 消息
     */
    void pushToSession(String sessionId, WebSocketMessage message);
    
    /**
     * 订阅会话
     * 
     * @param userId 用户 ID
     * @param sessionId 会话 ID
     */
    void subscribe(Long userId, String sessionId);
    
    /**
     * 取消订阅
     * 
     * @param userId 用户 ID
     * @param sessionId 会话 ID
     */
    void unsubscribe(Long userId, String sessionId);
    
    /**
     * 处理断开连接
     * 
     * @param userId 用户 ID
     */
    void handleDisconnect(Long userId);
    
    /**
     * 检查用户是否在线
     * 
     * @param userId 用户 ID
     * @return 是否在线
     */
    boolean isOnline(Long userId);
    
    /**
     * 获取在线用户数
     * 
     * @return 在线用户数
     */
    int getOnlineCount();
    
    /**
     * 获取统计信息
     * 
     * @return 统计信息
     */
    Map<String, Object> getStats();
}

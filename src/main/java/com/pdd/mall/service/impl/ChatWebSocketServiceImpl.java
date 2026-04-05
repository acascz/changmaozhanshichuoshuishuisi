package com.pdd.mall.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.entity.WebSocketMessage;
import com.pdd.mall.service.ChatWebSocketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * 聊天 WebSocket 服务实现类
 */
@Slf4j
@Service
public class ChatWebSocketServiceImpl implements ChatWebSocketService {
    
    @Autowired
    private ObjectMapper objectMapper;
    
    /**
     * 存储所有在线用户的 WebSocket 会话
     * Key: 用户 ID, Value: WebSocketSession 集合
     */
    private final Map<Long, Set<WebSocketSession>> userSessions = new ConcurrentHashMap<>();
    
    /**
     * 存储会话订阅关系
     * Key: 会话 ID, Value: 用户 ID 集合
     */
    private final Map<String, Set<Long>> sessionSubscribers = new ConcurrentHashMap<>();
    
    /**
     * 存储用户与会话的映射
     * Key: 用户 ID, Value: 会话 ID 集合
     */
    private final Map<Long, Set<String>> userSubscriptions = new ConcurrentHashMap<>();
    
    @Override
    public void pushMessage(Long receiverId, ChatMessage message) {
        try {
            log.info("推送消息给在线用户：receiverId={}, messageId={}", receiverId, message.getMessageId());
            
            // 创建 WebSocket 消息
            WebSocketMessage wsMessage = WebSocketMessage.newMessage(message);
            
            // 获取接收者的所有会话
            Set<WebSocketSession> sessions = userSessions.get(receiverId);
            
            if (sessions == null || sessions.isEmpty()) {
                log.info("用户不在线，无法推送：receiverId={}", receiverId);
                return;
            }
            
            // 转换为 JSON
            String jsonMessage = objectMapper.writeValueAsString(wsMessage);
            TextMessage textMessage = new TextMessage(jsonMessage);
            
            // 推送给所有在线会话
            int successCount = 0;
            for (WebSocketSession session : sessions) {
                if (session.isOpen()) {
                    try {
                        session.sendMessage(textMessage);
                        successCount++;
                    } catch (IOException e) {
                        log.error("推送消息失败：sessionId={}", session.getId(), e);
                    }
                }
            }
            
            log.info("消息推送完成：receiverId={}, successCount={}, totalSessions={}", 
                    receiverId, successCount, sessions.size());
            
        } catch (Exception e) {
            log.error("推送消息失败", e);
        }
    }
    
    @Override
    public void pushToSession(String sessionId, WebSocketMessage message) {
        try {
            log.info("推送消息到会话：sessionId={}", sessionId);
            
            // 获取会话的所有订阅用户
            Set<Long> subscribers = sessionSubscribers.get(sessionId);
            
            if (subscribers == null || subscribers.isEmpty()) {
                log.info("会话无订阅者：sessionId={}", sessionId);
                return;
            }
            
            // 转换为 JSON
            String jsonMessage = objectMapper.writeValueAsString(message);
            TextMessage textMessage = new TextMessage(jsonMessage);
            
            // 推送给所有订阅用户
            for (Long userId : subscribers) {
                Set<WebSocketSession> sessions = userSessions.get(userId);
                if (sessions != null) {
                    for (WebSocketSession session : sessions) {
                        if (session.isOpen()) {
                            try {
                                session.sendMessage(textMessage);
                            } catch (IOException e) {
                                log.error("推送会话消息失败：userId={}, sessionId={}", userId, session.getId(), e);
                            }
                        }
                    }
                }
            }
            
        } catch (Exception e) {
            log.error("推送会话消息失败", e);
        }
    }
    
    @Override
    public void subscribe(Long userId, String sessionId) {
        log.info("用户订阅会话：userId={}, sessionId={}", userId, sessionId);
        
        // 添加到会话订阅列表
        sessionSubscribers.computeIfAbsent(sessionId, k -> new CopyOnWriteArraySet<>()).add(userId);
        
        // 添加到用户订阅列表
        userSubscriptions.computeIfAbsent(userId, k -> new CopyOnWriteArraySet<>()).add(sessionId);
    }
    
    @Override
    public void unsubscribe(Long userId, String sessionId) {
        log.info("用户取消订阅会话：userId={}, sessionId={}", userId, sessionId);
        
        // 从会话订阅列表移除
        Set<Long> subscribers = sessionSubscribers.get(sessionId);
        if (subscribers != null) {
            subscribers.remove(userId);
            if (subscribers.isEmpty()) {
                sessionSubscribers.remove(sessionId);
            }
        }
        
        // 从用户订阅列表移除
        Set<String> sessions = userSubscriptions.get(userId);
        if (sessions != null) {
            sessions.remove(sessionId);
            if (sessions.isEmpty()) {
                userSubscriptions.remove(userId);
            }
        }
    }
    
    @Override
    public void handleDisconnect(Long userId) {
        log.info("用户断开连接：userId={}", userId);
        
        // 移除用户的所有会话
        Set<WebSocketSession> sessions = userSessions.remove(userId);
        if (sessions != null) {
            sessions.clear();
        }
        
        // 取消用户的所有订阅
        Set<String> sessionIds = userSubscriptions.remove(userId);
        if (sessionIds != null) {
            for (String sessionId : sessionIds) {
                unsubscribe(userId, sessionId);
            }
        }
        
        log.info("用户断开连接处理完成：userId={}", userId);
    }
    
    @Override
    public boolean isOnline(Long userId) {
        Set<WebSocketSession> sessions = userSessions.get(userId);
        return sessions != null && !sessions.isEmpty();
    }
    
    @Override
    public int getOnlineCount() {
        return userSessions.size();
    }
    
    @Override
    public Map<String, Object> getStats() {
        Map<String, Object> stats = new ConcurrentHashMap<>();
        stats.put("onlineUsers", userSessions.size());
        stats.put("activeSessions", sessionSubscribers.size());
        stats.put("totalSubscriptions", userSubscriptions.size());
        return stats;
    }
    
    /**
     * 添加用户会话（由 WebSocketHandler 调用）
     */
    public void addUserSession(Long userId, WebSocketSession session) {
        log.info("添加用户会话：userId={}, sessionId={}", userId, session.getId());
        userSessions.computeIfAbsent(userId, k -> new CopyOnWriteArraySet<>()).add(session);
    }
    
    /**
     * 移除用户会话（由 WebSocketHandler 调用）
     */
    public void removeUserSession(Long userId, WebSocketSession session) {
        log.info("移除用户会话：userId={}, sessionId={}", userId, session.getId());
        Set<WebSocketSession> sessions = userSessions.get(userId);
        if (sessions != null) {
            sessions.remove(session);
            if (sessions.isEmpty()) {
                userSessions.remove(userId);
                handleDisconnect(userId);
            }
        }
    }
    
    /**
     * 获取用户会话
     */
    public Set<WebSocketSession> getUserSessions(Long userId) {
        return userSessions.get(userId);
    }
}

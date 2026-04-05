package com.pdd.mall.handler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pdd.mall.entity.WebSocketMessage;
import com.pdd.mall.service.impl.ChatWebSocketServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Map;

/**
 * 聊天 WebSocket 处理器
 */
@Slf4j
@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {
    
    @Autowired
    private ObjectMapper objectMapper;
    
    @Autowired
    private ChatWebSocketServiceImpl chatWebSocketService;
    
    /**
     * 连接建立后
     */
    @Override
    public void afterConnectionEstablished(@NonNull WebSocketSession session) throws Exception {
        log.info("WebSocket 连接建立：sessionId={}, remoteAddress={}", 
                session.getId(), session.getRemoteAddress());
        
        // 从握手参数中获取用户 ID
        Map<String, Object> attributes = session.getAttributes();
        Long userId = (Long) attributes.get("userId");
        
        if (userId != null) {
            // 添加用户会话
            chatWebSocketService.addUserSession(userId, session);
            log.info("用户连接成功：userId={}, sessionId={}", userId, session.getId());
            
            // 发送欢迎消息
            WebSocketMessage welcomeMsg = WebSocketMessage.onlineStatus(
                Map.of("userId", userId, "status", "online", "sessionId", session.getId())
            );
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(welcomeMsg)));
        } else {
            log.warn("连接缺少用户 ID：sessionId={}", session.getId());
            session.close(CloseStatus.BAD_DATA.withReason("缺少用户 ID"));
        }
    }
    
    /**
     * 收到消息
     */
    @Override
    protected void handleTextMessage(@NonNull WebSocketSession session, @NonNull TextMessage message) throws Exception {
        try {
            String payload = message.getPayload();
            log.info("收到 WebSocket 消息：sessionId={}, payload={}", session.getId(), payload);
            
            // 解析消息
            JsonNode jsonNode = objectMapper.readTree(payload);
            String type = jsonNode.has("type") ? jsonNode.get("type").asText() : null;
            
            // 从握手参数中获取用户 ID
            Long userId = (Long) session.getAttributes().get("userId");
            
            // 处理不同类型的消息
            if ("SUBSCRIBE".equals(type)) {
                // 订阅会话
                String sessionId = jsonNode.has("sessionId") ? jsonNode.get("sessionId").asText() : null;
                if (sessionId != null && userId != null) {
                    chatWebSocketService.subscribe(userId, sessionId);
                    
                    // 发送确认消息
                    WebSocketMessage confirmMsg = new WebSocketMessage();
                    confirmMsg.setType("SUBSCRIBE_ACK");
                    confirmMsg.setData(Map.of("sessionId", sessionId, "status", "success"));
                    session.sendMessage(new TextMessage(objectMapper.writeValueAsString(confirmMsg)));
                    
                    log.info("用户订阅会话成功：userId={}, sessionId={}", userId, sessionId);
                }
            } else if ("UNSUBSCRIBE".equals(type)) {
                // 取消订阅
                String sessionId = jsonNode.has("sessionId") ? jsonNode.get("sessionId").asText() : null;
                if (sessionId != null && userId != null) {
                    chatWebSocketService.unsubscribe(userId, sessionId);
                    
                    // 发送确认消息
                    WebSocketMessage confirmMsg = new WebSocketMessage();
                    confirmMsg.setType("UNSUBSCRIBE_ACK");
                    confirmMsg.setData(Map.of("sessionId", sessionId, "status", "success"));
                    session.sendMessage(new TextMessage(objectMapper.writeValueAsString(confirmMsg)));
                    
                    log.info("用户取消订阅会话：userId={}, sessionId={}", userId, sessionId);
                }
            } else if ("PING".equals(type)) {
                // 心跳检测
                WebSocketMessage pongMsg = new WebSocketMessage();
                pongMsg.setType("PONG");
                pongMsg.setTimestamp(System.currentTimeMillis());
                session.sendMessage(new TextMessage(objectMapper.writeValueAsString(pongMsg)));
            } else {
                log.warn("未知的消息类型：type={}", type);
            }
            
        } catch (Exception e) {
            log.error("处理 WebSocket 消息失败", e);
            // 发送错误消息
            WebSocketMessage errorMsg = WebSocketMessage.error("处理消息失败：" + e.getMessage());
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(errorMsg)));
        }
    }
    
    /**
     * 连接关闭后
     */
    @Override
    public void afterConnectionClosed(@NonNull WebSocketSession session, @NonNull CloseStatus status) throws Exception {
        log.info("WebSocket 连接关闭：sessionId={}, status={}", session.getId(), status);
        
        // 从握手参数中获取用户 ID
        Long userId = (Long) session.getAttributes().get("userId");
        
        if (userId != null) {
            // 移除用户会话
            chatWebSocketService.removeUserSession(userId, session);
            log.info("用户连接关闭：userId={}, sessionId={}", userId, session.getId());
        }
    }
    
    /**
     * 传输错误
     */
    @Override
    public void handleTransportError(@NonNull WebSocketSession session, @NonNull Throwable exception) throws Exception {
        log.error("WebSocket 传输错误：sessionId={}", session.getId(), exception);
        
        // 从握手参数中获取用户 ID
        Long userId = (Long) session.getAttributes().get("userId");
        
        if (userId != null) {
            chatWebSocketService.removeUserSession(userId, session);
        }
        
        if (session.isOpen()) {
            session.close();
        }
    }
    
    /**
     * 是否支持部分消息
     */
    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
}

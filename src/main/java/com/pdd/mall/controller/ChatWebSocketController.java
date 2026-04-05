package com.pdd.mall.controller;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.entity.WebSocketMessage;
import com.pdd.mall.service.ChatMessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 聊天 WebSocket 控制器
 * 处理实时聊天消息的推送
 */
@RestController
@Slf4j
public class ChatWebSocketController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    
    @Autowired
    private ChatMessageService chatMessageService;

    /**
     * 处理用户加入聊天室
     */
    @MessageMapping("/chat.join")
    public void joinChat(@Payload Map<String, Object> payload) {
        String userId = payload.get("userId").toString();
        String sessionId = payload.get("sessionId").toString();
        
        log.info("用户加入聊天室：userId={}, sessionId={}", userId, sessionId);
        
        // 通知其他人该用户已加入
        try {
            messagingTemplate.convertAndSend(
                "/topic/chat.status." + sessionId,
                WebSocketMessage.onlineStatus(Map.of(
                    "userId", userId,
                    "status", "online",
                    "time", LocalDateTime.now()
                ))
            );
        } catch (Exception e) {
            log.error("发送加入通知失败", e);
        }
    }

    /**
     * 处理聊天消息发送
     */
    @MessageMapping("/chat.send")
    public void sendChatMessage(@Payload Map<String, Object> payload) {
        try {
            String sessionId = payload.get("sessionId").toString();
            Long senderId = Long.valueOf(payload.get("senderId").toString());
            Long receiverId = Long.valueOf(payload.get("receiverId").toString());
            String content = payload.get("content").toString();
            Integer messageType = Integer.valueOf(payload.get("messageType").toString());
            
            log.info("WebSocket 发送消息：sessionId={}, senderId={}, receiverId={}", 
                sessionId, senderId, receiverId);
            
            // 保存消息到数据库
            ChatMessage message = chatMessageService.sendMessage(
                sessionId, senderId, receiverId, content, messageType
            );
            
            // 广播给所有订阅该会话的用户
            messagingTemplate.convertAndSend(
                "/topic/messages/" + receiverId,
                WebSocketMessage.newMessage(message)
            );
            
            // 如果是群聊，需要广播给所有群成员
            if (sessionId.startsWith("group_")) {
                // TODO: 获取群成员列表并发送给所有成员
                log.info("群聊消息，需要广播给所有群成员：sessionId={}", sessionId);
            }
            
        } catch (Exception e) {
            log.error("发送聊天消息失败", e);
        }
    }

    /**
     * 处理消息已读确认
     */
    @MessageMapping("/chat.read")
    public void markAsRead(@Payload Map<String, Object> payload) {
        try {
            String messageId = payload.get("messageId").toString();
            Long userId = Long.valueOf(payload.get("userId").toString());
            
            log.info("标记消息已读：messageId={}, userId={}", messageId, userId);
            
            chatMessageService.markMessageAsRead(messageId);
            
            // 通知发送者消息已被读
            messagingTemplate.convertAndSend(
                "/topic/messages.read",
                WebSocketMessage.readUpdate(Map.of(
                    "messageId", messageId,
                    "readerId", userId,
                    "readTime", LocalDateTime.now()
                ))
            );
        } catch (Exception e) {
            log.error("标记消息已读失败", e);
        }
    }

    /**
     * 处理用户断开连接
     */
    @MessageMapping("/chat.disconnect")
    public void disconnect(@Payload Map<String, Object> payload) {
        String userId = payload.get("userId").toString();
        log.info("用户断开连接：userId={}", userId);
    }
}

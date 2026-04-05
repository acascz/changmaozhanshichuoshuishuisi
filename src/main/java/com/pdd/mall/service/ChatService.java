package com.pdd.mall.service;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.mapper.ChatMessageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 聊天服务（简化版）
 * 用于 AI 聊天等特殊场景
 */
@Service
@Slf4j
public class ChatService {

    @Autowired
    private ChatMessageMapper chatMessageMapper;
    
    @Autowired
    private ChatWebSocketService chatWebSocketService;

    /**
     * 根据会话 ID 查询消息
     */
    public List<ChatMessage> getMessagesBySessionId(String sessionId) {
        log.info("查询会话消息：sessionId={}", sessionId);
        return chatMessageMapper.selectBySessionId(sessionId, 0, 50);
    }

    /**
     * 发送消息（简化版）
     */
    @Transactional
    public ChatMessage sendMessage(String sessionId, Long senderId, Long receiverId,
                                   Integer messageType, String content) {
        log.info("发送消息：sessionId={}, senderId={}, receiverId={}", sessionId, senderId, receiverId);
        
        ChatMessage message = new ChatMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(messageType);
        message.setContent(content);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        chatMessageMapper.insert(message);
        
        // 推送消息给接收者（如果在线）
        if (receiverId != null) {
            try {
                chatWebSocketService.pushMessage(receiverId, message);
                log.info("消息推送完成：receiverId={}, messageId={}", receiverId, message.getMessageId());
            } catch (Exception e) {
                log.error("推送消息失败：receiverId={}", receiverId, e);
            }
        }
        
        return message;
    }
}

package com.pdd.mall.service;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.mapper.ChatMessageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatService {

    @Autowired
    private ChatMessageMapper chatMessageMapper;

    public List<ChatMessage> getMessagesByUserId(Long userId) {
        return chatMessageMapper.findByUserId(userId);
    }

    public ChatMessage sendMessage(Long userId, Integer fromType, String content) {
        ChatMessage message = new ChatMessage();
        message.setUserId(userId);
        message.setFromType(fromType);
        message.setContent(content);
        chatMessageMapper.insert(message);
        return message;
    }
}

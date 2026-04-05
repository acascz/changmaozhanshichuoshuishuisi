package com.pdd.mall.service.impl;

import com.pdd.mall.entity.ChatSession;
import com.pdd.mall.mapper.ChatSessionMapper;
import com.pdd.mall.service.ChatSessionService;
import com.pdd.mall.util.SnowflakeIdGenerator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

/**
 * 聊天会话服务实现
 */
@Slf4j
@Service
public class ChatSessionServiceImpl implements ChatSessionService {

    @Autowired
    private ChatSessionMapper chatSessionMapper;

    @Autowired
    private SnowflakeIdGenerator snowflakeIdGenerator;

    // 官方 AI 用户 ID
    private static final Long OFFICIAL_AI_USER_ID = 0L;

    @Override
    @Transactional
    public ChatSession createSession(ChatSession session) {
        String sessionId = String.valueOf(snowflakeIdGenerator.nextId());
        session.setSessionId(sessionId);
        session.setCreateTime(LocalDateTime.now());
        session.setUpdateTime(LocalDateTime.now());

        chatSessionMapper.insert(session);
        log.info("创建会话成功：sessionId={}", sessionId);
        return session;
    }

    @Override
    public ChatSession getSessionBySessionId(String sessionId) {
        return chatSessionMapper.selectBySessionId(sessionId);
    }

    @Override
    public List<Map<String, Object>> getUserSessions(Long userId, Integer page, Integer size) {
        // 暂时不分页，获取所有会话后再处理
        List<ChatSession> sessions = chatSessionMapper.selectByUserId(userId);
        
        // 手动分页
        if (sessions != null && !sessions.isEmpty()) {
            int fromIndex = (page - 1) * size;
            int toIndex = Math.min(fromIndex + size, sessions.size());
            if (fromIndex < sessions.size()) {
                sessions = sessions.subList(fromIndex, toIndex);
            } else {
                sessions = new ArrayList<>();
            }
        }

        List<Map<String, Object>> result = new ArrayList<>();
        if (sessions != null) {
            for (ChatSession session : sessions) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", session.getId());
                map.put("sessionId", session.getSessionId());
                map.put("title", session.getTitle());
                map.put("lastMessageContent", session.getLastMessage());
                map.put("lastMessageTime", session.getLastMessageTime());
                result.add(map);
            }
        }

        return result;
    }

    @Override
    @Transactional
    public int updateSession(ChatSession session) {
        session.setUpdateTime(LocalDateTime.now());
        return chatSessionMapper.update(session);
    }

    @Override
    @Transactional
    public int deleteSession(Long userId, String sessionId) {
        return chatSessionMapper.deleteByUserIdAndSessionId(userId, sessionId);
    }

    @Override
    @Transactional
    public int toggleTop(String sessionId, boolean isTop) {
        ChatSession session = chatSessionMapper.selectBySessionId(sessionId);
        if (session == null) {
            log.warn("会话不存在：sessionId={}", sessionId);
            return 0;
        }
        // 注：置顶功能需要数据库添加 is_top 字段，暂时返回成功
        return 1;
    }

    @Override
    @Transactional
    public int setDisturb(String sessionId, boolean isDisturb) {
        ChatSession session = chatSessionMapper.selectBySessionId(sessionId);
        if (session == null) {
            log.warn("会话不存在：sessionId={}", sessionId);
            return 0;
        }
        // 注：免打扰功能需要数据库添加 is_disturb 字段，暂时返回成功
        return 1;
    }

    @Override
    @Transactional
    public int updateUnreadCount(String sessionId, int unreadCount) {
        return chatSessionMapper.updateUnreadCount(sessionId, unreadCount);
    }

    @Override
    @Transactional
    public int incrementUnreadCount(String sessionId) {
        return chatSessionMapper.incrementUnreadCount(sessionId);
    }

    @Override
    @Transactional
    public int clearUnreadCount(String sessionId) {
        return chatSessionMapper.clearUnreadCount(sessionId);
    }

    @Override
    public ChatSession getAiSession(Long userId) {
        List<ChatSession> sessions = chatSessionMapper.selectByUserIdAndType(userId, 4);
        if (sessions != null && !sessions.isEmpty()) {
            return sessions.get(0);
        }
        return null;
    }

    @Override
    @Transactional
    public ChatSession getOrCreateAiSession(Long userId) {
        // 先尝试获取
        ChatSession session = getAiSession(userId);
        if (session != null) {
            return session;
        }

        // 创建新的 AI 会话
        session = new ChatSession();
        session.setUserId(userId);
        session.setAiId(OFFICIAL_AI_USER_ID);
        session.setTitle("AI 智能助手");
        session.setCreateTime(LocalDateTime.now());
        session.setUpdateTime(LocalDateTime.now());

        return createSession(session);
    }
}

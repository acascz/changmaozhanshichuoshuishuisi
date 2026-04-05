package com.pdd.mall.service;

import com.pdd.mall.entity.ChatSession;
import java.util.List;
import java.util.Map;

/**
 * 聊天会话服务
 */
public interface ChatSessionService {

    /**
     * 创建会话
     */
    ChatSession createSession(ChatSession session);

    /**
     * 根据会话 ID 获取会话
     */
    ChatSession getSessionBySessionId(String sessionId);

    /**
     * 获取用户会话列表
     */
    List<Map<String, Object>> getUserSessions(Long userId, Integer page, Integer size);

    /**
     * 更新会话
     */
    int updateSession(ChatSession session);

    /**
     * 删除会话
     */
    int deleteSession(Long userId, String sessionId);

    /**
     * 置顶/取消置顶会话
     */
    int toggleTop(String sessionId, boolean isTop);

    /**
     * 设置免打扰
     */
    int setDisturb(String sessionId, boolean isDisturb);

    /**
     * 更新未读计数
     */
    int updateUnreadCount(String sessionId, int unreadCount);

    /**
     * 增加未读计数
     */
    int incrementUnreadCount(String sessionId);

    /**
     * 清空未读计数
     */
    int clearUnreadCount(String sessionId);

    /**
     * 获取 AI 会话（官方 AI）
     */
    ChatSession getAiSession(Long userId);

    /**
     * 创建或获取 AI 会话
     */
    ChatSession getOrCreateAiSession(Long userId);
}

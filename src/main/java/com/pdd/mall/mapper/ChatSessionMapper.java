package com.pdd.mall.mapper;

import com.pdd.mall.entity.ChatSession;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 聊天会话 Mapper
 */
@Mapper
public interface ChatSessionMapper {

    /**
     * 根据 ID 查询会话
     */
    ChatSession selectById(@Param("id") Long id);

    /**
     * 根据用户 ID 查询会话
     */
    List<ChatSession> selectByUserId(@Param("userId") Long userId);

    /**
     * 创建会话
     */
    int insert(ChatSession session);

    /**
     * 更新会话
     */
    int update(ChatSession session);

    /**
     * 删除会话
     */
    int deleteById(@Param("id") Long id);

    /**
     * 根据 sessionId 查询会话
     */
    ChatSession selectBySessionId(@Param("sessionId") String sessionId);

    /**
     * 根据 userId 和 sessionId 删除会话
     */
    int deleteByUserIdAndSessionId(@Param("userId") Long userId, @Param("sessionId") String sessionId);

    /**
     * 更新未读消息数
     */
    int updateUnreadCount(@Param("sessionId") String sessionId, @Param("unreadCount") int unreadCount);

    /**
     * 增加未读消息数
     */
    int incrementUnreadCount(@Param("sessionId") String sessionId);

    /**
     * 根据用户 ID 和会话类型查询会话
     */
    List<ChatSession> selectByUserIdAndType(@Param("userId") Long userId, @Param("sessionType") int sessionType);

    /**
     * 根据 sessionId 更新未读消息数为 0
     */
    int clearUnreadCount(@Param("sessionId") String sessionId);
    
    /**
     * 根据 sessionId 删除会话
     */
    int delete(@Param("sessionId") String sessionId);
    
    /**
     * 根据 sessionId 查询会话
     */
    ChatSession findBySessionId(@Param("sessionId") String sessionId);
}

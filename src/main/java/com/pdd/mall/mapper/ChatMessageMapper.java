package com.pdd.mall.mapper;

import com.pdd.mall.entity.ChatMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 聊天消息 Mapper
 */
@Mapper
public interface ChatMessageMapper {
    
    /**
     * 插入消息
     */
    int insert(ChatMessage chatMessage);
    
    /**
     * 根据 ID 查询消息
     */
    ChatMessage selectById(@Param("id") Long id);
    
    /**
     * 根据消息 ID 查询消息
     */
    ChatMessage selectByMessageId(@Param("messageId") String messageId);
    
    /**
     * 查询会话消息列表（分页）
     */
    List<ChatMessage> selectBySessionId(@Param("sessionId") String sessionId,
                                        @Param("offset") int offset,
                                        @Param("limit") int limit);
    
    /**
     * 更新消息已读状态
     */
    int updateReadStatus(@Param("messageId") String messageId,
                         @Param("isRead") Integer isRead,
                         @Param("readTime") LocalDateTime readTime);
    
    /**
     * 更新消息状态（撤回/删除）
     */
    int updateStatus(@Param("messageId") String messageId,
                     @Param("status") Integer status);

    /**
     * 批量查询消息
     */
    List<ChatMessage> selectByMessageIds(@Param("messageIds") List<String> messageIds);
    
    /**
     * 查询用户会话列表
     */
    List<Map<String, Object>> selectUserSessions(@Param("userId") Long userId);
}

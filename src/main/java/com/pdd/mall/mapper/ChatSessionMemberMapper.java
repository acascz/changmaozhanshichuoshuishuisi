package com.pdd.mall.mapper;

import com.pdd.mall.entity.ChatSessionMember;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 会话成员 Mapper 接口
 */
@Mapper
public interface ChatSessionMemberMapper {
    
    /**
     * 插入会话成员
     */
    int insert(ChatSessionMember member);
    
    /**
     * 批量插入会话成员
     */
    int batchInsert(@Param("members") List<ChatSessionMember> members);
    
    /**
     * 根据会话 ID 查询所有成员
     */
    List<ChatSessionMember> findBySessionId(@Param("sessionId") String sessionId);
    
    /**
     * 查询用户在某个会话中的信息
     */
    ChatSessionMember findByUserAndSession(@Param("userId") Long userId, @Param("sessionId") String sessionId);
    
    /**
     * 更新成员角色
     */
    int updateRole(@Param("sessionId") String sessionId, @Param("userId") Long userId, @Param("role") Integer role);
    
    /**
     * 删除会话成员
     */
    int delete(@Param("sessionId") String sessionId, @Param("userId") Long userId);
    
    /**
     * 查询会话成员数
     */
    int countBySessionId(@Param("sessionId") String sessionId);
    
    /**
     * 检查用户是否在会话中
     */
    boolean exists(@Param("sessionId") String sessionId, @Param("userId") Long userId);
    
    /**
     * 根据会话 ID 删除所有成员
     */
    int deleteBySessionId(@Param("sessionId") String sessionId);
}

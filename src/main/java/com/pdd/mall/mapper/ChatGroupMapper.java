package com.pdd.mall.mapper;

import com.pdd.mall.entity.ChatGroup;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 群聊 Mapper 接口
 */
@Mapper
public interface ChatGroupMapper {
    
    /**
     * 插入群聊
     */
    int insert(ChatGroup group);
    
    /**
     * 根据 ID 查询群聊
     */
    ChatGroup findById(@Param("groupId") Long groupId);
    
    /**
     * 根据群号查询群聊
     */
    ChatGroup findByGroupNo(@Param("groupNo") String groupNo);
    
    /**
     * 更新群聊信息
     */
    int update(ChatGroup group);
    
    /**
     * 删除群聊
     */
    int delete(@Param("groupId") Long groupId);
    
    /**
     * 查询用户加入的所有群聊
     */
    List<ChatGroup> findUserGroups(@Param("userId") Long userId);
    
    /**
     * 查询群聊成员数
     */
    int countMembers(@Param("groupId") Long groupId);
    
    /**
     * 检查用户是否在群聊中
     */
    boolean isMember(@Param("groupId") Long groupId, @Param("userId") Long userId);
    
    /**
     * 更新群聊成员数
     */
    int updateMemberCount(@Param("groupId") Long groupId, @Param("memberCount") Integer memberCount);
}

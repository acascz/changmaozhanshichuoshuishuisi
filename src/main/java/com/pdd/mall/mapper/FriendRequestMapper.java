package com.pdd.mall.mapper;

import com.pdd.mall.entity.FriendRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 好友申请 Mapper 接口
 */
@Mapper
public interface FriendRequestMapper {
    
    /**
     * 创建好友申请
     */
    int insert(FriendRequest friendRequest);
    
    /**
     * 获取好友申请列表
     */
    List<FriendRequest> getRequests(@Param("userId") Long userId, @Param("status") Integer status);
    
    /**
     * 获取好友申请详情
     */
    FriendRequest getById(@Param("id") Long id);
    
    /**
     * 更新好友申请状态
     */
    int updateStatus(@Param("id") Long id, @Param("status") Integer status, @Param("handleTime") java.util.Date handleTime);
    
    /**
     * 撤回好友申请
     */
    int withdraw(@Param("id") Long id);
    
    /**
     * 检查是否已有申请
     */
    FriendRequest getExistingRequest(@Param("requesterId") Long requesterId, @Param("targetId") Long targetId);
}

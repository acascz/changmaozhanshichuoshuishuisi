package com.pdd.mall.service;

import com.pdd.mall.entity.FriendRequest;

import java.util.List;

/**
 * 好友申请服务接口
 */
public interface FriendRequestService {
    
    /**
     * 发送好友申请
     */
    void sendRequest(Long requesterId, Long targetId, String remark);
    
    /**
     * 获取好友申请列表
     */
    List<FriendRequest> getRequests(Long userId, Integer status);
    
    /**
     * 同意好友申请
     */
    void approveRequest(Long requestId, Long userId);
    
    /**
     * 拒绝好友申请
     */
    void rejectRequest(Long requestId, Long userId);
    
    /**
     * 撤回好友申请
     */
    void withdrawRequest(Long requestId, Long userId);
}

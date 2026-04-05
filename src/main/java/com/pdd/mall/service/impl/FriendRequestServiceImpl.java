package com.pdd.mall.service.impl;

import com.pdd.mall.entity.FriendRequest;
import com.pdd.mall.entity.UserFriend;
import com.pdd.mall.mapper.FriendRequestMapper;
import com.pdd.mall.mapper.UserFriendMapper;
import com.pdd.mall.service.FriendRequestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 好友申请服务实现类
 */
@Slf4j
@Service
public class FriendRequestServiceImpl implements FriendRequestService {
    
    @Autowired
    private FriendRequestMapper friendRequestMapper;
    
    @Autowired
    private UserFriendMapper userFriendMapper;
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void sendRequest(Long requesterId, Long targetId, String remark) {
        // 检查是否已经是好友
        UserFriend existingFriend = userFriendMapper.selectByUserIdAndFriendId(requesterId, targetId);
        if (existingFriend != null) {
            throw new RuntimeException("已经是好友，无需重复添加");
        }
        
        // 检查是否已有申请
        FriendRequest existingRequest = friendRequestMapper.getExistingRequest(requesterId, targetId);
        if (existingRequest != null && existingRequest.getStatus() == 0) {
            throw new RuntimeException("已发送过好友申请，请勿重复发送");
        }
        
        // 创建新的申请
        FriendRequest request = new FriendRequest();
        request.setRequesterId(requesterId);
        request.setTargetId(targetId);
        request.setRemark(remark);
        request.setStatus(0); // 待处理
        request.setCreateTime(new Date());
        
        friendRequestMapper.insert(request);
        log.info("发送好友申请：requesterId={}, targetId={}, remark={}", requesterId, targetId, remark);
    }
    
    @Override
    public List<FriendRequest> getRequests(Long userId, Integer status) {
        return friendRequestMapper.getRequests(userId, status);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveRequest(Long requestId, Long userId) {
        FriendRequest request = friendRequestMapper.getById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }
        if (!request.getTargetId().equals(userId)) {
            throw new RuntimeException("无权处理此申请");
        }
        if (request.getStatus() != 0) {
            throw new RuntimeException("申请已处理");
        }
        
        // 更新申请状态
        friendRequestMapper.updateStatus(requestId, 1, new Date());
        
        // 添加好友关系（双向）
        UserFriend friend1 = new UserFriend();
        friend1.setUserId(request.getRequesterId());
        friend1.setFriendId(request.getTargetId());
        userFriendMapper.insert(friend1);
        
        UserFriend friend2 = new UserFriend();
        friend2.setUserId(request.getTargetId());
        friend2.setFriendId(request.getRequesterId());
        userFriendMapper.insert(friend2);
        
        log.info("同意好友申请：requestId={}, userId={}", requestId, userId);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rejectRequest(Long requestId, Long userId) {
        FriendRequest request = friendRequestMapper.getById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }
        if (!request.getTargetId().equals(userId)) {
            throw new RuntimeException("无权处理此申请");
        }
        if (request.getStatus() != 0) {
            throw new RuntimeException("申请已处理");
        }
        
        // 更新申请状态
        friendRequestMapper.updateStatus(requestId, 2, new Date());
        
        log.info("拒绝好友申请：requestId={}, userId={}", requestId, userId);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void withdrawRequest(Long requestId, Long userId) {
        FriendRequest request = friendRequestMapper.getById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }
        if (!request.getRequesterId().equals(userId)) {
            throw new RuntimeException("无权撤回此申请");
        }
        if (request.getStatus() != 0) {
            throw new RuntimeException("申请已处理，无法撤回");
        }
        
        // 撤回申请
        friendRequestMapper.withdraw(requestId);
        
        log.info("撤回好友申请：requestId={}, userId={}", requestId, userId);
    }
}

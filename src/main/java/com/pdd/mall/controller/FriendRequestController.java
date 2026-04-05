package com.pdd.mall.controller;

import com.pdd.mall.entity.FriendRequest;
import com.pdd.mall.service.FriendRequestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 好友申请 REST API 控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/friend/request")
public class FriendRequestController {
    
    @Autowired
    private FriendRequestService friendRequestService;
    
    /**
     * 发送好友申请
     */
    @PostMapping("/send")
    public Map<String, Object> sendRequest(
            @RequestParam Long userId,
            @RequestParam Long friendId,
            @RequestParam(required = false) String remark) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            friendRequestService.sendRequest(userId, friendId, remark);
            
            result.put("code", 200);
            result.put("message", "好友申请已发送，等待对方同意");
            
        } catch (Exception e) {
            log.error("发送好友申请失败", e);
            result.put("code", 500);
            result.put("message", "发送失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取好友申请列表
     */
    @GetMapping("/list")
    public Map<String, Object> getRequests(
            @RequestParam Long userId,
            @RequestParam(required = false) Integer status) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            List<FriendRequest> requests = friendRequestService.getRequests(userId, status);
            
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", requests);
            
        } catch (Exception e) {
            log.error("获取好友申请列表失败", e);
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 同意好友申请
     */
    @PostMapping("/approve")
    public Map<String, Object> approveRequest(
            @RequestParam Long requestId,
            @RequestParam Long userId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            friendRequestService.approveRequest(requestId, userId);
            
            result.put("code", 200);
            result.put("message", "已同意好友申请");
            
        } catch (Exception e) {
            log.error("同意好友申请失败", e);
            result.put("code", 500);
            result.put("message", "操作失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 拒绝好友申请
     */
    @PostMapping("/reject")
    public Map<String, Object> rejectRequest(
            @RequestParam Long requestId,
            @RequestParam Long userId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            friendRequestService.rejectRequest(requestId, userId);
            
            result.put("code", 200);
            result.put("message", "已拒绝好友申请");
            
        } catch (Exception e) {
            log.error("拒绝好友申请失败", e);
            result.put("code", 500);
            result.put("message", "操作失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 撤回好友申请
     */
    @PostMapping("/withdraw")
    public Map<String, Object> withdrawRequest(
            @RequestParam Long requestId,
            @RequestParam Long userId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            friendRequestService.withdrawRequest(requestId, userId);
            
            result.put("code", 200);
            result.put("message", "已撤回好友申请");
            
        } catch (Exception e) {
            log.error("撤回好友申请失败", e);
            result.put("code", 500);
            result.put("message", "操作失败：" + e.getMessage());
        }
        
        return result;
    }
}

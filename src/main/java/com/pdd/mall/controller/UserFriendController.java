package com.pdd.mall.controller;

import com.pdd.mall.service.UserFriendService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 好友系统 REST API 控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/friend")
public class UserFriendController {
    
    @Autowired
    private UserFriendService userFriendService;
    
    /**
     * 获取好友列表
     */
    @GetMapping("/list")
    public Map<String, Object> getFriendList(@RequestParam(required = false) Long userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 如果没有传 userId，使用默认值 1
            if (userId == null) {
                userId = 1L;
            }
            
            List<Map<String, Object>> friends = userFriendService.getUserFriends(userId);
            
            result.put("code", 200);
            result.put("data", friends);
            result.put("message", "success");
            
        } catch (Exception e) {
            log.error("获取好友列表失败", e);
            result.put("code", 500);
            result.put("message", "获取好友列表失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 添加好友
     */
    @PostMapping("/add")
    public Map<String, Object> addFriend(
            @RequestParam Long userId,
            @RequestParam Long friendId,
            @RequestParam(required = false) String remark) {
        Map<String, Object> result = new HashMap<>();
        try {
            userFriendService.addFriend(userId, friendId, remark);
            
            result.put("code", 200);
            result.put("message", "添加好友成功");
            
        } catch (Exception e) {
            log.error("添加好友失败", e);
            result.put("code", 500);
            result.put("message", "添加好友失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 删除好友
     */
    @PostMapping("/delete")
    public Map<String, Object> deleteFriend(
            @RequestParam Long userId,
            @RequestParam Long friendId) {
        Map<String, Object> result = new HashMap<>();
        try {
            userFriendService.deleteFriend(userId, friendId);
            
            result.put("code", 200);
            result.put("message", "删除好友成功");
            
        } catch (Exception e) {
            log.error("删除好友失败", e);
            result.put("code", 500);
            result.put("message", "删除好友失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 更新好友备注
     */
    @PostMapping("/updateRemark")
    public Map<String, Object> updateRemark(
            @RequestParam Long userId,
            @RequestParam Long friendId,
            @RequestParam String remark) {
        Map<String, Object> result = new HashMap<>();
        try {
            userFriendService.updateRemark(userId, friendId, remark);
            
            result.put("code", 200);
            result.put("message", "更新备注成功");
            
        } catch (Exception e) {
            log.error("更新备注失败", e);
            result.put("code", 500);
            result.put("message", "更新备注失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 设置星标好友
     */
    @PostMapping("/setStar")
    public Map<String, Object> setStar(
            @RequestParam Long userId,
            @RequestParam Long friendId,
            @RequestParam Boolean isStar) {
        Map<String, Object> result = new HashMap<>();
        try {
            userFriendService.setStarStatus(userId, friendId, isStar);
            
            result.put("code", 200);
            result.put("message", "设置星标成功");
            
        } catch (Exception e) {
            log.error("设置星标失败", e);
            result.put("code", 500);
            result.put("message", "设置星标失败：" + e.getMessage());
        }
        
        return result;
    }
}

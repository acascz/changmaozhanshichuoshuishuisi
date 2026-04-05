package com.pdd.mall.controller;

import com.pdd.mall.entity.ChatGroup;
import com.pdd.mall.service.ChatGroupService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 群聊 REST API 控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/chat/group")
public class ChatGroupController {
    
    @Autowired
    private ChatGroupService chatGroupService;
    
    /**
     * 创建群聊
     */
    @PostMapping("/create")
    public Map<String, Object> createGroup(
            @RequestParam Long creatorId,
            @RequestParam String groupName,
            @RequestParam(required = false) String groupAvatar,
            @RequestBody(required = false) List<Long> memberIds) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            if (memberIds == null) {
                memberIds = List.of();
            }
            
            ChatGroup group = chatGroupService.createGroup(creatorId, groupName, groupAvatar, memberIds);
            
            result.put("code", 200);
            result.put("message", "创建成功");
            result.put("data", group);
            
        } catch (Exception e) {
            log.error("创建群聊失败", e);
            result.put("code", 500);
            result.put("message", "创建失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 加入群聊
     */
    @PostMapping("/join")
    public Map<String, Object> joinGroup(
            @RequestParam Long groupId,
            @RequestParam Long userId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.joinGroup(groupId, userId);
            
            result.put("code", 200);
            result.put("message", "加入成功");
            
        } catch (Exception e) {
            log.error("加入群聊失败", e);
            result.put("code", 500);
            result.put("message", "加入失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 退出群聊
     */
    @PostMapping("/leave")
    public Map<String, Object> leaveGroup(
            @RequestParam Long groupId,
            @RequestParam Long userId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.leaveGroup(groupId, userId);
            
            result.put("code", 200);
            result.put("message", "退出成功");
            
        } catch (Exception e) {
            log.error("退出群聊失败", e);
            result.put("code", 500);
            result.put("message", "退出失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 解散群聊
     */
    @PostMapping("/dismiss")
    public Map<String, Object> dismissGroup(
            @RequestParam Long groupId,
            @RequestParam Long operatorId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.dismissGroup(groupId, operatorId);
            
            result.put("code", 200);
            result.put("message", "解散成功");
            
        } catch (Exception e) {
            log.error("解散群聊失败", e);
            result.put("code", 500);
            result.put("message", "解散失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取用户的群聊列表
     */
    @GetMapping("/list")
    public Map<String, Object> getUserGroups(@RequestParam Long userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<ChatGroup> groups = chatGroupService.getUserGroups(userId);
            
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", groups);
            
        } catch (Exception e) {
            log.error("获取群聊列表失败", e);
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取群聊详情
     */
    @GetMapping("/detail")
    public Map<String, Object> getGroupDetail(@RequestParam Long groupId) {
        Map<String, Object> result = new HashMap<>();
        try {
            ChatGroup group = chatGroupService.getGroupDetail(groupId);
            
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", group);
            
        } catch (Exception e) {
            log.error("获取群聊详情失败", e);
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 更新群公告
     */
    @PostMapping("/notice/update")
    public Map<String, Object> updateGroupNotice(
            @RequestParam Long groupId,
            @RequestParam Long userId,
            @RequestParam String notice) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.updateGroupNotice(groupId, userId, notice);
            
            result.put("code", 200);
            result.put("message", "更新成功");
            
        } catch (Exception e) {
            log.error("更新群公告失败", e);
            result.put("code", 500);
            result.put("message", "更新失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 转让群主
     */
    @PostMapping("/transfer")
    public Map<String, Object> transferOwnership(
            @RequestParam Long groupId,
            @RequestParam Long currentOwnerId,
            @RequestParam Long newOwnerId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.transferOwnership(groupId, currentOwnerId, newOwnerId);
            
            result.put("code", 200);
            result.put("message", "转让成功");
            
        } catch (Exception e) {
            log.error("转让群主失败", e);
            result.put("code", 500);
            result.put("message", "转让失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 移除群成员
     */
    @PostMapping("/member/remove")
    public Map<String, Object> removeMember(
            @RequestParam Long groupId,
            @RequestParam Long operatorId,
            @RequestParam Long memberId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.removeMember(groupId, operatorId, memberId);
            
            result.put("code", 200);
            result.put("message", "移除成功");
            
        } catch (Exception e) {
            log.error("移除群成员失败", e);
            result.put("code", 500);
            result.put("message", "移除失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 设置管理员
     */
    @PostMapping("/admin/set")
    public Map<String, Object> setAdmin(
            @RequestParam Long groupId,
            @RequestParam Long operatorId,
            @RequestParam Long memberId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            chatGroupService.setAdmin(groupId, operatorId, memberId);
            
            result.put("code", 200);
            result.put("message", "设置成功");
            
        } catch (Exception e) {
            log.error("设置管理员失败", e);
            result.put("code", 500);
            result.put("message", "设置失败：" + e.getMessage());
        }
        
        return result;
    }
}

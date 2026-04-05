package com.pdd.mall.controller;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.service.ChatMessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 聊天 REST API 控制器 (增强版)
 */
@RestController
@RequestMapping("/api/chat/v2")
public class ChatRestController {
    
    private static final Logger log = LoggerFactory.getLogger(ChatRestController.class);
    
    @Autowired
    private ChatMessageService chatMessageService;
    
    /**
     * 获取会话消息列表
     * 
     * @param sessionId 会话 ID
     * @param page 页码
     * @param size 每页数量
     * @return 消息列表
     */
    @GetMapping("/messages/{sessionId}")
    public Map<String, Object> getMessages(
            @PathVariable String sessionId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "50") int size) {
        try {
            log.info("获取会话消息：sessionId={}, page={}, size={}", sessionId, page, size);
            
            List<ChatMessage> messages = chatMessageService.getSessionMessages(sessionId, page, size);
            
            Map<String, Object> response = new HashMap<>();
            response.put("code", 200);
            response.put("message", "success");
            response.put("data", messages);
            return response;
        } catch (Exception e) {
            log.error("获取会话消息失败", e);
            Map<String, Object> error = new HashMap<>();
            error.put("code", 500);
            error.put("message", "获取消息失败");
            return error;
        }
    }
    
    /**
     * 获取单条消息详情
     * 
     * @param messageId 消息 ID
     * @return 消息详情
     */
    @GetMapping("/messages/detail/{messageId}")
    public Map<String, Object> getMessageDetail(@PathVariable String messageId) {
        try {
            log.info("获取消息详情：messageId={}", messageId);
            
            ChatMessage message = chatMessageService.getMessageByMessageId(messageId);
            
            Map<String, Object> response = new HashMap<>();
            if (message == null) {
                response.put("code", 404);
                response.put("message", "消息不存在");
            } else {
                response.put("code", 200);
                response.put("message", "success");
                response.put("data", message);
            }
            return response;
        } catch (Exception e) {
            log.error("获取消息详情失败", e);
            Map<String, Object> error = new HashMap<>();
            error.put("code", 500);
            error.put("message", "获取消息失败");
            return error;
        }
    }
    
    /**
     * 标记消息已读
     * 
     * @param messageId 消息 ID
     * @return 操作结果
     */
    @PostMapping("/messages/{messageId}/read")
    public Map<String, Object> markMessageRead(@PathVariable String messageId) {
        try {
            log.info("标记消息已读：messageId={}", messageId);
            
            boolean success = chatMessageService.markMessageAsRead(messageId);
            
            Map<String, Object> response = new HashMap<>();
            if (success) {
                response.put("code", 200);
                response.put("message", "success");
            } else {
                response.put("code", 500);
                response.put("message", "标记失败");
            }
            return response;
        } catch (Exception e) {
            log.error("标记消息已读失败", e);
            Map<String, Object> error = new HashMap<>();
            error.put("code", 500);
            error.put("message", "标记失败");
            return error;
        }
    }
    
    /**
     * 撤回消息
     * 
     * @param messageId 消息 ID
     * @return 操作结果
     */
    @PostMapping("/messages/{messageId}/recall")
    public Map<String, Object> recallMessage(@PathVariable String messageId) {
        try {
            log.info("撤回消息：messageId={}", messageId);
            
            boolean success = chatMessageService.recallMessage(messageId);
            
            Map<String, Object> response = new HashMap<>();
            if (success) {
                response.put("code", 200);
                response.put("message", "success");
            } else {
                response.put("code", 500);
                response.put("message", "撤回失败");
            }
            return response;
        } catch (Exception e) {
            log.error("撤回消息失败", e);
            Map<String, Object> error = new HashMap<>();
            error.put("code", 500);
            error.put("message", "撤回失败");
            return error;
        }
    }
    
    /**
     * 删除消息
     * 
     * @param messageId 消息 ID
     * @return 操作结果
     */
    @DeleteMapping("/messages/{messageId}")
    public Map<String, Object> deleteMessage(@PathVariable String messageId) {
        try {
            log.info("删除消息：messageId={}", messageId);
            
            boolean success = chatMessageService.deleteMessage(messageId);
            
            Map<String, Object> response = new HashMap<>();
            if (success) {
                response.put("code", 200);
                response.put("message", "success");
            } else {
                response.put("code", 500);
                response.put("message", "删除失败");
            }
            return response;
        } catch (Exception e) {
            log.error("删除消息失败", e);
            Map<String, Object> error = new HashMap<>();
            error.put("code", 500);
            error.put("message", "删除失败");
            return error;
        }
    }
}

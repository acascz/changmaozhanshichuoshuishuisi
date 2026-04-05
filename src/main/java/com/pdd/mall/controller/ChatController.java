package com.pdd.mall.controller;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.service.ChatMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chat")
@CrossOrigin
public class ChatController {

    @Autowired
    private ChatMessageService chatMessageService;

    @GetMapping("/sessions")
    public ResponseEntity<?> getSessions(@RequestParam(required = false) Long userId) {
        try {
            // 如果没有传 userId，从 session 中获取
            if (userId == null) {
                Long sessionUserId = (Long) getSessionAttribute("userId");
                if (sessionUserId != null) {
                    userId = sessionUserId;
                } else {
                    // 默认使用用户 ID 1
                    userId = 1L;
                }
            }
            
            List<Map<String, Object>> sessions = chatMessageService.getUserSessions(userId);
            return ResponseEntity.ok(Map.of(
                "code", 200,
                "data", sessions,
                "message", "success"
            ));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of(
                "code", 500,
                "data", null,
                "message", "获取会话列表失败：" + e.getMessage()
            ));
        }
    }

    @GetMapping("/messages/{sessionId}")
    public List<ChatMessage> getMessages(@PathVariable String sessionId) {
        return chatMessageService.getSessionMessages(sessionId, 1, 50);
    }

    @PostMapping("/send")
    public ChatMessage sendMessage(@RequestBody Map<String, Object> params) {
        String sessionId = params.get("sessionId").toString();
        Long senderId = Long.valueOf(params.get("senderId").toString());
        Long receiverId = Long.valueOf(params.get("receiverId").toString());
        String content = params.get("content").toString();
        Integer messageType = Integer.valueOf(params.get("messageType").toString());
        
        return chatMessageService.sendMessage(sessionId, senderId, receiverId, content, messageType);
    }
    
    @PostMapping("/delete/{messageId}")
    public ResponseEntity<?> deleteMessage(@PathVariable Long messageId) {
        try {
            chatMessageService.deleteMessage(messageId);
            return ResponseEntity.ok(Map.of(
                "code", 200,
                "message", "success"
            ));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of(
                "code", 500,
                "message", "删除消息失败：" + e.getMessage()
            ));
        }
    }
    
    @PostMapping("/delete-batch")
    public ResponseEntity<?> deleteBatchMessages(@RequestBody Map<String, Object> params) {
        try {
            List<Long> messageIds = (List<Long>) params.get("messageIds");
            if (messageIds == null || messageIds.isEmpty()) {
                return ResponseEntity.ok(Map.of(
                    "code", 400,
                    "message", "消息 ID 列表不能为空"
                ));
            }
            
            chatMessageService.deleteBatchMessages(messageIds);
            return ResponseEntity.ok(Map.of(
                "code", 200,
                "message", "success"
            ));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of(
                "code", 500,
                "message", "批量删除消息失败：" + e.getMessage()
            ));
        }
    }
    
    @PostMapping("/recall/{messageId}")
    public ResponseEntity<?> recallMessage(@PathVariable Long messageId) {
        try {
            chatMessageService.recallMessage(messageId);
            return ResponseEntity.ok(Map.of(
                "code", 200,
                "message", "success"
            ));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of(
                "code", 500,
                "message", "撤回消息失败：" + e.getMessage()
            ));
        }
    }
    
    // 辅助方法：从 session 获取属性
    private Object getSessionAttribute(String key) {
        try {
            org.springframework.web.context.request.RequestAttributes requestAttributes = 
                org.springframework.web.context.request.RequestContextHolder.getRequestAttributes();
            if (requestAttributes != null) {
                return requestAttributes.getAttribute(key, 
                    org.springframework.web.context.request.RequestAttributes.SCOPE_SESSION);
            }
        } catch (Exception e) {
            // 忽略异常
        }
        return null;
    }
}

package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.entity.ChatSession;
import com.pdd.mall.service.AiChatService;
import com.pdd.mall.service.ChatSessionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * AI 聊天 REST API 控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/ai")
public class AiChatController {

    @Autowired
    private AiChatService aiChatService;

    @Autowired
    private ChatSessionService chatSessionService;

    /**
     * 获取或创建 AI 会话
     */
    @PostMapping("/session")
    public Result<Map<String, Object>> getOrCreateAiSession(HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            // 获取或创建 AI 会话
            ChatSession session = chatSessionService.getOrCreateAiSession(userId);

            Map<String, Object> result = new HashMap<>();
            result.put("sessionId", session.getSessionId());
            result.put("sessionName", session.getTitle());
            result.put("sessionAvatar", "");
            result.put("isTop", 0);

            return Result.success(result);

        } catch (Exception e) {
            log.error("获取 AI 会话失败", e);
            return Result.error("获取 AI 会话失败：" + e.getMessage());
        }
    }

    /**
     * 发送 AI 消息
     */
    @PostMapping("/chat")
    public Result<Map<String, Object>> chat(@RequestBody Map<String, String> request,
                                           HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            // 获取参数
            String sessionId = request.get("sessionId");
            String question = request.get("question");

            if (sessionId == null || sessionId.isEmpty()) {
                return Result.error("会话 ID 不能为空");
            }

            if (question == null || question.isEmpty()) {
                return Result.error("问题不能为空");
            }

            // AI 对话
            ChatMessage aiMessage = aiChatService.chat(userId, sessionId, question);

            Map<String, Object> result = new HashMap<>();
            result.put("messageId", aiMessage.getMessageId());
            result.put("content", aiMessage.getContent());
            result.put("messageType", aiMessage.getMessageType());
            result.put("createTime", aiMessage.getCreateTime());

            return Result.success(result);

        } catch (Exception e) {
            log.error("AI 对话失败", e);
            return Result.error("AI 对话失败：" + e.getMessage());
        }
    }

    /**
     * 获取 AI 对话历史
     */
    @GetMapping("/history")
    public Result<Map<String, Object>> getHistory(@RequestParam String sessionId,
                                                  @RequestParam(defaultValue = "1") Integer page,
                                                  @RequestParam(defaultValue = "20") Integer size,
                                                  HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            // 获取对话历史（注：功能待实现）
            Map<String, Object> result = new HashMap<>();
            result.put("messages", new java.util.ArrayList<>());
            result.put("total", 0);
            result.put("hasMore", false);

            return Result.success(result);

        } catch (Exception e) {
            log.error("获取对话历史失败", e);
            return Result.error("获取对话历史失败：" + e.getMessage());
        }
    }

    /**
     * 清除 AI 对话历史
     */
    @PostMapping("/clear")
    public Result<Void> clearHistory(@RequestBody Map<String, String> request,
                                     HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            String sessionId = request.get("sessionId");
            if (sessionId == null || sessionId.isEmpty()) {
                return Result.error("会话 ID 不能为空");
            }

            // 清除对话历史
            aiChatService.clearContext(userId, sessionId);

            return Result.success(null);

        } catch (Exception e) {
            log.error("清除对话历史失败", e);
            return Result.error("清除对话历史失败：" + e.getMessage());
        }
    }

    /**
     * 查询物流（AI 专用接口）
     */
    @GetMapping("/logistics")
    public Result<Map<String, Object>> queryLogistics(@RequestParam String orderNo,
                                                      HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            // 查询物流
            Map<String, Object> result = aiChatService.queryLogistics(userId, orderNo);
            return Result.success(result);

        } catch (Exception e) {
            log.error("查询物流失败", e);
            return Result.error("查询物流失败：" + e.getMessage());
        }
    }

    /**
     * 查询订单（AI 专用接口）
     */
    @GetMapping("/order")
    public Result<Map<String, Object>> queryOrder(@RequestParam Long orderId,
                                                  HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            // 查询订单
            Map<String, Object> result = aiChatService.queryOrder(userId, orderId);
            return Result.success(result);

        } catch (Exception e) {
            log.error("查询订单失败", e);
            return Result.error("查询订单失败：" + e.getMessage());
        }
    }

    /**
     * 智能推荐（AI 专用接口）
     */
    @GetMapping("/recommend")
    public Result<Map<String, Object>> recommend(@RequestParam(defaultValue = "5") Integer limit,
                                                 HttpSession httpSession) {
        try {
            // 获取当前用户
            Long userId = getCurrentUserId(httpSession);
            if (userId == null) {
                return Result.error("请先登录");
            }

            // 智能推荐
            Map<String, Object> result = aiChatService.recommendProducts(userId, limit);
            return Result.success(result);

        } catch (Exception e) {
            log.error("智能推荐失败", e);
            return Result.error("智能推荐失败：" + e.getMessage());
        }
    }

    /**
     * 获取当前用户 ID
     */
    private Long getCurrentUserId(HttpSession session) {
        Object userObj = session.getAttribute("user");
        if (userObj != null) {
            // 假设用户对象有 getId() 方法
            try {
                return (Long) userObj.getClass().getMethod("getId").invoke(userObj);
            } catch (Exception e) {
                log.error("获取用户 ID 失败", e);
            }
        }
        return null;
    }
}

package com.pdd.mall.service.impl;

import com.pdd.mall.entity.AiAccessLog;
import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.entity.ChatSession;
import com.pdd.mall.entity.LogisticsTrack;
import com.pdd.mall.entity.Orders;
import com.pdd.mall.entity.UserBrowseHistory;
import com.pdd.mall.service.AiAccessLogService;
import com.pdd.mall.service.AiChatService;
import com.pdd.mall.service.AIDataAccessTokenService;
import com.pdd.mall.service.ChatMessageService;
import com.pdd.mall.service.ChatSessionService;
import com.pdd.mall.service.LogisticsTrackService;
import com.pdd.mall.service.OrdersService;
import com.pdd.mall.service.UserBrowseHistoryService;
import com.pdd.mall.util.AiContextManager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;

/**
 * AI 智能对话服务实现
 */
@Slf4j
@Service
public class AiChatServiceImpl implements AiChatService {

    @Autowired
    private ChatMessageService chatMessageService;

    @Autowired
    private ChatSessionService chatSessionService;

    @Autowired
    private AIDataAccessTokenService aiDataAccessTokenService;

    @Autowired
    private AiAccessLogService aiAccessLogService;

    @Autowired
    private LogisticsTrackService logisticsTrackService;

    @Autowired
    private OrdersService ordersService;

    @Autowired
    private AiContextManager aiContextManager;

    @Autowired
    private UserBrowseHistoryService userBrowseHistoryService;

    // 官方 AI 用户 ID（固定值）
    private static final Long OFFICIAL_AI_USER_ID = 0L;

    // AI 服务标识
    private static final String AI_SERVICE_NAME = "AI_CHAT";

    @Override
    @Transactional
    public ChatMessage chat(Long userId, String sessionId, String question) {
        try {
            log.info("AI 对话开始：userId={}, sessionId={}, question={}", userId, sessionId, question);

            // 1. 验证会话是否存在
            ChatSession session = chatSessionService.getSessionBySessionId(sessionId);
            if (session == null) {
                throw new RuntimeException("会话不存在");
            }

            // 2. 记录用户问题
            saveUserMessage(userId, sessionId, question);

            // 3. 意图识别
            String intent = recognizeIntent(question);
            log.info("意图识别结果：intent={}", intent);

            // 4. 根据意图处理
            String aiResponse;
            Map<String, Object> accessedData = new HashMap<>();

            switch (intent) {
                case "LOGISTICS":
                    // 查询物流
                    String orderNo = extractOrderNo(question);
                    if (orderNo != null) {
                        Map<String, Object> logisticsData = queryLogistics(userId, orderNo);
                        accessedData.put("logistics", logisticsData);
                        aiResponse = formatLogisticsResponse(logisticsData);
                    } else {
                        aiResponse = "请问您想查询哪个订单的物流信息呢？可以提供订单号哦~";
                    }
                    break;

                case "ORDER":
                    // 查询订单
                    Long orderId = extractOrderId(question);
                    if (orderId != null) {
                        Map<String, Object> orderData = queryOrder(userId, orderId);
                        accessedData.put("order", orderData);
                        aiResponse = formatOrderResponse(orderData);
                    } else {
                        aiResponse = "请问您想查询哪个订单的信息呢？";
                    }
                    break;

                case "RECOMMEND":
                    // 智能推荐
                    Map<String, Object> recommendData = recommendProducts(userId, 5);
                    accessedData.put("recommend", recommendData);
                    aiResponse = formatRecommendResponse(recommendData);
                    break;

                case "GREETING":
                    aiResponse = "您好！我是您的智能购物助手，有什么可以帮您的吗？😊";
                    break;

                default:
                    // 通用对话
                    aiResponse = generateGeneralResponse(question);
            }

            // 5. 保存 AI 回答
            ChatMessage aiMessage = saveAiMessage(userId, sessionId, aiResponse, null);

            // 6. 记录到上下文管理器
            aiContextManager.addMessage(userId, sessionId, question, aiResponse);

            // 7. 记录访问日志（如果有数据访问）
            if (!accessedData.isEmpty()) {
                logAiAccess(userId, sessionId, question, intent, accessedData, aiResponse);
            }

            log.info("AI 对话完成：userId={}, messageId={}", userId, aiMessage.getMessageId());
            return aiMessage;

        } catch (Exception e) {
            log.error("AI 对话失败", e);
            throw new RuntimeException("AI 对话失败：" + e.getMessage());
        }
    }

    @Override
    public ChatMessage chatWithContext(Long userId, String sessionId, String question, Map<String, Object> context) {
        // 使用上下文管理器实现上下文对话
        try {
            log.info("AI 带上下文对话开始：userId={}, sessionId={}, question={}", userId, sessionId, question);

            // 1. 验证会话
            ChatSession session = chatSessionService.getSessionBySessionId(sessionId);
            if (session == null) {
                throw new RuntimeException("会话不存在");
            }

            // 2. 记录用户问题
            saveUserMessage(userId, sessionId, question);

            // 3. 获取历史上下文
            List<Map<String, String>> history = aiContextManager.getHistory(userId, sessionId, 10);
            
            // 4. 意图识别（考虑上下文）
            String intent = recognizeIntentWithContext(question, history);
            log.info("意图识别结果（带上下文）：intent={}", intent);

            // 5. 根据意图处理
            String aiResponse;
            Map<String, Object> accessedData = new HashMap<>();

            switch (intent) {
                case "LOGISTICS":
                    String orderNo = extractOrderNo(question);
                    if (orderNo != null) {
                        Map<String, Object> logisticsData = queryLogistics(userId, orderNo);
                        accessedData.put("logistics", logisticsData);
                        aiResponse = formatLogisticsResponse(logisticsData);
                    } else {
                        aiResponse = "请问您想查询哪个订单的物流信息呢？可以提供订单号哦~";
                    }
                    break;

                case "ORDER":
                    Long orderId = extractOrderId(question);
                    if (orderId != null) {
                        Map<String, Object> orderData = queryOrder(userId, orderId);
                        accessedData.put("order", orderData);
                        aiResponse = formatOrderResponse(orderData);
                    } else {
                        aiResponse = "请问您想查询哪个订单的信息呢？";
                    }
                    break;

                case "RECOMMEND":
                    Map<String, Object> recommendData = recommendProducts(userId, 5);
                    accessedData.put("recommend", recommendData);
                    aiResponse = formatRecommendResponse(recommendData);
                    break;

                case "GREETING":
                    aiResponse = "您好！我是您的智能购物助手，有什么可以帮您的吗？😊";
                    break;

                default:
                    // 通用对话（考虑上下文）
                    aiResponse = generateContextualResponse(question, history);
            }

            // 6. 保存 AI 回答
            ChatMessage aiMessage = saveAiMessage(userId, sessionId, aiResponse, null);

            // 7. 记录到上下文管理器
            aiContextManager.addMessage(userId, sessionId, question, aiResponse);

            // 8. 记录访问日志
            if (!accessedData.isEmpty()) {
                logAiAccess(userId, sessionId, question, intent, accessedData, aiResponse);
            }

            log.info("AI 带上下文对话完成：userId={}, messageId={}", userId, aiMessage.getMessageId());
            return aiMessage;

        } catch (Exception e) {
            log.error("AI 带上下文对话失败", e);
            throw new RuntimeException("AI 对话失败：" + e.getMessage());
        }
    }

    @Override
    public Map<String, Object> queryLogistics(Long userId, String orderNo) {
        try {
            // 使用令牌访问物流信息
            aiDataAccessTokenService.generateToken(
                userId,
                "ai_session",
                "default_device",
                "logistics",
                new String[]{"orderNo"}
            );

            // 调用物流查询接口（根据订单号查询物流单号，再查询轨迹）
            log.info("AI 查询物流：userId={}, orderNo={}", userId, orderNo);
            
            // 先查询订单获取物流单号（注：实际应该从订单表获取物流单号）
            Orders order = ordersService.getOrderById(Long.parseLong(orderNo));
            if (order == null) {
                return Collections.singletonMap("error", "订单不存在");
            }
            
            // 根据订单 ID 查询物流轨迹
            LogisticsTrack track = logisticsTrackService.getTrackByOrderId(order.getId());
            
            Map<String, Object> result = new HashMap<>();
            if (track != null) {
                result.put("logisticsNo", track.getLogisticsNo());
                result.put("orderId", track.getOrderId());
                result.put("trackContent", track.getTrackContent());
                result.put("trackStatus", track.getTrackStatus());
                result.put("trackLocation", track.getTrackLocation());
                result.put("trackTime", track.getTrackTime());
                result.put("courierName", track.getCourierName());
                result.put("courierPhone", track.getCourierPhone());
                result.put("status", "运输中");
            } else {
                result.put("error", "未找到物流信息");
            }
            
            log.info("AI 查询物流成功：userId={}, orderNo={}", userId, orderNo);
            return result;

        } catch (NumberFormatException e) {
            log.error("订单号格式错误：orderNo={}", orderNo, e);
            return Collections.singletonMap("error", "订单号格式错误");
        } catch (Exception e) {
            log.error("AI 查询物流失败：userId={}, orderNo={}", userId, orderNo, e);
            return Collections.singletonMap("error", "物流信息查询失败");
        }
    }

    @Override
    public Map<String, Object> queryOrder(Long userId, Long orderId) {
        try {
            // 使用令牌访问订单信息
            aiDataAccessTokenService.generateToken(
                userId,
                "ai_session",
                "default_device",
                "order",
                new String[]{"orderId"}
            );

            // 调用订单查询接口
            Orders order = ordersService.getOrderById(orderId);

            log.info("AI 查询订单成功：userId={}, orderId={}", userId, orderId);
            if (order != null) {
                Map<String, Object> result = new HashMap<>();
                result.put("id", order.getId());
                result.put("orderNo", order.getOrderNo());
                result.put("userId", order.getUserId());
                result.put("totalAmount", order.getTotalAmount());
                result.put("status", order.getStatus());
                return result;
            } else {
                return Collections.singletonMap("error", "订单不存在");
            }

        } catch (Exception e) {
            log.error("AI 查询订单失败：userId={}, orderId={}", userId, orderId, e);
            return Collections.singletonMap("error", "订单信息查询失败");
        }
    }

    @Override
    public Map<String, Object> queryBrowseHistory(Long userId, Integer limit) {
        try {
            log.info("查询用户浏览记录：userId={}, limit={}", userId, limit);
            
            if (limit == null || limit < 1) {
                limit = 10;
            }
            
            // 查询用户最近的浏览记录
            List<UserBrowseHistory> historyList = userBrowseHistoryService.getRecentHistory(userId, limit);
            
            Map<String, Object> result = new HashMap<>();
            result.put("history", historyList);
            result.put("total", historyList.size());
            
            return result;
            
        } catch (Exception e) {
            log.error("查询浏览记录失败", e);
            Map<String, Object> result = new HashMap<>();
            result.put("history", new ArrayList<>());
            result.put("error", "查询失败");
            return result;
        }
    }

    @Override
    public Map<String, Object> recommendProducts(Long userId, Integer limit) {
        try {
            log.info("智能推荐商品：userId={}, limit={}", userId, limit);
            
            if (limit == null || limit < 1) {
                limit = 5;
            }
            
            // 使用 AiDataGateway 实现智能推荐
            // 注：这里应该调用 AiDataGateway，但为了避免循环依赖，直接实现简化版推荐
            Map<String, Object> result = new HashMap<>();
            List<Map<String, Object>> products = new ArrayList<>();
            
            // 1. 获取用户浏览记录
            List<UserBrowseHistory> browseHistory = userBrowseHistoryService.getRecentHistory(userId, 20);
            
            if (!browseHistory.isEmpty()) {
                // 2. 统计用户偏好的商品分类（使用 categoryName）
                Map<String, Integer> categoryPreferences = new HashMap<>();
                for (UserBrowseHistory history : browseHistory) {
                    String categoryName = history.getCategoryName();
                    if (categoryName != null && !categoryName.isEmpty()) {
                        categoryPreferences.put(categoryName, categoryPreferences.getOrDefault(categoryName, 0) + 1);
                    }
                }
                
                // 3. 根据偏好分类推荐商品
                List<Map.Entry<String, Integer>> sortedCategories = new ArrayList<>(categoryPreferences.entrySet());
                sortedCategories.sort((a, b) -> b.getValue() - a.getValue());
                
                int recommendedCount = 0;
                Set<Long> recommendedProductIds = new HashSet<>();
                
                for (Map.Entry<String, Integer> category : sortedCategories) {
                    if (recommendedCount >= limit) {
                        break;
                    }
                    
                    // 从浏览记录中找出该分类的商品进行推荐
                    for (UserBrowseHistory history : browseHistory) {
                        if (category.getKey().equals(history.getCategoryName()) && 
                            !recommendedProductIds.contains(history.getProductId())) {
                            
                            Map<String, Object> product = new HashMap<>();
                            product.put("id", history.getProductId());
                            product.put("name", history.getProductName());
                            product.put("price", history.getProductPrice());
                            product.put("image", history.getProductImage());
                            product.put("categoryName", history.getCategoryName());
                            product.put("reason", "您浏览过的商品");
                            
                            products.add(product);
                            recommendedProductIds.add(history.getProductId());
                            recommendedCount++;
                            
                            if (recommendedCount >= limit) {
                                break;
                            }
                        }
                    }
                }
            }
            
            // 4. 如果推荐数量不足，补充热门商品（简化实现）
            if (products.size() < limit) {
                int supplementCount = limit - products.size();
                for (int i = 1; i <= supplementCount; i++) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("id", (long) (1000 + i));
                    product.put("name", "热门商品" + i);
                    product.put("price", new BigDecimal("99.00").multiply(BigDecimal.valueOf(i)));
                    product.put("image", "/images/product" + i + ".jpg");
                    product.put("reason", "热门商品推荐");
                    products.add(product);
                }
            }
            
            result.put("products", products);
            result.put("total", products.size());
            
            log.info("智能推荐完成：userId={}, recommendCount={}", userId, products.size());
            return result;
            
        } catch (Exception e) {
            log.error("智能推荐失败", e);
            Map<String, Object> result = new HashMap<>();
            result.put("products", new ArrayList<>());
            result.put("error", "推荐失败");
            return result;
        }
    }

    @Override
    @Transactional
    public void clearContext(Long userId, String sessionId) {
        try {
            // 清除上下文管理器中的上下文
            aiContextManager.clearContext(userId, sessionId);
            
            // 可选：清除数据库中的历史消息（如果需要）
            // chatMessageService.deleteBySessionId(sessionId);
            
            log.info("清除 AI 上下文成功：userId={}, sessionId={}", userId, sessionId);
            
        } catch (Exception e) {
            log.error("清除 AI 上下文失败", e);
            throw new RuntimeException("清除上下文失败：" + e.getMessage());
        }
    }

    @Override
    public Map<String, Object> getChatHistory(Long userId, String sessionId, Integer limit) {
        try {
            log.info("获取对话历史：userId={}, sessionId={}, limit={}", userId, sessionId, limit);
            
            if (limit == null || limit < 1) {
                limit = 20;
            }
            
            // 从上下文管理器获取历史对话（现在支持 Redis 持久化）
            List<Map<String, String>> messages = aiContextManager.getHistory(userId, sessionId, limit);
            
            Map<String, Object> result = new HashMap<>();
            result.put("messages", messages);
            result.put("total", messages.size());
            result.put("hasMore", messages.size() == limit);
            
            log.info("获取对话历史成功：userId={}, sessionId={}, messageCount={}", userId, sessionId, messages.size());
            return result;
            
        } catch (Exception e) {
            log.error("获取对话历史失败", e);
            Map<String, Object> result = new HashMap<>();
            result.put("messages", new ArrayList<>());
            result.put("error", "获取失败");
            return result;
        }
    }

    // ==================== 私有方法 ====================

    /**
     * 意图识别（带上下文）
     */
    private String recognizeIntentWithContext(String question, List<Map<String, String>> history) {
        // 首先尝试直接识别
        String intent = recognizeIntent(question);
        
        // 如果是通用意图，尝试从上下文推断
        if ("GENERAL".equals(intent) && history != null && !history.isEmpty()) {
            // 查看最近的对话意图
            for (int i = history.size() - 1; i >= 0; i--) {
                Map<String, String> message = history.get(i);
                if ("assistant".equals(message.get("role"))) {
                    String content = message.get("content");
                    if (content.contains("物流")) {
                        return "LOGISTICS";
                    }
                    if (content.contains("订单")) {
                        return "ORDER";
                    }
                }
            }
        }
        
        return intent;
    }

    /**
     * 生成带上下文的响应
     */
    private String generateContextualResponse(String question, List<Map<String, String>> history) {
        // 注：未来可集成大模型 API，使用上下文生成更智能的响应
        // 暂时返回通用响应
        return generateGeneralResponse(question);
    }

    /**
     * 意图识别
     */
    private String recognizeIntent(String question) {
        String q = question.toLowerCase();

        if (q.contains("物流") || q.contains("快递") || q.contains("运输") || q.contains("配送")) {
            return "LOGISTICS";
        }

        if (q.contains("订单") || q.contains("购买") || q.contains("下单")) {
            return "ORDER";
        }

        if (q.contains("推荐") || q.contains("介绍") || q.contains("有什么")) {
            return "RECOMMEND";
        }

        if (q.contains("你好") || q.contains("您好") || q.contains("hello") || q.contains("hi")) {
            return "GREETING";
        }

        return "GENERAL";
    }

    /**
     * 提取订单号
     */
    private String extractOrderNo(String question) {
        // 简单实现：匹配数字
        String regex = "\\d{10,20}";
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(regex);
        java.util.regex.Matcher matcher = pattern.matcher(question);
        return matcher.find() ? matcher.group() : null;
    }

    /**
     * 提取订单 ID
     */
    private Long extractOrderId(String question) {
        String orderNo = extractOrderNo(question);
        return orderNo != null ? Long.parseLong(orderNo) : null;
    }

    /**
     * 保存用户消息
     */
    private void saveUserMessage(Long userId, String sessionId, String content) {
        chatMessageService.sendMessage(sessionId, userId, OFFICIAL_AI_USER_ID, content, 1);
    }

    /**
     * 保存 AI 回答
     */
    private ChatMessage saveAiMessage(Long userId, String sessionId, String content, Long replyToMessageId) {
        return chatMessageService.sendMessage(sessionId, OFFICIAL_AI_USER_ID, userId, content, 1);
    }

    /**
     * 格式化物流响应
     */
    @SuppressWarnings("unchecked")
    private String formatLogisticsResponse(Map<String, Object> logisticsData) {
        if (logisticsData.containsKey("error")) {
            return "抱歉，物流信息查询失败，请稍后再试。";
        }

        StringBuilder response = new StringBuilder();
        response.append("📦 物流信息\n\n");

        String status = (String) logisticsData.get("status");
        response.append("状态：").append(status).append("\n\n");

        List<Map<String, Object>> tracks = (List<Map<String, Object>>) logisticsData.get("tracks");
        if (tracks != null && !tracks.isEmpty()) {
            response.append("最新轨迹：\n");
            Map<String, Object> latestTrack = tracks.get(0);
            response.append(latestTrack.get("time")).append(" - ").append(latestTrack.get("desc"));
        }

        return response.toString();
    }

    /**
     * 格式化订单响应
     */
    private String formatOrderResponse(Map<String, Object> orderData) {
        if (orderData.containsKey("error")) {
            return "抱歉，订单信息查询失败，请稍后再试。";
        }

        StringBuilder response = new StringBuilder();
        response.append("🛒 订单信息\n\n");

        String orderNo = (String) orderData.get("orderNo");
        response.append("订单号：").append(orderNo).append("\n");

        BigDecimal amount = (BigDecimal) orderData.get("amount");
        response.append("金额：¥").append(amount).append("\n");

        Integer status = (Integer) orderData.get("status");
        response.append("状态：").append(getOrderStatusText(status)).append("\n");

        return response.toString();
    }

    /**
     * 格式化推荐响应
     */
    @SuppressWarnings("unchecked")
    private String formatRecommendResponse(Map<String, Object> recommendData) {
        List<?> products = (List<?>) recommendData.get("products");
        if (products == null || products.isEmpty()) {
            return "根据您的喜好，为您推荐以下商品：\n\n暂无推荐商品，您可以浏览更多商品哦~";
        }

        StringBuilder response = new StringBuilder();
        response.append("✨ 为您推荐\n\n");

        for (int i = 0; i < Math.min(products.size(), 3); i++) {
            Map<String, Object> product = (Map<String, Object>) products.get(i);
            response.append(i + 1).append(". ").append(product.get("name"))
                    .append(" - ¥").append(product.get("price")).append("\n");
        }

        return response.toString();
    }

    /**
     * 生成通用响应
     */
    private String generateGeneralResponse(String question) {
        // 注：未来可集成大模型 API
        return "您好！我是您的智能购物助手。我可以帮您查询订单、物流信息，或者为您推荐商品。\n\n请问有什么可以帮您的吗？😊";
    }

    /**
     * 获取订单状态文本
     */
    private String getOrderStatusText(Integer status) {
        switch (status) {
            case 1: return "待付款";
            case 2: return "待发货";
            case 3: return "待收货";
            case 4: return "已完成";
            case 5: return "已取消";
            default: return "未知状态";
        }
    }

    /**
     * 记录 AI 访问日志
     */
    private void logAiAccess(Long userId, String sessionId, String question, 
                            String intent, Map<String, Object> accessedData, String response) {
        try {
            AiAccessLog accessLog = new AiAccessLog();
            accessLog.setUserId(userId);
            accessLog.setSessionId(sessionId);
            accessLog.setAiService(AI_SERVICE_NAME);
            accessLog.setUserQuestion(question);
            accessLog.setIntent(intent);
            accessLog.setDataType(accessedData.keySet().toString());
            accessLog.setAccessedFields(accessedData.toString());
            accessLog.setAccessResult("success");
            accessLog.setResponseContent(response);
            
            aiAccessLogService.logAccess(accessLog);
        } catch (Exception e) {
            log.error("记录 AI 访问日志失败", e);
        }
    }
}

package com.pdd.mall.service;

import com.pdd.mall.entity.ChatMessage;
import java.util.Map;

/**
 * AI 智能对话服务
 * 负责与 AI 大模型交互，提供智能问答能力
 */
public interface AiChatService {

    /**
     * AI 对话 - 发送问题获取 AI 回答
     * 
     * @param userId 用户 ID
     * @param sessionId AI 会话 ID
     * @param question 用户问题
     * @return AI 回答消息
     */
    ChatMessage chat(Long userId, String sessionId, String question);

    /**
     * AI 对话 - 带上下文的连续对话
     * 
     * @param userId 用户 ID
     * @param sessionId AI 会话 ID
     * @param question 用户问题
     * @param context 上下文信息
     * @return AI 回答消息
     */
    ChatMessage chatWithContext(Long userId, String sessionId, String question, Map<String, Object> context);

    /**
     * 查询物流信息（AI 专用接口）
     * 
     * @param userId 用户 ID
     * @param orderNo 订单号
     * @return 物流信息
     */
    Map<String, Object> queryLogistics(Long userId, String orderNo);

    /**
     * 查询订单信息（AI 专用接口）
     * 
     * @param userId 用户 ID
     * @param orderId 订单 ID
     * @return 订单信息
     */
    Map<String, Object> queryOrder(Long userId, Long orderId);

    /**
     * 查询用户浏览记录（AI 专用接口）
     * 
     * @param userId 用户 ID
     * @param limit 返回数量限制
     * @return 浏览记录
     */
    Map<String, Object> queryBrowseHistory(Long userId, Integer limit);

    /**
     * 智能推荐商品（AI 专用接口）
     * 
     * @param userId 用户 ID
     * @param limit 推荐数量
     * @return 推荐商品列表
     */
    Map<String, Object> recommendProducts(Long userId, Integer limit);

    /**
     * 清除 AI 上下文
     * 
     * @param userId 用户 ID
     * @param sessionId AI 会话 ID
     */
    void clearContext(Long userId, String sessionId);

    /**
     * 获取 AI 对话历史
     * 
     * @param userId 用户 ID
     * @param sessionId AI 会话 ID
     * @param limit 返回数量
     * @return 对话历史
     */
    Map<String, Object> getChatHistory(Long userId, String sessionId, Integer limit);
}

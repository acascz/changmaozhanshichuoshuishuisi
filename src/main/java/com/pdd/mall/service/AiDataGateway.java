package com.pdd.mall.service;

import java.util.Map;

/**
 * AI 数据访问网关
 * 统一提供 AI 可访问的数据接口，强制用户隔离
 */
public interface AiDataGateway {

    /**
     * 查询物流信息（AI 专用）
     * 
     * @param userId 用户 ID（强制隔离）
     * @param orderNo 订单号
     * @param token 访问令牌
     * @return 物流信息
     */
    Map<String, Object> getLogistics(Long userId, String orderNo, String token);

    /**
     * 查询订单信息（AI 专用）
     * 
     * @param userId 用户 ID（强制隔离）
     * @param orderId 订单 ID
     * @param token 访问令牌
     * @return 订单信息
     */
    Map<String, Object> getOrder(Long userId, Long orderId, String token);

    /**
     * 查询浏览记录（AI 专用）
     * 
     * @param userId 用户 ID（强制隔离）
     * @param limit 返回数量
     * @param token 访问令牌
     * @return 浏览记录
     */
    Map<String, Object> getBrowseHistory(Long userId, Integer limit, String token);

    /**
     * 智能推荐商品（AI 专用）
     * 
     * @param userId 用户 ID（强制隔离）
     * @param limit 推荐数量
     * @param token 访问令牌
     * @return 推荐商品
     */
    Map<String, Object> getRecommendations(Long userId, Integer limit, String token);

    /**
     * 查询商品信息（AI 专用）
     * 
     * @param userId 用户 ID（强制隔离）
     * @param productId 商品 ID
     * @param token 访问令牌
     * @return 商品信息
     */
    Map<String, Object> getProduct(Long userId, Long productId, String token);
}

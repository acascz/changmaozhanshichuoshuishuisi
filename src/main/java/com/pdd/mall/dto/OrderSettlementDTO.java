package com.pdd.mall.dto;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 订单结算 DTO
 */
@Data
public class OrderSettlementDTO {
    
    private Long userId;
    private String orderData; // localStorage 中的订单数据 JSON
    private Long activityId; // 活动 ID
    private Integer activityType; // 活动类型
    
    // 验证签名（防止数据篡改）
    private String sign;
    
    // 时间戳（防止重放攻击）
    private Long timestamp;
}

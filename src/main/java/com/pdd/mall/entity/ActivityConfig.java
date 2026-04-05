package com.pdd.mall.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 活动配置实体
 */
@Data
public class ActivityConfig {
    private Long id;
    private String name;
    private Integer type; // 1-满减，2-折扣，3-秒杀，4-团购，5-优惠券
    private BigDecimal discountRate; // 折扣系数 (如 0.9 表示 9 折)
    private BigDecimal fixedDiscount; // 固定减免金额 (如满 100 减 20 中的 20)
    private BigDecimal minAmount; // 最低消费金额
    private Integer stackable; // 是否可叠加 (0-否，1-是)
    private Integer priority; // 优先级 (数字越小优先级越高)
    private Integer status; // 0-未开始，1-进行中，2-已结束，3-已禁用
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String description;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

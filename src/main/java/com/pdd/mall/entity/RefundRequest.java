package com.pdd.mall.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 退款申请实体
 */
@Data
public class RefundRequest {
    private Long id;
    private Long orderId;
    private Long userId;
    private BigDecimal refundAmount;
    private Integer refundType; // 1-仅退款，2-退货退款
    private Integer reason; // 退款原因
    private String description; // 退款说明
    private String images; // 凭证图片
    private Integer status; // 0-待审核，1-已同意，2-已拒绝，3-已完成
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

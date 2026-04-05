package com.pdd.mall.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 发货单实体
 */
@Data
public class DeliveryOrder {
    private Long id;
    private Long orderId;
    private String deliveryNo; // 发货单号
    private String logisticsCompany; // 物流公司
    private String logisticsNo; // 物流单号
    private String receiverName; // 收货人
    private String receiverPhone; // 收货人电话
    private String receiverAddress; // 收货地址
    private Integer status; // 0-待发货，1-已发货，2-已签收
    private LocalDateTime deliveryTime; // 发货时间
    private LocalDateTime signTime; // 签收时间
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

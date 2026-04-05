package com.pdd.mall.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 客服评价实体
 */
@Data
public class ServiceRating {
    
    /**
     * 评价 ID
     */
    private Long id;
    
    /**
     * 会话 ID
     */
    private String sessionId;
    
    /**
     * 用户 ID
     */
    private Long userId;
    
    /**
     * 客服 ID
     */
    private Long serviceId;
    
    /**
     * 评分（1-5 星）
     */
    private Integer rating;
    
    /**
     * 评价内容
     */
    private String comment;
    
    /**
     * 评价时间
     */
    private LocalDateTime createTime;
}

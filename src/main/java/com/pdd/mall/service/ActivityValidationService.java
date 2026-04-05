package com.pdd.mall.service;

import com.pdd.mall.entity.ActivityConfig;
import com.pdd.mall.mapper.ActivityConfigMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 活动验证服务
 */
@Service
@Slf4j
public class ActivityValidationService {
    
    @Autowired
    private ActivityConfigMapper activityConfigMapper;
    
    /**
     * 验证活动是否有效
     */
    public boolean validateActivity(Long activityId) {
        if (activityId == null) {
            return true; // 没有活动，返回 true
        }
        
        ActivityConfig activity = activityConfigMapper.findById(activityId);
        if (activity == null) {
            log.error("活动不存在：activityId={}", activityId);
            return false;
        }
        
        // 验证活动状态
        if (activity.getStatus() != 1) {
            log.error("活动状态异常：activityId={}, status={}", activityId, activity.getStatus());
            return false;
        }
        
        // 验证活动时间
        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(activity.getStartTime()) || now.isAfter(activity.getEndTime())) {
            log.error("活动已过期：activityId={}, startTime={}, endTime={}", 
                    activityId, activity.getStartTime(), activity.getEndTime());
            return false;
        }
        
        return true;
    }
    
    /**
     * 验证活动价格计算
     */
    public BigDecimal validateActivityPrice(Long activityId, BigDecimal originalPrice) {
        if (activityId == null || originalPrice == null) {
            return originalPrice;
        }
        
        ActivityConfig activity = activityConfigMapper.findById(activityId);
        if (activity == null || activity.getStatus() != 1) {
            return originalPrice;
        }
        
        // 使用 ActivityPriceCalculator 计算
        BigDecimal finalPrice = originalPrice;
        
        // 应用固定减免
        if (activity.getFixedDiscount() != null) {
            finalPrice = finalPrice.subtract(activity.getFixedDiscount());
        }
        
        // 应用折扣系数
        if (activity.getDiscountRate() != null) {
            finalPrice = finalPrice.multiply(activity.getDiscountRate());
        }
        
        // 确保价格不为负数
        if (finalPrice.compareTo(BigDecimal.ZERO) < 0) {
            finalPrice = BigDecimal.ZERO;
        }
        
        log.info("活动价格验证：originalPrice={}, activityId={}, finalPrice={}", 
                originalPrice, activityId, finalPrice);
        
        return finalPrice;
    }
}

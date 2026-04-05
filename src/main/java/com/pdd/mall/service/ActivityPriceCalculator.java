package com.pdd.mall.service;

import com.pdd.mall.entity.ActivityConfig;
import com.pdd.mall.mapper.ActivityConfigMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * 活动价格计算器
 */
@Service
@Slf4j
public class ActivityPriceCalculator {
    
    @Autowired
    private ActivityConfigMapper activityConfigMapper;
    
    /**
     * 计算活动价格
     * @param originalPrice 商品原价总额
     * @param activityId 活动 ID
     * @return 活动后价格
     */
    public BigDecimal calculateActivityPrice(BigDecimal originalPrice, Long activityId) {
        if (activityId == null || originalPrice == null) {
            return originalPrice;
        }
        
        ActivityConfig activity = activityConfigMapper.findById(activityId);
        if (activity == null) {
            log.warn("活动不存在：activityId={}", activityId);
            return originalPrice;
        }
        
        // 验证活动状态
        if (activity.getStatus() != 1) {
            log.warn("活动状态异常：activityId={}, status={}", activityId, activity.getStatus());
            return originalPrice;
        }
        
        // 验证活动时间
        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(activity.getStartTime()) || now.isAfter(activity.getEndTime())) {
            log.warn("活动已过期：activityId={}", activityId);
            return originalPrice;
        }
        
        // 验证最低消费金额
        if (activity.getMinAmount() != null && originalPrice.compareTo(activity.getMinAmount()) < 0) {
            log.info("未达到活动最低消费金额：originalPrice={}, minAmount={}", originalPrice, activity.getMinAmount());
            return originalPrice;
        }
        
        BigDecimal finalPrice = originalPrice;
        
        // 应用固定减免（满减、优惠券等）
        if (activity.getFixedDiscount() != null && activity.getFixedDiscount().compareTo(BigDecimal.ZERO) > 0) {
            finalPrice = finalPrice.subtract(activity.getFixedDiscount());
            log.info("应用固定减免：activityId={}, fixedDiscount={}", activityId, activity.getFixedDiscount());
        }
        
        // 应用折扣系数（折扣、团购等）
        if (activity.getDiscountRate() != null && activity.getDiscountRate().compareTo(BigDecimal.ZERO) > 0 
                && activity.getDiscountRate().compareTo(BigDecimal.ONE) < 1) {
            finalPrice = finalPrice.multiply(activity.getDiscountRate());
            log.info("应用折扣系数：activityId={}, discountRate={}", activityId, activity.getDiscountRate());
        }
        
        // 确保价格不为负数
        if (finalPrice.compareTo(BigDecimal.ZERO) < 0) {
            finalPrice = BigDecimal.ZERO;
        }
        
        // 保留两位小数
        finalPrice = finalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
        
        log.info("活动价格计算完成：originalPrice={}, activityId={}, finalPrice={}", 
                originalPrice, activityId, finalPrice);
        
        return finalPrice;
    }
    
    /**
     * 计算多个活动的价格（支持叠加）
     * @param originalPrice 商品原价总额
     * @param activityIds 活动 ID 列表
     * @return 最终价格
     */
    public BigDecimal calculateMultipleActivities(BigDecimal originalPrice, List<Long> activityIds) {
        if (activityIds == null || activityIds.isEmpty()) {
            return originalPrice;
        }
        
        List<ActivityConfig> activities = new ArrayList<>();
        for (Long activityId : activityIds) {
            ActivityConfig activity = activityConfigMapper.findById(activityId);
            if (activity != null && activity.getStatus() == 1) {
                activities.add(activity);
            }
        }
        
        // 按优先级排序
        activities.sort(Comparator.comparingInt(ActivityConfig::getPriority));
        
        BigDecimal finalPrice = originalPrice;
        
        // 依次应用每个活动
        for (ActivityConfig activity : activities) {
            // 检查是否可叠加
            if (activity.getStackable() == 0 && activities.size() > 1) {
                log.info("活动不可叠加，跳过：activityId={}", activity.getId());
                continue;
            }
            
            finalPrice = calculateActivityPrice(finalPrice, activity.getId());
        }
        
        return finalPrice;
    }
    
    /**
     * 获取活动优惠金额
     * @param originalPrice 商品原价总额
     * @param activityId 活动 ID
     * @return 优惠金额
     */
    public BigDecimal getDiscountAmount(BigDecimal originalPrice, Long activityId) {
        BigDecimal finalPrice = calculateActivityPrice(originalPrice, activityId);
        return originalPrice.subtract(finalPrice).setScale(2, BigDecimal.ROUND_HALF_UP);
    }
}

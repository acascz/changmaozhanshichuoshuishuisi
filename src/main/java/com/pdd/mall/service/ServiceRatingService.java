package com.pdd.mall.service;

import com.pdd.mall.entity.ServiceRating;
import com.pdd.mall.mapper.ServiceRatingMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 客服评价服务类
 */
@Slf4j
@Service
public class ServiceRatingService {
    
    @Autowired
    private ServiceRatingMapper serviceRatingMapper;
    
    /**
     * 提交评价
     */
    @Transactional
    public ServiceRating submitRating(String sessionId, Long userId, Long serviceId, Integer rating, String comment) {
        try {
            log.info("提交客服评价：sessionId={}, userId={}, serviceId={}, rating={}", sessionId, userId, serviceId, rating);
            
            // 验证评分
            if (rating < 1 || rating > 5) {
                throw new RuntimeException("评分必须在 1-5 之间");
            }
            
            // 检查是否已评价
            ServiceRating existingRating = serviceRatingMapper.findBySessionId(sessionId);
            if (existingRating != null) {
                throw new RuntimeException("该会话已评价");
            }
            
            // 创建评价
            ServiceRating serviceRating = new ServiceRating();
            serviceRating.setSessionId(sessionId);
            serviceRating.setUserId(userId);
            serviceRating.setServiceId(serviceId);
            serviceRating.setRating(rating);
            serviceRating.setComment(comment);
            serviceRating.setCreateTime(LocalDateTime.now());
            
            serviceRatingMapper.insert(serviceRating);
            
            log.info("提交评价成功：sessionId={}, rating={}", sessionId, rating);
            
            return serviceRating;
            
        } catch (Exception e) {
            log.error("提交评价失败", e);
            throw new RuntimeException("提交评价失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取客服评分统计
     */
    public Map<String, Object> getServiceRatingStats(Long serviceId) {
        try {
            Map<String, Object> stats = new HashMap<>();
            
            Double averageRating = serviceRatingMapper.getAverageRating(serviceId);
            int totalRatings = serviceRatingMapper.countByServiceId(serviceId);
            
            stats.put("averageRating", averageRating != null ? averageRating : 0.0);
            stats.put("totalRatings", totalRatings);
            
            return stats;
            
        } catch (Exception e) {
            log.error("获取评分统计失败", e);
            throw new RuntimeException("获取评分统计失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取客服评价列表
     */
    public List<ServiceRating> getServiceRatings(Long serviceId) {
        try {
            return serviceRatingMapper.findByServiceId(serviceId);
        } catch (Exception e) {
            log.error("获取评价列表失败", e);
            throw new RuntimeException("获取评价列表失败：" + e.getMessage());
        }
    }
}

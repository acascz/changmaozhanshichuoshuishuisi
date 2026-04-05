package com.pdd.mall.controller;

import com.pdd.mall.entity.ServiceRating;
import com.pdd.mall.service.ServiceRatingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 客服评价 REST API 控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/chat/service/rating")
public class ServiceRatingController {
    
    @Autowired
    private ServiceRatingService serviceRatingService;
    
    /**
     * 提交评价
     */
    @PostMapping("/submit")
    public Map<String, Object> submitRating(
            @RequestParam String sessionId,
            @RequestParam Long userId,
            @RequestParam Long serviceId,
            @RequestParam Integer rating,
            @RequestParam(required = false) String comment) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            ServiceRating serviceRating = serviceRatingService.submitRating(sessionId, userId, serviceId, rating, comment);
            
            result.put("code", 200);
            result.put("message", "评价成功");
            result.put("data", serviceRating);
            
        } catch (Exception e) {
            log.error("提交评价失败", e);
            result.put("code", 500);
            result.put("message", "评价失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取客服评分统计
     */
    @GetMapping("/stats")
    public Map<String, Object> getServiceRatingStats(@RequestParam Long serviceId) {
        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> stats = serviceRatingService.getServiceRatingStats(serviceId);
            
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", stats);
            
        } catch (Exception e) {
            log.error("获取评分统计失败", e);
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取客服评价列表
     */
    @GetMapping("/list")
    public Map<String, Object> getServiceRatings(@RequestParam Long serviceId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<ServiceRating> ratings = serviceRatingService.getServiceRatings(serviceId);
            
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", ratings);
            
        } catch (Exception e) {
            log.error("获取评价列表失败", e);
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        
        return result;
    }
}

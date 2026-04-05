package com.pdd.mall.common;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.concurrent.TimeUnit;

/**
 * 限流工具类（基于 Redis 实现令牌桶算法）
 */
@Component
public class RateLimiter {
    
    @Resource
    private RedisTemplate<String, String> redisTemplate;
    
    /**
     * 尝试获取令牌
     * @param key 限流 key
     * @param maxRequests 最大请求数
     * @param timeoutSeconds 时间窗口（秒）
     * @return 是否获取成功
     */
    public boolean tryAcquire(String key, int maxRequests, int timeoutSeconds) {
        String redisKey = "rate_limit:" + key;
        
        // 获取当前计数
        String value = redisTemplate.opsForValue().get(redisKey);
        if (value == null) {
            // 第一次请求，设置初始值为 1
            redisTemplate.opsForValue().set(redisKey, "1", timeoutSeconds, TimeUnit.SECONDS);
            return true;
        }
        
        int currentCount = Integer.parseInt(value);
        if (currentCount >= maxRequests) {
            // 超过限流阈值
            return false;
        }
        
        // 计数加 1
        redisTemplate.opsForValue().increment(redisKey);
        return true;
    }
    
    /**
     * 固定窗口限流
     * @param key 限流 key
     * @param maxRequests 最大请求数
     * @param windowSeconds 窗口大小（秒）
     * @return 是否允许请求
     */
    public boolean isAllowed(String key, int maxRequests, int windowSeconds) {
        return tryAcquire(key, maxRequests, windowSeconds);
    }
}

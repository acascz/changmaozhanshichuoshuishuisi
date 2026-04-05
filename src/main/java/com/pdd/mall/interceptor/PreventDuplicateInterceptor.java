package com.pdd.mall.interceptor;

import com.pdd.mall.common.PreventDuplicate;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.concurrent.TimeUnit;

/**
 * 防止重复提交拦截器
 */
@Component
public class PreventDuplicateInterceptor implements HandlerInterceptor {
    
    @Resource
    private RedisTemplate<String, String> redisTemplate;
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }
        
        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();
        
        // 检查方法上是否有@PreventDuplicate 注解
        PreventDuplicate preventDuplicate = method.getAnnotation(PreventDuplicate.class);
        if (preventDuplicate == null) {
            // 检查类上是否有注解
            preventDuplicate = handlerMethod.getBeanType().getAnnotation(PreventDuplicate.class);
            if (preventDuplicate == null) {
                return true;
            }
        }
        
        // 生成 Redis key
        String token = request.getHeader("X-Request-Token");
        if (token == null || token.isEmpty()) {
            token = request.getSession().getId();
        }
        
        String uri = request.getRequestURI();
        String redisKey = "prevent_duplicate:" + token + ":" + uri;
        
        // 检查 Redis 中是否已存在
        String existingValue = redisTemplate.opsForValue().get(redisKey);
        if (existingValue != null) {
            response.setStatus(429);
            response.getWriter().write("{\"code\":429,\"message\":\"" + preventDuplicate.message() + "\"}");
            return false;
        }
        
        // 设置 Redis key，过期时间为间隔时间
        redisTemplate.opsForValue().set(redisKey, "1", preventDuplicate.interval(), TimeUnit.MILLISECONDS);
        
        return true;
    }
}

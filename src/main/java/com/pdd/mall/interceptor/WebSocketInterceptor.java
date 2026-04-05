package com.pdd.mall.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import java.util.Map;

/**
 * WebSocket 握手拦截器
 * 用于验证用户身份并提取用户 ID
 */
@Slf4j
@Component
public class WebSocketInterceptor implements HandshakeInterceptor {
    
    /**
     * 握手前
     */
    @Override
    public boolean beforeHandshake(@NonNull ServerHttpRequest request, @NonNull ServerHttpResponse response,
                                   @NonNull WebSocketHandler wsHandler, @NonNull Map<String, Object> attributes) throws Exception {
        log.info("WebSocket 握手请求：URI={}", request.getURI());
        
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest serverRequest = (ServletServerHttpRequest) request;
            
            // 从请求参数中获取用户 ID
            String userIdStr = serverRequest.getServletRequest().getParameter("userId");
            
            if (userIdStr != null && !userIdStr.isEmpty()) {
                try {
                    Long userId = Long.parseLong(userIdStr);
                    attributes.put("userId", userId);
                    log.info("用户握手成功：userId={}", userId);
                    return true;
                } catch (NumberFormatException e) {
                    log.error("用户 ID 格式错误：userIdStr={}", userIdStr, e);
                }
            } else {
                log.warn("缺少用户 ID 参数");
            }
        }
        
        return false;
    }
    
    /**
     * 握手后
     */
    @Override
    public void afterHandshake(@NonNull ServerHttpRequest request, @NonNull ServerHttpResponse response,
                               @NonNull WebSocketHandler wsHandler, @Nullable Exception exception) {
        // 握手后处理（如果需要）
    }
}

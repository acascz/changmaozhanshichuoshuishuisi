package com.pdd.mall.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 * WebSocket 配置类
 * 
 * 功能说明：
 * - 启用 STOMP 协议进行消息推送
 * - 注册 WebSocket 端点
 * - 配置消息代理
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    /**
     * 注册 STOMP 端点
     */
    @Override
    public void registerStompEndpoints(@NonNull StompEndpointRegistry registry) {
        // 注册物流推送端点
        registry.addEndpoint("/ws/logistics")
                .setAllowedOriginPatterns("*")
                .withSockJS()
                .setSessionCookieNeeded(true)
                .setHeartbeatTime(25000);
        
        // 注册聊天端点
        registry.addEndpoint("/ws/chat")
                .setAllowedOriginPatterns("*")
                .withSockJS()
                .setSessionCookieNeeded(true)
                .setHeartbeatTime(25000);
    }

    /**
     * 配置消息代理
     */
    @Override
    public void configureMessageBroker(@NonNull MessageBrokerRegistry registry) {
        // 启用简单的内存消息代理
        registry.enableSimpleBroker("/topic", "/queue");
        
        // 设置应用前缀
        registry.setApplicationDestinationPrefixes("/app");
        
        // 设置用户前缀
        registry.setUserDestinationPrefix("/user");
    }
}

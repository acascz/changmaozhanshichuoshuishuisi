package com.pdd.mall.config;

import com.pdd.mall.handler.ChatWebSocketHandler;
import com.pdd.mall.interceptor.WebSocketInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * 聊天 WebSocket 配置
 */
@Configuration
@EnableWebSocket
public class ChatWebSocketConfig implements WebSocketConfigurer {
    
    @Autowired
    private ChatWebSocketHandler chatWebSocketHandler;
    
    @Autowired
    private WebSocketInterceptor webSocketInterceptor;
    
    @Override
    public void registerWebSocketHandlers(@NonNull WebSocketHandlerRegistry registry) {
        // 注册聊天 WebSocket 处理器
        registry.addHandler(chatWebSocketHandler, "/ws/chat")
                .addInterceptors(webSocketInterceptor)
                .setAllowedOrigins("*");
        
        // 支持 SockJS 降级
        registry.addHandler(chatWebSocketHandler, "/ws/chat-sockjs")
                .addInterceptors(webSocketInterceptor)
                .setAllowedOrigins("*")
                .withSockJS();
    }
}

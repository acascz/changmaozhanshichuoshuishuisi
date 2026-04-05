package com.pdd.mall.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;

/**
 * Web 安全配置
 */
@Configuration
public class WebSecurityConfig implements WebMvcConfigurer {
    
    @Resource
    private com.pdd.mall.interceptor.PreventDuplicateInterceptor preventDuplicateInterceptor;
    
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("http://localhost:8080", "http://127.0.0.1:8080")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(preventDuplicateInterceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns("/api/auth/send-code"); // 排除发送验证码接口
    }
}

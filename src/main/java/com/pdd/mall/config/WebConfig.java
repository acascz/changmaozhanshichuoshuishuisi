package com.pdd.mall.config;

import com.pdd.mall.interceptor.AuthInterceptor;
import com.pdd.mall.interceptor.OperationLogInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Autowired
    private AuthInterceptor authInterceptor;

    @Autowired
    private OperationLogInterceptor operationLogInterceptor;
    
    @Autowired
    private MerchantAuthInterceptor merchantAuthInterceptor;

    @Override
    public void addCorsMappings(@NonNull CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .maxAge(3600);
    }
    
    @Override
    public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
        // 配置静态资源映射
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/")
                .setCachePeriod(3600);
        
        // 配置上传文件映射
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:uploads/")
                .setCachePeriod(0);
        
        // 映射 user_avatar 和 user_header 目录到实际存储位置
        registry.addResourceHandler("/user_avatar/**")
                .addResourceLocations("classpath:/static/images/user_avatar/")
                .setCachePeriod(300);
        
        registry.addResourceHandler("/user_header/**")
                .addResourceLocations("classpath:/static/images/user_header/")
                .setCachePeriod(300);
        
        // 兼容旧格式：avatar 和 header 目录
        registry.addResourceHandler("/avatar/**")
                .addResourceLocations("classpath:/static/images/avatar/")
                .setCachePeriod(300);
        
        registry.addResourceHandler("/header/**")
                .addResourceLocations("classpath:/static/images/header/")
                .setCachePeriod(300);
        
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/static/")
                .setCachePeriod(3600);
    }
    
    /**
     * 配置 RestTemplate Bean
     */
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
    
    @Override
    public void addInterceptors(@NonNull InterceptorRegistry registry) {
        // 操作日志拦截器（最先执行）
        registry.addInterceptor(operationLogInterceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns(
                    "/api/auth/**",
                    "/api/image/**",
                    "/api/carousel/**"
                );
        
        // 认证拦截器
        registry.addInterceptor(authInterceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns(
                    "/api/login", 
                    "/api/register", 
                    "/api/user/login",
                    "/api/user/register",
                    "/api/user/info/**",
                    "/api/user/userinfo",
                    "/api/user/recordBrowseHistory",
                    "/api/user/uploadImage",
                    "/api/user/updateProfile",
                    "/api/auth/**",
                    "/auth/**",
                    "/api/upload/**", 
                    "/uploads/**",
                    "/api/product/**",
                    "/api/image/**",
                    "/api/carousel/**",
                    "/api/chat/sessions"
                );
        
        // 商家权限拦截器（只拦截发货管理接口）
        registry.addInterceptor(merchantAuthInterceptor)
                .addPathPatterns("/api/delivery/**")
                .addPathPatterns("/api/admin/**");
        
        // 签名验证拦截器（可选启用）
        // registry.addInterceptor(signatureInterceptor)
        //         .addPathPatterns("/api/**")
        //         .excludePathPatterns(
        //             "/api/auth/**",
        //             "/api/file/**",
        //             "/images/**"
        //         );
    }
}

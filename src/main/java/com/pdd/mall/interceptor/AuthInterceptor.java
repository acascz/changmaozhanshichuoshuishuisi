package com.pdd.mall.interceptor;

import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 认证拦截器
 * 用于检查用户登录状态
 */
@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull Object handler) throws Exception {
        String uri = request.getRequestURI();
        
        // 跳过不需要认证的路径
        if (uri.startsWith("/api/auth/") || 
            uri.startsWith("/auth/") ||
            uri.equals("/api/login") ||
            uri.equals("/api/register") ||
            uri.startsWith("/api/user/login") ||
            uri.startsWith("/api/user/register") ||
            uri.startsWith("/api/user/info") ||
            uri.startsWith("/api/user/userinfo") ||
            uri.startsWith("/api/user/recordBrowseHistory") ||
            uri.startsWith("/api/user/uploadImage") ||
            uri.startsWith("/api/user/updateProfile") ||
            uri.startsWith("/api/carousel/") ||
            uri.startsWith("/api/product/")) {
            return true;
        }
        
        // 检查会话中是否有用户信息
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"code\":401,\"message\":\"未登录\"}");
            return false;
        }
        
        Object user = session.getAttribute("user");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"code\":401,\"message\":\"未登录\"}");
            return false;
        }
        
        return true;
    }
}

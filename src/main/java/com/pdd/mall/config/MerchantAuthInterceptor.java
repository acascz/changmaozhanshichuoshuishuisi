package com.pdd.mall.config;

import com.pdd.mall.entity.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.lang.NonNull;

/**
 * 商家权限验证拦截器
 * 只有商家角色的用户才能访问发货管理相关接口
 */
@Component
@Slf4j
public class MerchantAuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull Object handler) throws Exception {
        // 1. 获取 session
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"code\":401,\"message\":\"未登录\"}");
            return false;
        }
        
        // 2. 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"code\":401,\"message\":\"用户未登录\"}");
            return false;
        }
        
        // 3. 验证商家权限
        String userRole = currentUser.getRole();
        if (userRole == null || (!"MERCHANT".equals(userRole) && !"ADMIN".equals(userRole))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"code\":403,\"message\":\"权限不足：只有商家才能访问\"}");
            log.warn("商家权限验证失败：userId={}, username={}, role={}", 
                    currentUser.getId(), currentUser.getUsername(), userRole);
            return false;
        }
        
        log.info("商家权限验证通过：userId={}, username={}, role={}", 
                currentUser.getId(), currentUser.getUsername(), userRole);
        
        return true;
    }
}

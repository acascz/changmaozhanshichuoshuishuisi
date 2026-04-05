package com.pdd.mall.interceptor;

import com.pdd.mall.common.Result;
import com.pdd.mall.util.SignUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;

/**
 * 请求签名验证拦截器
 * 用于验证请求的完整性和防篡改
 */
@Slf4j
@Component
public class SignatureInterceptor implements HandlerInterceptor {

    @Autowired
    private SignUtil signUtil;

    // 不需要签名验证的路径
    private static final String[] EXCLUDE_PATHS = {
            "/api/auth/",
            "/api/file/",
            "/images/",
            "/api/test"
    };

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, 
                            @NonNull HttpServletResponse response, 
                            @Nullable Object handler) throws Exception {
        String uri = request.getRequestURI();

        // 1. 检查是否需要签名验证
        for (String excludePath : EXCLUDE_PATHS) {
            if (uri.startsWith(excludePath)) {
                return true;
            }
        }

        // 2. 仅对 POST/PUT/DELETE 请求进行签名验证
        String method = request.getMethod();
        if (!"POST".equalsIgnoreCase(method) && 
            !"PUT".equalsIgnoreCase(method) && 
            !"DELETE".equalsIgnoreCase(method)) {
            return true;
        }

        // 3. 获取签名参数
        String sign = request.getParameter("sign");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");

        // 4. 如果没有签名参数，拒绝请求（生产环境）
        if (sign == null || timestamp == null || nonce == null) {
            log.warn("请求缺少签名参数：uri={}, method={}", uri, method);
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(Result.error("请求缺少签名参数").toString());
            return false;
        }

        // 5. 构建参数 Map
        Map<String, Object> params = new HashMap<>();
        request.getParameterMap().forEach((key, values) -> {
            if (values != null && values.length > 0) {
                params.put(key, values[0]);
            }
        });

        // 6. 验证签名
        boolean valid = signUtil.verifySign(params);
        if (!valid) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(Result.error("签名验证失败").toString());
            return false;
        }

        return true;
    }
}

package com.pdd.mall.interceptor;

import com.pdd.mall.entity.User;
import com.pdd.mall.service.OperationLogService;
import com.pdd.mall.util.TraceUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 操作日志拦截器
 * 自动记录所有请求的操作日志
 */
@Slf4j
@Component
public class OperationLogInterceptor implements HandlerInterceptor {

    @Autowired
    private OperationLogService operationLogService;

    @Autowired
    private TraceUtil traceUtil;

    private static final String START_TIME_KEY = "startTime";
    private static final String TRACE_ID_KEY = "traceId";

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull Object handler) throws Exception {
        // 1. 生成追踪 ID
        String traceId = traceUtil.generateTraceId();
        traceUtil.setTraceId(traceId);
        
        // 2. 记录请求开始时间
        request.setAttribute(START_TIME_KEY, System.currentTimeMillis());
        request.setAttribute(TRACE_ID_KEY, traceId);
        
        // 3. 记录请求日志
        log.info("[{}] {} - 追踪 ID: {}", request.getMethod(), request.getRequestURI(), traceId);
        
        return true;
    }

    @Override
    public void postHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, 
                          @NonNull Object handler, @Nullable ModelAndView modelAndView) throws Exception {
        // 可以在这里处理响应数据
    }

    @Override
    public void afterCompletion(@NonNull HttpServletRequest request, 
                               @NonNull HttpServletResponse response,
                               @Nullable Object handler, 
                               @Nullable Exception ex) throws Exception {
        try {
            // 1. 计算执行时长
            Long startTime = (Long) request.getAttribute(START_TIME_KEY);
            Long executionTime = System.currentTimeMillis() - startTime;
            
            // 2. 获取用户信息
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            // 3. 获取请求参数
            String params = getRequestParams(request);
            
            // 4. 获取追踪 ID（用于日志记录）
            // traceId 已记录在日志中，不需要单独使用
            
            // 5. 记录操作日志
            if (ex != null) {
                // 记录失败日志
                operationLogService.logFailure(
                    user != null ? user.getId() : null,
                    user != null ? user.getUsername() : "anonymous",
                    request.getMethod(),
                    getModule(request.getRequestURI()),
                    request.getRequestURI(),
                    request.getMethod(),
                    request.getRequestURI(),
                    params,
                    ex.getMessage(),
                    getIpAddress(request),
                    request.getHeader("User-Agent")
                );
            } else {
                // 记录成功日志
                operationLogService.logSuccess(
                    user != null ? user.getId() : null,
                    user != null ? user.getUsername() : "anonymous",
                    request.getMethod(),
                    getModule(request.getRequestURI()),
                    request.getRequestURI(),
                    request.getMethod(),
                    request.getRequestURI(),
                    params,
                    "success",
                    executionTime,
                    getIpAddress(request),
                    request.getHeader("User-Agent")
                );
            }
            
        } catch (Exception e) {
            log.error("记录操作日志异常", e);
        } finally {
            // 6. 清理追踪 ID
            traceUtil.clear();
        }
    }

    /**
     * 获取请求参数
     */
    private String getRequestParams(HttpServletRequest request) {
        StringBuilder params = new StringBuilder();
        for (String key : request.getParameterMap().keySet()) {
            if (params.length() > 0) {
                params.append("&");
            }
            params.append(key).append("=").append(request.getParameter(key));
        }
        return params.length() > 0 ? params.toString() : "";
    }

    /**
     * 获取客户端 IP 地址
     */
    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * 根据 URL 提取模块
     */
    private String getModule(String uri) {
        if (uri.contains("/order")) {
            return "订单";
        } else if (uri.contains("/payment")) {
            return "支付";
        } else if (uri.contains("/product")) {
            return "商品";
        } else if (uri.contains("/user")) {
            return "用户";
        } else if (uri.contains("/auth")) {
            return "认证";
        } else if (uri.contains("/inventory")) {
            return "库存";
        } else {
            return "其他";
        }
    }
}

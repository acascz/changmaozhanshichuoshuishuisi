package com.pdd.mall.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.UUID;

/**
 * 全链路追踪工具类
 */
@Slf4j
@Component
public class TraceUtil {

    /**
     * ThreadLocal 存储当前请求的追踪 ID
     */
    private static final ThreadLocal<String> TRACE_ID_HOLDER = new ThreadLocal<>();

    /**
     * 生成新的追踪 ID
     * 格式：TRACE-时间戳 - 随机数
     */
    public String generateTraceId() {
        String traceId = "TRACE-" + System.currentTimeMillis() + "-" + 
                        UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        log.debug("生成追踪 ID: {}", traceId);
        return traceId;
    }

    /**
     * 设置当前请求的追踪 ID
     */
    public void setTraceId(String traceId) {
        TRACE_ID_HOLDER.set(traceId);
        // 将追踪 ID 放入 MDC，方便日志输出
        org.slf4j.MDC.put("traceId", traceId);
    }

    /**
     * 获取当前请求的追踪 ID
     */
    public String getTraceId() {
        String traceId = TRACE_ID_HOLDER.get();
        if (traceId == null) {
            traceId = generateTraceId();
            setTraceId(traceId);
        }
        return traceId;
    }

    /**
     * 清除当前请求的追踪 ID
     */
    public void clear() {
        TRACE_ID_HOLDER.remove();
        org.slf4j.MDC.remove("traceId");
    }
}

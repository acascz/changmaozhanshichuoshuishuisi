package com.pdd.mall.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 操作日志服务
 */
@Service
@Slf4j
public class OperationLogService {

    /**
     * 记录成功日志
     */
    public void logSuccess(Long userId, String username, String operationType, 
                          String module, String uri, String method, String description,
                          String params, String result, Long executionTime,
                          String ipAddress, String userAgent) {
        log.info("[{}] 用户 {} 执行 {} 操作成功 - 模块：{}, 接口：{}, 参数：{}, 耗时：{}ms",
                operationType, username, operationType, module, uri, params, executionTime);
    }

    /**
     * 记录失败日志
     */
    public void logFailure(Long userId, String username, String operationType,
                          String module, String uri, String method, String description,
                          String params, String error, String ipAddress, String userAgent) {
        log.error("[{}] 用户 {} 执行 {} 操作失败 - 模块：{}, 接口：{}, 参数：{}, 错误：{}",
                operationType, username, operationType, module, uri, params, error);
    }
}

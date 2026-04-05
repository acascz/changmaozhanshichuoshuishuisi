package com.pdd.mall.service;

import com.pdd.mall.entity.AiAccessLog;
import com.pdd.mall.mapper.AiAccessLogMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * AI 访问日志服务
 * 记录和审计 AI 数据访问
 */
@Service
public class AiAccessLogService {
    
    private static final Logger log = LoggerFactory.getLogger(AiAccessLogService.class);
    
    @Autowired
    private AiAccessLogMapper aiAccessLogMapper;
    
    /**
     * 记录 AI 访问日志
     */
    @Transactional
    public void logAccess(AiAccessLog accessLog) {
        try {
            // 生成日志 ID
            String logId = generateLogId();
            accessLog.setLogId(logId);
            accessLog.setTimestamp(LocalDateTime.now());
            
            // 自动判定风险等级
            String riskLevel = assessRiskLevel(accessLog);
            accessLog.setRiskLevel(riskLevel);
            
            // 保存到数据库
            aiAccessLogMapper.insert(accessLog);
            
            log.info("AI 访问日志记录成功：logId={}, userId={}, dataType={}, riskLevel={}", 
                    logId, accessLog.getUserId(), accessLog.getDataType(), riskLevel);
        } catch (Exception e) {
            log.error("记录 AI 访问日志失败", e);
            // 日志记录失败不影响主流程，只记录错误
        }
    }
    
    /**
     * 记录高风险访问
     */
    public void logHighRiskAccess(AiAccessLog accessLog, String reason) {
        try {
            accessLog.setRiskLevel("high");
            accessLog.setRiskReason(reason);
            accessLog.setAccessResult("failed");
            
            logAccess(accessLog);
            
            log.warn("高风险 AI 访问被拦截：userId={}, reason={}", accessLog.getUserId(), reason);
        } catch (Exception e) {
            log.error("记录高风险访问日志失败", e);
        }
    }
    
    /**
     * 判定风险等级
     */
    private String assessRiskLevel(AiAccessLog accessLog) {
        // 高风险：越权访问、L3 数据访问
        if ("high".equals(accessLog.getRiskLevel())) {
            return "high";
        }
        
        // 中风险：L3 数据、频繁访问
        if ("l3_data".equals(accessLog.getDataType())) {
            return "medium";
        }
        
        // 低风险：正常 L1/L2 数据访问
        return "low";
    }
    
    /**
     * 生成日志 ID
     */
    private String generateLogId() {
        return "LOG" + System.currentTimeMillis() + 
               UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    
    /**
     * 查询用户访问日志
     */
    public java.util.List<AiAccessLog> getUserAccessLogs(Long userId, int days) {
        try {
            LocalDateTime startTime = LocalDateTime.now().minusDays(days);
            return aiAccessLogMapper.selectByUserId(userId, startTime);
        } catch (Exception e) {
            log.error("查询用户访问日志失败：userId={}", userId, e);
            return java.util.Collections.emptyList();
        }
    }
    
    /**
     * 查询高风险日志
     */
    public java.util.List<AiAccessLog> getHighRiskLogs(int days) {
        try {
            LocalDateTime startTime = LocalDateTime.now().minusDays(days);
            return aiAccessLogMapper.selectByRiskLevel("high", startTime);
        } catch (Exception e) {
            log.error("查询高风险日志失败", e);
            return java.util.Collections.emptyList();
        }
    }
}

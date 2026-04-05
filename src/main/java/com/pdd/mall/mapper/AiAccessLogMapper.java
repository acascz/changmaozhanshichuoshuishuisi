package com.pdd.mall.mapper;

import com.pdd.mall.entity.AiAccessLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * AI 访问日志 Mapper
 */
@Mapper
public interface AiAccessLogMapper {
    
    /**
     * 插入访问日志
     */
    int insert(AiAccessLog accessLog);
    
    /**
     * 根据用户 ID 查询访问日志
     */
    List<AiAccessLog> selectByUserId(@Param("userId") Long userId,
                                     @Param("startTime") LocalDateTime startTime);
    
    /**
     * 根据风险等级查询日志
     */
    List<AiAccessLog> selectByRiskLevel(@Param("riskLevel") String riskLevel,
                                        @Param("startTime") LocalDateTime startTime);
    
    /**
     * 根据日志 ID 查询
     */
    AiAccessLog selectByLogId(@Param("logId") String logId);
}

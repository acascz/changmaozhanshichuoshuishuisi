package com.pdd.mall.service;

import com.pdd.mall.entity.UserBrowseHistory;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 用户浏览记录服务
 */
public interface UserBrowseHistoryService {

    /**
     * 记录浏览历史
     */
    void recordBrowseHistory(Long userId, Long productId);

    /**
     * 查询用户的浏览记录
     */
    Map<String, Object> getBrowseHistory(Long userId, Integer page, Integer size);

    /**
     * 查询用户最近的浏览记录
     */
    List<UserBrowseHistory> getRecentHistory(Long userId, Integer limit);

    /**
     * 清空用户的浏览记录
     */
    void clearHistory(Long userId);

    /**
     * 清理过期的浏览记录
     */
    void cleanExpiredHistory(Integer keepDays);
}

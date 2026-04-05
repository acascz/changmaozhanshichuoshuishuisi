package com.pdd.mall.service.impl;

import com.pdd.mall.entity.Product;
import com.pdd.mall.entity.UserBrowseHistory;
import com.pdd.mall.mapper.UserBrowseHistoryMapper;
import com.pdd.mall.service.ProductService;
import com.pdd.mall.service.UserBrowseHistoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

/**
 * 用户浏览记录服务实现
 */
@Slf4j
@Service
public class UserBrowseHistoryServiceImpl implements UserBrowseHistoryService {

    @Autowired
    private UserBrowseHistoryMapper userBrowseHistoryMapper;

    @Autowired
    private ProductService productService;

    // 浏览记录保留天数
    private static final int KEEP_DAYS = 90;

    @Override
    public void recordBrowseHistory(Long userId, Long productId) {
        try {
            // 1. 查询商品信息
            Product product = productService.getProductById(productId);
            if (product == null) {
                log.warn("商品不存在：productId={}", productId);
                return;
            }

            // 2. 创建浏览记录
            UserBrowseHistory history = new UserBrowseHistory();
            history.setUserId(userId);
            history.setProductId(productId);
            history.setProductName(product.getName());
            history.setProductPrice(product.getPrice());
            
            // 获取商品图片（从 images 列表获取第一张）
            if (product.getImages() != null && !product.getImages().isEmpty()) {
                history.setProductImage(product.getImages().get(0).getFilePath());
            }
            
            // 使用 category 字段作为分类名称
            history.setCategoryName(product.getCategory());
            history.setSource("browse");

            // 3. 插入记录
            userBrowseHistoryMapper.insert(history);
            log.debug("记录浏览历史：userId={}, productId={}", userId, productId);

        } catch (Exception e) {
            log.error("记录浏览历史失败：userId={}, productId={}", userId, productId, e);
        }
    }

    @Override
    public Map<String, Object> getBrowseHistory(Long userId, Integer page, Integer size) {
        Map<String, Object> result = new HashMap<>();

        if (page == null || page < 1) {
            page = 1;
        }
        if (size == null || size < 1) {
            size = 20;
        }

        int offset = (page - 1) * size;
        LocalDateTime endTime = LocalDateTime.now();
        LocalDateTime startTime = endTime.minusDays(KEEP_DAYS);

        // 1. 查询浏览记录
        List<UserBrowseHistory> historyList = userBrowseHistoryMapper.selectByUserId(
            userId, startTime, endTime, offset, size
        );

        // 2. 统计总数
        int total = userBrowseHistoryMapper.countByUserId(userId, startTime, endTime);

        // 3. 计算是否有更多
        boolean hasMore = offset + historyList.size() < total;

        result.put("history", historyList);
        result.put("total", total);
        result.put("page", page);
        result.put("size", size);
        result.put("hasMore", hasMore);

        return result;
    }

    @Override
    public List<UserBrowseHistory> getRecentHistory(Long userId, Integer limit) {
        if (limit == null || limit < 1) {
            limit = 10;
        }
        return userBrowseHistoryMapper.selectRecentByUserId(userId, limit);
    }

    @Override
    public void clearHistory(Long userId) {
        userBrowseHistoryMapper.deleteByUserId(userId);
        log.info("清空用户浏览记录：userId={}", userId);
    }

    @Override
    @Scheduled(cron = "0 0 2 * * ?") // 每天凌晨 2 点执行
    public void cleanExpiredHistory(Integer keepDays) {
        if (keepDays == null || keepDays < 1) {
            keepDays = KEEP_DAYS;
        }

        LocalDateTime beforeTime = LocalDateTime.now().minusDays(keepDays);
        int deletedCount = userBrowseHistoryMapper.deleteByTime(beforeTime);
        log.info("清理过期浏览记录：deletedCount={}, beforeTime={}", deletedCount, beforeTime);
    }
}

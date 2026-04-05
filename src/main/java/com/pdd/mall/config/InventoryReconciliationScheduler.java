package com.pdd.mall.config;

import com.pdd.mall.service.InventoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 库存对账定时任务
 */
@Component
public class InventoryReconciliationScheduler {

    private static final Logger log = LoggerFactory.getLogger(InventoryReconciliationScheduler.class);

    @Autowired
    private InventoryService inventoryService;

    /**
     * 姣忔棩鍑屾櫒 2 鐐规墽琛屽璐?     */
    @Scheduled(cron = "0 0 2 * * ?")
    public void dailyReconciliation() {
        log.info("========== 开始每日库存对账 ==========");
        try {
            inventoryService.reconciliation();
            log.info("========== 每日对账完成 ==========");
        } catch (Exception e) {
            log.error("每日对账失败", e);
        }
    }

    /**
     * 每小时执行一次简单对账（仅检查不一致）
     */
    @Scheduled(cron = "0 0 * * * ?")
    public void hourlyReconciliation() {
        log.debug("========== 开始每小时库存检查 ==========");
        try {
            inventoryService.reconciliation();
        } catch (Exception e) {
            log.error("每小时对账失败", e);
        }
    }
}

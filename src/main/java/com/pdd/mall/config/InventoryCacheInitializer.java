package com.pdd.mall.config;

import com.pdd.mall.service.InventoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * 系统启动时初始化库存缓存
 */
@Component
public class InventoryCacheInitializer implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(InventoryCacheInitializer.class);

    @Autowired
    private InventoryService inventoryService;

    @Override
    public void run(String... args) throws Exception {
        log.info("系统启动，开始初始化库存缓存...");
        try {
            // 延迟 3 秒执行，确保数据库和 Redis 已就绪
            Thread.sleep(3000);
            inventoryService.initStockCache();
            log.info("库存缓存初始化完成");
        } catch (Exception e) {
            log.error("库存缓存初始化失败，但不影响系统启动", e);
        }
    }
}

package com.pdd.mall.service;

/**
 * 库存服务接口
 */
public interface InventoryService {

    /**
     * 初始化库存缓存
     */
    void initStockCache();

    /**
     * 库存对账
     */
    void reconciliation();
}

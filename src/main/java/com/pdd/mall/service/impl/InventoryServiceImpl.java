package com.pdd.mall.service.impl;

import com.pdd.mall.mapper.InventoryMapper;
import com.pdd.mall.service.InventoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 库存服务实现类
 */
@Service
@Slf4j
public class InventoryServiceImpl implements InventoryService {

    @Autowired
    private InventoryMapper inventoryMapper;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    private static final String INVENTORY_CACHE_KEY_PREFIX = "inventory:stock:";
    private static final long INVENTORY_CACHE_EXPIRE_HOURS = 24;

    @Override
    public void initStockCache() {
        log.info("开始初始化库存缓存...");
        try {
            // 从数据库查询所有商品的库存信息
            List<Integer> goodsIds = inventoryMapper.selectAllGoodsIds();
            
            for (Integer goodsId : goodsIds) {
                // 查询商品库存
                Integer stock = inventoryMapper.selectStockByGoodsId(goodsId);
                
                if (stock != null) {
                    // 缓存到 Redis
                    String cacheKey = INVENTORY_CACHE_KEY_PREFIX + goodsId;
                    redisTemplate.opsForValue().set(cacheKey, stock, INVENTORY_CACHE_EXPIRE_HOURS, TimeUnit.HOURS);
                    log.debug("缓存商品库存：goodsId={}, stock={}", goodsId, stock);
                }
            }
            
            log.info("库存缓存初始化完成，共缓存 {} 个商品", goodsIds.size());
            
        } catch (Exception e) {
            log.error("初始化库存缓存失败", e);
            throw new RuntimeException("初始化库存缓存失败", e);
        }
    }

    @Override
    public void reconciliation() {
        log.info("开始库存对账...");
        try {
            // 从数据库查询所有商品的库存信息
            List<Integer> goodsIds = inventoryMapper.selectAllGoodsIds();
            
            int inconsistentCount = 0;
            
            for (Integer goodsId : goodsIds) {
                // 查询数据库库存
                Integer dbStock = inventoryMapper.selectStockByGoodsId(goodsId);
                
                // 查询 Redis 缓存库存
                String cacheKey = INVENTORY_CACHE_KEY_PREFIX + goodsId;
                Integer cacheStock = (Integer) redisTemplate.opsForValue().get(cacheKey);
                
                // 比较是否一致
                if (dbStock != null && !dbStock.equals(cacheStock)) {
                    log.warn("库存不一致：goodsId={}, dbStock={}, cacheStock={}", goodsId, dbStock, cacheStock);
                    inconsistentCount++;
                    
                    // 以数据库为准，更新缓存
                    redisTemplate.opsForValue().set(cacheKey, dbStock, INVENTORY_CACHE_EXPIRE_HOURS, TimeUnit.HOURS);
                    log.info("已更新缓存：goodsId={}, newStock={}", goodsId, dbStock);
                }
            }
            
            log.info("库存对账完成，发现 {} 个商品库存不一致", inconsistentCount);
            
        } catch (Exception e) {
            log.error("库存对账失败", e);
            throw new RuntimeException("库存对账失败", e);
        }
    }
}

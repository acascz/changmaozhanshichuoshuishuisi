package com.pdd.mall.service;

import com.pdd.mall.entity.ProductSpec;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.concurrent.TimeUnit;

/**
 * 价格验证服务类
 * 使用 Redis 缓存价格验证结果，提升并发性能
 */
@Service
public class PriceVerificationService {
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    @Autowired
    private ProductSpecService productSpecService;
    
    /**
     * 验证价格并缓存结果
     * @param productId 商品 ID
     * @param weight 重量规格
     * @param sugarType 糖醇类型
     * @param coldChain 冷链类型
     * @param clientPrice 客户端价格
     * @return 验证结果：true=验证通过，false=验证失败
     */
    public boolean verifyPrice(Long productId, String weight, String sugarType, String coldChain, BigDecimal clientPrice) {
        // 生成缓存 key
        String cacheKey = generateCacheKey(productId, weight, sugarType, coldChain);
        
        // 先从缓存获取验证结果
        Boolean cachedResult = getCachedVerificationResult(cacheKey, clientPrice);
        if (cachedResult != null) {
            return cachedResult;
        }
        
        // 缓存未命中，查询数据库验证
        try {
            ProductSpec spec = productSpecService.getProductSpecByParams(productId, weight, sugarType, coldChain);
            
            if (spec == null) {
                // 未找到规格，验证失败
                cacheVerificationResult(cacheKey, false, clientPrice, 1); // 缓存 1 分钟
                return false;
            }
            
            BigDecimal serverPrice = spec.getPrice();
            boolean isValid = serverPrice.compareTo(clientPrice) == 0;
            
            // 缓存验证结果
            if (isValid) {
                // 验证通过，缓存 5 分钟
                cacheVerificationResult(cacheKey, true, clientPrice, 5);
            } else {
                // 验证失败，缓存 1 分钟
                cacheVerificationResult(cacheKey, false, clientPrice, 1);
            }
            
            return isValid;
        } catch (Exception e) {
            // 查询失败，不缓存，直接返回 false
            return false;
        }
    }
    
    /**
     * 生成缓存 key
     */
    private String generateCacheKey(Long productId, String weight, String sugarType, String coldChain) {
        return String.format("price_verify:%d_%s_%s_%s", productId, weight, sugarType, coldChain);
    }
    
    /**
     * 获取缓存的验证结果
     * @return null=缓存未命中，true/false=验证结果
     */
    private Boolean getCachedVerificationResult(String cacheKey, BigDecimal clientPrice) {
        try {
            Object cached = redisTemplate.opsForValue().get(cacheKey);
            if (cached instanceof CachedVerification) {
                CachedVerification cachedVerification = (CachedVerification) cached;
                // 检查价格是否一致
                if (cachedVerification.getPrice().compareTo(clientPrice) == 0) {
                    return cachedVerification.isValid();
                }
            }
        } catch (Exception e) {
            // 缓存读取失败，忽略
        }
        return null;
    }
    
    /**
     * 缓存验证结果
     */
    private void cacheVerificationResult(String cacheKey, boolean isValid, BigDecimal price, int expireMinutes) {
        try {
            CachedVerification verification = new CachedVerification(isValid, price, System.currentTimeMillis());
            redisTemplate.opsForValue().set(cacheKey, verification, expireMinutes, TimeUnit.MINUTES);
        } catch (Exception e) {
            // 缓存写入失败，忽略
        }
    }
    
    /**
     * 缓存的验证结果类
     */
    private static class CachedVerification implements java.io.Serializable {
        private static final long serialVersionUID = 1L;
        
        private final boolean valid;
        private final BigDecimal price;
        private final long timestamp;
        
        public CachedVerification(boolean valid, BigDecimal price, long timestamp) {
            this.valid = valid;
            this.price = price;
            this.timestamp = timestamp;
        }
        
        public boolean isValid() {
            return valid;
        }
        
        public BigDecimal getPrice() {
            return price;
        }
        
        public long getTimestamp() {
            return timestamp;
        }
    }
}

package com.pdd.mall.service;

import com.pdd.mall.entity.ProductSpec;
import com.pdd.mall.mapper.ProductSpecMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 商品规格服务类
 * 集成 Redis 缓存提升查询性能
 */
@Service
public class ProductSpecService {
    
    @Autowired
    private ProductSpecMapper productSpecMapper;
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    /**
     * 根据规格参数查询规格价格（带缓存）
     */
    @Cacheable(value = "productSpec", key = "#productId + '_' + #weight + '_' + #sugarType + '_' + #coldChain", unless = "#result == null")
    public ProductSpec getProductSpecByParams(Long productId, String weight, String sugarType, String coldChain) {
        // 将前端的中文参数转换为数据库存储的英文参数
        String dbSugarType = convertSugarTypeToDb(sugarType);
        String dbColdChain = convertColdChainToDb(coldChain);
        
        return productSpecMapper.findBySpecParams(productId, weight, dbSugarType, dbColdChain);
    }
    
    /**
     * 根据商品 ID 查询所有规格价格（带缓存）
     */
    @Cacheable(value = "productSpec", key = "'all_' + #productId", unless = "#result == null")
    public List<ProductSpec> getProductSpecsByProductId(Long productId) {
        return productSpecMapper.findByProductId(productId);
    }
    
    /**
     * 将前端糖醇类型转换为数据库存储格式
     */
    private String convertSugarTypeToDb(String sugarType) {
        if ("不加糖醇".equals(sugarType)) {
            return "no_sugar";
        } else if ("加糖醇".equals(sugarType)) {
            return "with_sugar";
        }
        return sugarType; // 如果已经是英文格式，直接返回
    }
    
    /**
     * 将前端冷链类型转换为数据库存储格式
     */
    private String convertColdChainToDb(String coldChain) {
        if ("不冷链".equals(coldChain)) {
            return "no_cold";
        } else if ("冷链".equals(coldChain)) {
            return "with_cold";
        }
        return coldChain; // 如果已经是英文格式，直接返回
    }
    
    /**
     * 将数据库糖醇类型转换为前端显示格式
     */
    public String convertSugarTypeToDisplay(String sugarType) {
        if ("no_sugar".equals(sugarType)) {
            return "不加糖醇";
        } else if ("with_sugar".equals(sugarType)) {
            return "加糖醇";
        }
        return sugarType;
    }
    
    /**
     * 将数据库冷链类型转换为前端显示格式
     */
    public String convertColdChainToDisplay(String coldChain) {
        if ("no_cold".equals(coldChain)) {
            return "不冷链";
        } else if ("with_cold".equals(coldChain)) {
            return "冷链";
        }
        return coldChain;
    }
}
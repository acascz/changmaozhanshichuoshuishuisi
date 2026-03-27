package com.pdd.mall.mapper;

import com.pdd.mall.entity.ProductSpec;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 商品规格数据访问接口
 */
@Mapper
public interface ProductSpecMapper {
    
    /**
     * 根据商品ID和规格参数查询规格价格
     */
    @Select("SELECT id, product_id AS productId, weight, sugar_type AS sugarType, cold_chain AS coldChain, " +
            "price, original_price AS originalPrice, cost_price AS costPrice, profit_rate AS profitRate, " +
            "stock_count AS stockCount, sales_count AS salesCount, status, sort_order AS sortOrder, " +
            "is_drainage AS isDrainage, create_time AS createTime, update_time AS updateTime " +
            "FROM product_spec WHERE product_id = #{productId} AND weight = #{weight} " +
            "AND sugar_type = #{sugarType} AND cold_chain = #{coldChain} AND status = 1")
    ProductSpec findBySpecParams(@Param("productId") Long productId, 
                                @Param("weight") String weight,
                                @Param("sugarType") String sugarType,
                                @Param("coldChain") String coldChain);
    
    /**
     * 根据商品ID查询所有规格价格
     */
    @Select("SELECT id, product_id AS productId, weight, sugar_type AS sugarType, cold_chain AS coldChain, " +
            "price, original_price AS originalPrice, cost_price AS costPrice, profit_rate AS profitRate, " +
            "stock_count AS stockCount, sales_count AS salesCount, status, sort_order AS sortOrder, " +
            "is_drainage AS isDrainage, create_time AS createTime, update_time AS updateTime " +
            "FROM product_spec WHERE product_id = #{productId} AND status = 1 ORDER BY sort_order ASC")
    List<ProductSpec> findByProductId(@Param("productId") Long productId);
    
    /**
     * 插入规格价格
     */
    @Insert("INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, original_price, " +
            "cost_price, profit_rate, stock_count, sales_count, status, sort_order, is_drainage, create_time, update_time) " +
            "VALUES (#{productId}, #{weight}, #{sugarType}, #{coldChain}, #{price}, #{originalPrice}, " +
            "#{costPrice}, #{profitRate}, #{stockCount}, #{salesCount}, #{status}, #{sortOrder}, #{isDrainage}, NOW(), NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void insert(ProductSpec productSpec);
    
    /**
     * 更新规格价格
     */
    @Update("UPDATE product_spec SET price = #{price}, original_price = #{originalPrice}, cost_price = #{costPrice}, " +
            "profit_rate = #{profitRate}, stock_count = #{stockCount}, sales_count = #{salesCount}, " +
            "status = #{status}, sort_order = #{sortOrder}, is_drainage = #{isDrainage}, update_time = NOW() " +
            "WHERE id = #{id}")
    void update(ProductSpec productSpec);
}
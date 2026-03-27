package com.pdd.mall.mapper;

import com.pdd.mall.entity.Product;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 商品数据访问接口
 */
@Mapper
public interface ProductMapper {
    
    /**
     * 查询所有上架商品，按排序序号排序
     */
    @Select("SELECT id, name, description, price, original_price AS originalPrice, sales AS salesCount, stock AS stockCount, " +
            "category, tags, status, sort_order AS sortOrder, create_time AS createTime, update_time AS updateTime " +
            "FROM product WHERE status = 1 ORDER BY sort_order ASC")
    List<Product> findAll();
    
    /**
     * 根据 ID 查询商品
     */
    @Select("SELECT id, name, description, price, original_price AS originalPrice, sales AS salesCount, stock AS stockCount, " +
            "category, tags, status, sort_order AS sortOrder, create_time AS createTime, update_time AS updateTime " +
            "FROM product WHERE id = #{id} AND status = 1")
    Product findById(Long id);
    
    /**
     * 根据分类查询商品
     */
    @Select("SELECT id, name, description, price, original_price AS originalPrice, sales AS salesCount, stock AS stockCount, " +
            "category, tags, status, sort_order AS sortOrder, create_time AS createTime, update_time AS updateTime " +
            "FROM product WHERE category = #{category} AND status = 1 ORDER BY sort_order ASC")
    List<Product> findByCategory(String category);
    
    /**
     * 插入商品
     */
    @Insert("INSERT INTO product (name, description, price, original_price, sales, stock, category, tags, status, sort_order, create_time, update_time) " +
            "VALUES (#{name}, #{description}, #{price}, #{originalPrice}, #{salesCount}, #{stockCount}, #{category}, #{tags}, #{status}, #{sortOrder}, NOW(), NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void insert(Product product);
    
    /**
     * 更新商品
     */
    @Update("UPDATE product SET name = #{name}, description = #{description}, price = #{price}, original_price = #{originalPrice}, " +
            "sales = #{salesCount}, stock = #{stockCount}, category = #{category}, tags = #{tags}, " +
            "status = #{status}, sort_order = #{sortOrder}, update_time = NOW() WHERE id = #{id}")
    void update(Product product);
    
    /**
     * 删除商品
     */
    @Delete("DELETE FROM product WHERE id = #{id}")
    void delete(Long id);
    
    /**
     * 更新商品状态
     */
    @Update("UPDATE product SET status = #{status}, update_time = NOW() WHERE id = #{id}")
    void updateStatus(@Param("id") Long id, @Param("status") Integer status);
    
    /**
     * 根据关键词搜索商品
     */
    @Select("SELECT id, name, description, price, original_price AS originalPrice, sales AS salesCount, stock AS stockCount, " +
            "category, tags, status, sort_order AS sortOrder, create_time AS createTime, update_time AS updateTime " +
            "FROM product WHERE status = 1 AND (name LIKE CONCAT('%', #{keyword}, '%') OR description LIKE CONCAT('%', #{keyword}, '%') OR tags LIKE CONCAT('%', #{keyword}, '%')) ORDER BY sort_order ASC")
    List<Product> searchByKeyword(String keyword);
}
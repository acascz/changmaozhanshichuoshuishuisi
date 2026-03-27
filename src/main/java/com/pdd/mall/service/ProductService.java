package com.pdd.mall.service;

import com.pdd.mall.entity.Product;
import com.pdd.mall.entity.ImageFile;
import com.pdd.mall.mapper.ProductMapper;
import com.pdd.mall.mapper.ImageFileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 商品服务类
 */
@Service
public class ProductService {
    
    @Autowired
    private ProductMapper productMapper;
    
    @Autowired
    private ImageFileMapper imageFileMapper;
    
    /**
     * 获取首页商品列表（包含关联图片）
     */
    public List<Product> getHomeProducts() {
        List<Product> products = productMapper.findAll();
        
        // 为每个商品关联图片
        for (Product product : products) {
            List<ImageFile> images = imageFileMapper.findByCategoryAndRelatedId("product", product.getId().toString());
            product.setImages(images);
        }
        
        return products;
    }
    
    /**
     * 根据分类获取商品列表
     */
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = productMapper.findByCategory(category);
        
        for (Product product : products) {
            List<ImageFile> images = imageFileMapper.findByCategoryAndRelatedId("product", product.getId().toString());
            product.setImages(images);
        }
        
        return products;
    }
    
    /**
     * 根据ID获取商品详情
     */
    public Product getProductById(Long id) {
        Product product = productMapper.findById(id);
        if (product != null) {
            List<ImageFile> images = imageFileMapper.findByCategoryAndRelatedId("product", product.getId().toString());
            product.setImages(images);
        }
        return product;
    }
    
    /**
     * 添加商品
     */
    public void addProduct(Product product) {
        productMapper.insert(product);
    }
    
    /**
     * 更新商品
     */
    public void updateProduct(Product product) {
        productMapper.update(product);
    }
    
    /**
     * 删除商品
     */
    public void deleteProduct(Long id) {
        productMapper.delete(id);
    }
    
    /**
     * 更新商品状态
     */
    public void updateProductStatus(Long id, Integer status) {
        productMapper.updateStatus(id, status);
    }
    
    /**
     * 根据关键词搜索商品
     */
    public List<Product> searchProducts(String keyword) {
        List<Product> products = productMapper.searchByKeyword(keyword);
        
        // 为每个商品关联图片
        for (Product product : products) {
            List<ImageFile> images = imageFileMapper.findByCategoryAndRelatedId("product", product.getId().toString());
            product.setImages(images);
        }
        
        return products;
    }
}
package com.pdd.mall.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商品规格实体类
 * 存储商品的16种规格组合价格
 */
public class ProductSpec {
    private Long id;
    private Long productId; // 关联的商品ID
    
    // 规格属性
    private String weight;     // 重量规格：0.5kg, 1kg, 2kg, 5kg
    private String sugarType;  // 糖醇类型：no_sugar（不加糖醇）, with_sugar（加糖醇）
    private String coldChain;  // 冷链类型：no_cold（不冷链）, with_cold（冷链）
    
    // 价格信息
    private BigDecimal price;          // 销售价格
    private BigDecimal originalPrice; // 原价（用于显示折扣）
    private BigDecimal costPrice;     // 成本价
    private BigDecimal profitRate;    // 利润率
    
    // 库存信息
    private Integer stockCount;    // 库存数量
    private Integer salesCount;    // 销量
    
    // 状态信息
    private Integer status;        // 状态：1-正常，0-下架
    private Integer sortOrder;    // 排序
    private Integer isDrainage;    // 是否引流款：1-是，0-否
    
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    
    public ProductSpec() {}
    
    public ProductSpec(Long productId, String weight, String sugarType, String coldChain, 
                      BigDecimal price, BigDecimal costPrice, Integer stockCount) {
        this.productId = productId;
        this.weight = weight;
        this.sugarType = sugarType;
        this.coldChain = coldChain;
        this.price = price;
        this.costPrice = costPrice;
        this.stockCount = stockCount;
        this.salesCount = 0;
        this.status = 1;
        this.sortOrder = 0;
        this.isDrainage = 0;
    }
    
    // Getter和Setter方法
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    
    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }
    
    public String getSugarType() { return sugarType; }
    public void setSugarType(String sugarType) { this.sugarType = sugarType; }
    
    public String getColdChain() { return coldChain; }
    public void setColdChain(String coldChain) { this.coldChain = coldChain; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public BigDecimal getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(BigDecimal originalPrice) { this.originalPrice = originalPrice; }
    
    public BigDecimal getCostPrice() { return costPrice; }
    public void setCostPrice(BigDecimal costPrice) { this.costPrice = costPrice; }
    
    public BigDecimal getProfitRate() { return profitRate; }
    public void setProfitRate(BigDecimal profitRate) { this.profitRate = profitRate; }
    
    public Integer getStockCount() { return stockCount; }
    public void setStockCount(Integer stockCount) { this.stockCount = stockCount; }
    
    public Integer getSalesCount() { return salesCount; }
    public void setSalesCount(Integer salesCount) { this.salesCount = salesCount; }
    
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    
    public Integer getIsDrainage() { return isDrainage; }
    public void setIsDrainage(Integer isDrainage) { this.isDrainage = isDrainage; }
    
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
    
    public LocalDateTime getUpdateTime() { return updateTime; }
    public void setUpdateTime(LocalDateTime updateTime) { this.updateTime = updateTime; }
    
    /**
     * 获取规格显示名称
     */
    public String getSpecDisplayName() {
        String sugarDisplay = "no_sugar".equals(sugarType) ? "不加糖醇" : "加糖醇";
        String coldDisplay = "no_cold".equals(coldChain) ? "不冷链" : "冷链";
        return weight + "/" + sugarDisplay + "+" + coldDisplay;
    }
    
    /**
     * 获取规格唯一标识
     */
    public String getSpecKey() {
        return weight + "_" + sugarType + "_" + coldChain;
    }
}
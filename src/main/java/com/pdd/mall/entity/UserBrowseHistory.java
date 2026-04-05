package com.pdd.mall.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 用户浏览记录实体
 */
@Data
public class UserBrowseHistory {

    /**
     * 主键 ID
     */
    private Long id;

    /**
     * 用户 ID
     */
    private Long userId;

    /**
     * 商品 ID
     */
    private Long productId;

    /**
     * 商品名称
     */
    private String productName;

    /**
     * 商品价格
     */
    private BigDecimal productPrice;

    /**
     * 商品主图
     */
    private String productImage;

    /**
     * 商品分类 ID
     */
    private Long categoryId;

    /**
     * 商品分类名称
     */
    private String categoryName;

    /**
     * 浏览时间
     */
    private LocalDateTime browseTime;

    /**
     * 来源：search-搜索，recommend-推荐，link-外链
     */
    private String source;
}

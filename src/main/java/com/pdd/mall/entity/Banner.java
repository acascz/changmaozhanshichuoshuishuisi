package com.pdd.mall.entity;

import java.time.LocalDateTime;

public class Banner {
    private Long id;
    private String imageUrl;
    private String title;
    private String linkUrl;
    private Integer sortOrder;
    private Integer status; // 0:禁用 1:启用
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    // 构造函数
    public Banner() {}

    public Banner(String imageUrl, String title, String linkUrl, Integer sortOrder, Integer status) {
        this.imageUrl = imageUrl;
        this.title = title;
        this.linkUrl = linkUrl;
        this.sortOrder = sortOrder;
        this.status = status;
    }

    // Getter和Setter方法
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }
}
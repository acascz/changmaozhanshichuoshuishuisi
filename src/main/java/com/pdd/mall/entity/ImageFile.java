package com.pdd.mall.entity;

import java.time.LocalDateTime;

/**
 * 统一图片管理实体
 * 支持：商品图片、轮播图、用户头像等多种图片类型
 */
public class ImageFile {
    private Long id;
    private String originalName;     // 原始文件名
    private String storedName;       // 存储文件名（唯一）
    private String filePath;         // 相对路径
    private String fileType;         // 文件类型
    private Long fileSize;           // 文件大小
    private String description;      // 描述
    private String category;         // 图片分类：product-商品图, banner-轮播图, avatar-用户头像, other-其他
    private String relatedId;        // 关联的业务ID（如商品ID、用户ID等）
    private Integer sortOrder;       // 排序序号
    private Integer status;          // 状态：0-禁用，1-启用
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public ImageFile() {}

    // 商品图片构造函数
    public ImageFile(String originalName, String storedName, String filePath, String fileType, Long fileSize, String category, String relatedId) {
        this.originalName = originalName;
        this.storedName = storedName;
        this.filePath = filePath;
        this.fileType = fileType;
        this.fileSize = fileSize;
        this.category = category;
        this.relatedId = relatedId;
        this.status = 1;
    }

    // 轮播图构造函数
    public ImageFile(String originalName, String storedName, String filePath, String fileType, Long fileSize, String category, Integer sortOrder) {
        this.originalName = originalName;
        this.storedName = storedName;
        this.filePath = filePath;
        this.fileType = fileType;
        this.fileSize = fileSize;
        this.category = category;
        this.sortOrder = sortOrder;
        this.status = 1;
    }

    // Getter和Setter方法
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getOriginalName() { return originalName; }
    public void setOriginalName(String originalName) { this.originalName = originalName; }

    public String getStoredName() { return storedName; }
    public void setStoredName(String storedName) { this.storedName = storedName; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }

    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getRelatedId() { return relatedId; }
    public void setRelatedId(String relatedId) { this.relatedId = relatedId; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }

    public LocalDateTime getUpdateTime() { return updateTime; }
    public void setUpdateTime(LocalDateTime updateTime) { this.updateTime = updateTime; }
}
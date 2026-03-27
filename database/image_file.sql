-- 创建统一图片管理表
CREATE TABLE IF NOT EXISTS image_file (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    original_name VARCHAR(500) NOT NULL COMMENT '原始文件名',
    stored_name VARCHAR(500) NOT NULL UNIQUE COMMENT '存储文件名（唯一）',
    file_path VARCHAR(1000) NOT NULL COMMENT '相对路径',
    file_type VARCHAR(100) NOT NULL COMMENT '文件类型',
    file_size BIGINT NOT NULL COMMENT '文件大小（字节）',
    description VARCHAR(1000) COMMENT '描述',
    category VARCHAR(50) NOT NULL COMMENT '图片分类：product-商品图, banner-轮播图, avatar-用户头像, other-其他',
    related_id VARCHAR(100) COMMENT '关联的业务ID（如商品ID、用户ID等）',
    sort_order INT DEFAULT 0 COMMENT '排序序号',
    status TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_category (category),
    INDEX idx_related_id (related_id),
    INDEX idx_category_related (category, related_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='统一图片管理表';

-- 插入测试数据（轮播图）
INSERT INTO image_file (original_name, stored_name, file_path, file_type, file_size, category, sort_order, status) VALUES
('banner1.jpg', 'banner1.jpg', 'banner/banner1.jpg', 'image/jpeg', 102400, 'banner', 1, 1),
('banner2.jpg', 'banner2.jpg', 'banner/banner2.jpg', 'image/jpeg', 105600, 'banner', 2, 1),
('banner3.jpg', 'banner3.jpg', 'banner/banner3.jpg', 'image/jpeg', 98000, 'banner', 3, 1);
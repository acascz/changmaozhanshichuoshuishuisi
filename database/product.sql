-- 创建商品表
CREATE TABLE IF NOT EXISTS product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL COMMENT '商品名称',
    description TEXT COMMENT '商品描述',
    price DECIMAL(10,2) NOT NULL COMMENT '商品价格',
    original_price DECIMAL(10,2) COMMENT '原价',
    sales_count INT DEFAULT 0 COMMENT '销量',
    stock_count INT DEFAULT 0 COMMENT '库存',
    category VARCHAR(50) COMMENT '商品分类',
    tags VARCHAR(200) COMMENT '商品标签',
    status TINYINT DEFAULT 1 COMMENT '状态：0-下架，1-上架',
    sort_order INT DEFAULT 0 COMMENT '排序序号',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 插入商品数据
INSERT INTO product (name, description, price, original_price, sales_count, stock_count, category, tags, sort_order) VALUES
('绿豆饼 传统糕点 手工制作', '传统手工绿豆饼，外皮酥脆，内馅香甜，经典口味', 30.00, 40.00, 0, 100, '传统糕点', '绿豆饼,手工制作,传统糕点', 1),
('绿豆糕(原味) 纯手工无添加', '原味绿豆糕，纯手工制作，无添加防腐剂，口感细腻', 30.00, 40.00, 0, 100, '绿豆糕', '原味,手工制作,无添加', 2),
('桃山月饼 中秋佳节 精美礼盒', '桃山皮月饼，多种口味，精美礼盒包装，中秋送礼佳品', 30.00, 40.00, 0, 100, '月饼', '桃山月饼,中秋,礼盒装', 3),
('绿豆糕(桂花味) 桂花香浓 独立包装', '桂花味绿豆糕，桂花香气浓郁，独立包装，方便携带', 30.00, 40.00, 0, 100, '绿豆糕', '桂花味,独立包装,清香', 4);

-- 插入商品图片记录（如果还没有插入）
INSERT IGNORE INTO image_file (original_name, stored_name, file_path, file_type, file_size, category, related_id, description, sort_order, status) VALUES
('product1.jpg', 'product1.jpg', 'product/product1.jpg', 'image/jpeg', 102400, 'product', '1', '绿豆饼主图', 1, 1),
('product2.jpg', 'product2.jpg', 'product/product2.jpg', 'image/jpeg', 105600, 'product', '2', '原味绿豆糕主图', 1, 1),
('product3.jpg', 'product3.jpg', 'product/product3.jpg', 'image/jpeg', 98000, 'product', '3', '桃山月饼主图', 1, 1),
('product4.jpg', 'product4.jpg', 'product/product4.jpg', 'image/jpeg', 110000, 'product', '4', '桂花味绿豆糕主图', 1, 1);
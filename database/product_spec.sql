-- 商品规格价格表
CREATE TABLE IF NOT EXISTS product_spec (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '规格ID',
    product_id BIGINT NOT NULL COMMENT '商品ID',
    
    -- 规格属性
    weight VARCHAR(20) NOT NULL COMMENT '重量规格：0.5kg, 1kg, 2kg, 5kg',
    sugar_type VARCHAR(20) NOT NULL COMMENT '糖醇类型：no_sugar（不加糖醇）, with_sugar（加糖醇）',
    cold_chain VARCHAR(20) NOT NULL COMMENT '冷链类型：no_cold（不冷链）, with_cold（冷链）',
    
    -- 价格信息
    price DECIMAL(10,2) NOT NULL COMMENT '销售价格',
    original_price DECIMAL(10,2) COMMENT '原价（用于显示折扣）',
    cost_price DECIMAL(10,2) COMMENT '成本价',
    profit_rate DECIMAL(5,2) COMMENT '利润率',
    
    -- 库存信息
    stock_count INT DEFAULT 100 COMMENT '库存数量',
    sales_count INT DEFAULT 0 COMMENT '销量',
    
    -- 状态信息
    status TINYINT DEFAULT 1 COMMENT '状态：1-正常，0-下架',
    sort_order INT DEFAULT 0 COMMENT '排序',
    is_drainage TINYINT DEFAULT 0 COMMENT '是否引流款：1-是，0-否',
    
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    -- 索引
    INDEX idx_product_id (product_id),
    INDEX idx_spec (weight, sugar_type, cold_chain),
    INDEX idx_status (status),
    
    -- 外键约束
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品规格价格表';

-- 插入商品规格价格数据（基于您提供的定价）
-- 商品1：绿豆糕 经典原味 传统糕点
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg规格
(1, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(1, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(1, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(1, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg规格
(1, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(1, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(1, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(1, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg规格
(1, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(1, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(1, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(1, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg规格
(1, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(1, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(1, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(1, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);

-- 商品2：绿豆糕(原味) 纯手工无添加
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg规格
(2, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(2, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(2, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(2, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg规格
(2, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(2, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(2, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(2, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg规格
(2, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(2, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(2, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(2, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg规格
(2, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(2, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(2, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(2, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);

-- 商品3：桃山月饼 中秋佳节 精美礼盒
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg规格
(3, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(3, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(3, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(3, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg规格
(3, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(3, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(3, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(3, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg规格
(3, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(3, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(3, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(3, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg规格
(3, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(3, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(3, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(3, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);

-- 商品4：绿豆糕(桂花味) 桂花香浓 独立包装
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg规格
(4, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(4, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(4, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(4, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg规格
(4, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(4, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(4, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(4, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg规格
(4, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(4, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(4, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(4, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg规格
(4, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(4, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(4, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(4, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);
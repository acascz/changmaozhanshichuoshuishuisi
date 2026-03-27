-- Product specification price table
CREATE TABLE IF NOT EXISTS product_spec (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    
    -- Specification attributes
    weight VARCHAR(20) NOT NULL,
    sugar_type VARCHAR(20) NOT NULL,
    cold_chain VARCHAR(20) NOT NULL,
    
    -- Price information
    price DECIMAL(10,2) NOT NULL,
    original_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    profit_rate DECIMAL(5,2),
    
    -- Stock information
    stock_count INT DEFAULT 100,
    sales_count INT DEFAULT 0,
    
    -- Status information
    status TINYINT DEFAULT 1,
    sort_order INT DEFAULT 0,
    is_drainage TINYINT DEFAULT 0,
    
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_product_id (product_id),
    INDEX idx_spec (weight, sugar_type, cold_chain),
    INDEX idx_status (status),
    
    -- Foreign key constraint
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

-- Insert product specification price data
-- Product 1: Mung Bean Cake Classic Original Flavor
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg specifications
(1, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(1, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(1, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(1, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg specifications
(1, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(1, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(1, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(1, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg specifications
(1, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(1, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(1, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(1, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg specifications
(1, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(1, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(1, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(1, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);

-- Product 2: Mung Bean Cake Original Flavor
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg specifications
(2, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(2, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(2, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(2, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg specifications
(2, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(2, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(2, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(2, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg specifications
(2, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(2, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(2, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(2, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg specifications
(2, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(2, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(2, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(2, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);

-- Product 3: Peach Mountain Mooncake
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg specifications
(3, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(3, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(3, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(3, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg specifications
(3, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(3, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(3, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(3, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg specifications
(3, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(3, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(3, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(3, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg specifications
(3, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(3, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(3, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(3, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);

-- Product 4: Mung Bean Cake Osmanthus Flavor
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, cost_price, profit_rate, stock_count) VALUES
-- 0.5kg specifications
(4, '0.5kg', 'no_sugar', 'no_cold', 17.90, 16.67, 5.00, 100),
(4, '0.5kg', 'with_sugar', 'no_cold', 18.90, 17.67, 5.00, 100),
(4, '0.5kg', 'no_sugar', 'with_cold', 24.90, 23.67, 5.00, 100),
(4, '0.5kg', 'with_sugar', 'with_cold', 25.90, 24.67, 5.00, 100),

-- 1kg specifications
(4, '1kg', 'no_sugar', 'no_cold', 28.90, 27.33, 5.00, 100),
(4, '1kg', 'with_sugar', 'no_cold', 30.90, 29.33, 5.00, 100),
(4, '1kg', 'no_sugar', 'with_cold', 36.90, 35.33, 5.00, 100),
(4, '1kg', 'with_sugar', 'with_cold', 38.90, 37.33, 5.00, 100),

-- 2kg specifications
(4, '2kg', 'no_sugar', 'no_cold', 48.90, 46.67, 5.00, 100),
(4, '2kg', 'with_sugar', 'no_cold', 52.90, 50.67, 5.00, 100),
(4, '2kg', 'no_sugar', 'with_cold', 59.90, 56.67, 5.00, 100),
(4, '2kg', 'with_sugar', 'with_cold', 63.90, 60.67, 5.00, 100),

-- 5kg specifications
(4, '5kg', 'no_sugar', 'no_cold', 112.90, 106.67, 5.00, 100),
(4, '5kg', 'with_sugar', 'no_cold', 122.90, 116.67, 5.00, 100),
(4, '5kg', 'no_sugar', 'with_cold', 127.90, 121.67, 5.00, 100),
(4, '5kg', 'with_sugar', 'with_cold', 137.90, 131.67, 5.00, 100);
-- 插入商品 14-17 的规格价格数据
-- 每个商品都有 16 种规格组合（4 个重量 × 2 个糖醇属性 × 2 个冷链属性）

-- 商品 14：原味绿豆糕
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, original_price, cost_price, stock_count, status, sort_order) VALUES
(14, '0.5kg', 'no_sugar', 'no_cold', 17.90, 25.90, 12.00, 100, 1, 1),
(14, '0.5kg', 'no_sugar', 'with_cold', 22.90, 30.90, 16.00, 100, 1, 2),
(14, '0.5kg', 'with_sugar', 'no_cold', 18.90, 26.90, 13.00, 100, 1, 3),
(14, '0.5kg', 'with_sugar', 'with_cold', 23.90, 31.90, 17.00, 100, 1, 4),
(14, '1kg', 'no_sugar', 'no_cold', 32.90, 45.90, 22.00, 100, 1, 5),
(14, '1kg', 'no_sugar', 'with_cold', 37.90, 50.90, 26.00, 100, 1, 6),
(14, '1kg', 'with_sugar', 'no_cold', 33.90, 46.90, 23.00, 100, 1, 7),
(14, '1kg', 'with_sugar', 'with_cold', 38.90, 51.90, 27.00, 100, 1, 8),
(14, '2kg', 'no_sugar', 'no_cold', 62.90, 85.90, 42.00, 100, 1, 9),
(14, '2kg', 'no_sugar', 'with_cold', 67.90, 90.90, 46.00, 100, 1, 10),
(14, '2kg', 'with_sugar', 'no_cold', 63.90, 86.90, 43.00, 100, 1, 11),
(14, '2kg', 'with_sugar', 'with_cold', 68.90, 91.90, 47.00, 100, 1, 12),
(14, '5kg', 'no_sugar', 'no_cold', 152.90, 205.90, 102.00, 100, 1, 13),
(14, '5kg', 'no_sugar', 'with_cold', 157.90, 210.90, 106.00, 100, 1, 14),
(14, '5kg', 'with_sugar', 'no_cold', 153.90, 206.90, 103.00, 100, 1, 15),
(14, '5kg', 'with_sugar', 'with_cold', 158.90, 211.90, 107.00, 100, 1, 16);

-- 商品 15：原味绿豆糕（礼盒装）
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, original_price, cost_price, stock_count, status, sort_order) VALUES
(15, '0.5kg', 'no_sugar', 'no_cold', 19.90, 27.90, 14.00, 100, 1, 1),
(15, '0.5kg', 'no_sugar', 'with_cold', 24.90, 32.90, 18.00, 100, 1, 2),
(15, '0.5kg', 'with_sugar', 'no_cold', 20.90, 28.90, 15.00, 100, 1, 3),
(15, '0.5kg', 'with_sugar', 'with_cold', 25.90, 33.90, 19.00, 100, 1, 4),
(15, '1kg', 'no_sugar', 'no_cold', 36.90, 49.90, 26.00, 100, 1, 5),
(15, '1kg', 'no_sugar', 'with_cold', 41.90, 54.90, 30.00, 100, 1, 6),
(15, '1kg', 'with_sugar', 'no_cold', 37.90, 50.90, 27.00, 100, 1, 7),
(15, '1kg', 'with_sugar', 'with_cold', 42.90, 55.90, 31.00, 100, 1, 8),
(15, '2kg', 'no_sugar', 'no_cold', 70.90, 93.90, 50.00, 100, 1, 9),
(15, '2kg', 'no_sugar', 'with_cold', 75.90, 98.90, 54.00, 100, 1, 10),
(15, '2kg', 'with_sugar', 'no_cold', 71.90, 94.90, 51.00, 100, 1, 11),
(15, '2kg', 'with_sugar', 'with_cold', 76.90, 99.90, 55.00, 100, 1, 12),
(15, '5kg', 'no_sugar', 'no_cold', 172.90, 225.90, 122.00, 100, 1, 13),
(15, '5kg', 'no_sugar', 'with_cold', 177.90, 230.90, 126.00, 100, 1, 14),
(15, '5kg', 'with_sugar', 'no_cold', 173.90, 226.90, 123.00, 100, 1, 15),
(15, '5kg', 'with_sugar', 'with_cold', 178.90, 231.90, 127.00, 100, 1, 16);

-- 商品 16：多口味绿豆糕（原味、豆沙味、蛋黄味）
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, original_price, cost_price, stock_count, status, sort_order) VALUES
(16, '0.5kg', 'no_sugar', 'no_cold', 21.90, 29.90, 16.00, 100, 1, 1),
(16, '0.5kg', 'no_sugar', 'with_cold', 26.90, 34.90, 20.00, 100, 1, 2),
(16, '0.5kg', 'with_sugar', 'no_cold', 22.90, 30.90, 17.00, 100, 1, 3),
(16, '0.5kg', 'with_sugar', 'with_cold', 27.90, 35.90, 21.00, 100, 1, 4),
(16, '1kg', 'no_sugar', 'no_cold', 40.90, 53.90, 30.00, 100, 1, 5),
(16, '1kg', 'no_sugar', 'with_cold', 45.90, 58.90, 34.00, 100, 1, 6),
(16, '1kg', 'with_sugar', 'no_cold', 41.90, 54.90, 31.00, 100, 1, 7),
(16, '1kg', 'with_sugar', 'with_cold', 46.90, 59.90, 35.00, 100, 1, 8),
(16, '2kg', 'no_sugar', 'no_cold', 78.90, 101.90, 58.00, 100, 1, 9),
(16, '2kg', 'no_sugar', 'with_cold', 83.90, 106.90, 62.00, 100, 1, 10),
(16, '2kg', 'with_sugar', 'no_cold', 79.90, 102.90, 59.00, 100, 1, 11),
(16, '2kg', 'with_sugar', 'with_cold', 84.90, 107.90, 63.00, 100, 1, 12),
(16, '5kg', 'no_sugar', 'no_cold', 192.90, 245.90, 142.00, 100, 1, 13),
(16, '5kg', 'no_sugar', 'with_cold', 197.90, 250.90, 146.00, 100, 1, 14),
(16, '5kg', 'with_sugar', 'no_cold', 193.90, 246.90, 143.00, 100, 1, 15),
(16, '5kg', 'with_sugar', 'with_cold', 198.90, 251.90, 147.00, 100, 1, 16);

-- 商品 17：桂花味绿豆糕
INSERT INTO product_spec (product_id, weight, sugar_type, cold_chain, price, original_price, cost_price, stock_count, status, sort_order) VALUES
(17, '0.5kg', 'no_sugar', 'no_cold', 19.90, 27.90, 14.00, 100, 1, 1),
(17, '0.5kg', 'no_sugar', 'with_cold', 24.90, 32.90, 18.00, 100, 1, 2),
(17, '0.5kg', 'with_sugar', 'no_cold', 20.90, 28.90, 15.00, 100, 1, 3),
(17, '0.5kg', 'with_sugar', 'with_cold', 25.90, 33.90, 19.00, 100, 1, 4),
(17, '1kg', 'no_sugar', 'no_cold', 36.90, 49.90, 26.00, 100, 1, 5),
(17, '1kg', 'no_sugar', 'with_cold', 41.90, 54.90, 30.00, 100, 1, 6),
(17, '1kg', 'with_sugar', 'no_cold', 37.90, 50.90, 27.00, 100, 1, 7),
(17, '1kg', 'with_sugar', 'with_cold', 42.90, 55.90, 31.00, 100, 1, 8),
(17, '2kg', 'no_sugar', 'no_cold', 70.90, 93.90, 50.00, 100, 1, 9),
(17, '2kg', 'no_sugar', 'with_cold', 75.90, 98.90, 54.00, 100, 1, 10),
(17, '2kg', 'with_sugar', 'no_cold', 71.90, 94.90, 51.00, 100, 1, 11),
(17, '2kg', 'with_sugar', 'with_cold', 76.90, 99.90, 55.00, 100, 1, 12),
(17, '5kg', 'no_sugar', 'no_cold', 172.90, 225.90, 122.00, 100, 1, 13),
(17, '5kg', 'no_sugar', 'with_cold', 177.90, 230.90, 126.00, 100, 1, 14),
(17, '5kg', 'with_sugar', 'no_cold', 173.90, 226.90, 123.00, 100, 1, 15),
(17, '5kg', 'with_sugar', 'with_cold', 178.90, 231.90, 127.00, 100, 1, 16);

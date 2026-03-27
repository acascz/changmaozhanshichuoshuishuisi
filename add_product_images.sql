-- 添加商品图片记录到 image_file 表
USE mung_bean_cake_mall;

-- 商品 1 图片
INSERT INTO image_file (original_name, stored_name, file_path, file_type, file_size, category, related_id, sort_order, status)
VALUES ('product1.jpg', 'product1.jpg', '/images/product/product1.jpg', 'image/jpeg', 50000, 'product', '1', 0, 1);

-- 商品 2 图片
INSERT INTO image_file (original_name, stored_name, file_path, file_type, file_size, category, related_id, sort_order, status)
VALUES ('product2.jpg', 'product2.jpg', '/images/product/product2.jpg', 'image/jpeg', 50000, 'product', '2', 0, 1);

-- 商品 3 图片
INSERT INTO image_file (original_name, stored_name, file_path, file_type, file_size, category, related_id, sort_order, status)
VALUES ('product3.jpg', 'product3.jpg', '/images/product/product3.jpg', 'image/jpeg', 50000, 'product', '3', 0, 1);

-- 商品 4 图片
INSERT INTO image_file (original_name, stored_name, file_path, file_type, file_size, category, related_id, sort_order, status)
VALUES ('product4.jpg', 'product4.jpg', '/images/product/product4.jpg', 'image/jpeg', 50000, 'product', '4', 0, 1);

-- 验证插入结果
SELECT id, original_name, file_path, category, related_id FROM image_file WHERE category = 'product';

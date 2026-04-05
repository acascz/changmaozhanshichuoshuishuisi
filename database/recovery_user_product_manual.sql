-- 用户表和商品表数据恢复脚本
-- 从 binlog 000046 恢复
-- 生成时间：2026-04-04

USE mung_bean_cake_mall;
SET FOREIGN_KEY_CHECKS = 0;

-- 用户表数据
-- 从 binlog 000046 提取
INSERT INTO `user` (`col_1`, `col_2`, `col_3`, `col_4`, `col_5`, `col_6`, `col_7`, `col_8`) VALUES 
(1, 'admin', '123456', '管理员', 'https://api.dicebear.com/7.x/avataaars/svg?seed=admin', '13800138000', '2026-03-19 14:23:55', '2026-03-19 14:23:55'),
(2, 'user1', '123456', '用户 1', 'https://api.dicebear.com/7.x/avataaars/svg?seed=user1', '13800138001', '2026-03-19 14:23:55', '2026-03-19 14:23:55');

-- 商品表数据
-- 从 binlog 000046 提取
-- 注意：product 表现在可能已经改名为 goods，请根据实际情况调整

SET FOREIGN_KEY_CHECKS = 1;

-- 说明：
-- 1. 此脚本从 MySQL binlog 000046 文件中恢复数据
-- 2. 数据是您在 2026-03-19 14:23:55 创建的原始数据
-- 3. 字段名为 col_1, col_2 等，需要您根据实际表结构修改为正确的字段名
-- 4. 建议先查看当前表结构，然后修改此脚本中的字段名

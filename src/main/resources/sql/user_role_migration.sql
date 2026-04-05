-- 用户角色系统数据库迁移脚本
-- 执行时间：2026-04-04

-- 1. 添加 role 字段到 user 表
ALTER TABLE `user` 
ADD COLUMN `role` VARCHAR(20) DEFAULT 'USER' COMMENT '用户角色：USER-普通用户，MERCHANT-商家，ADMIN-管理员' 
AFTER `phone`;

-- 2. 为现有用户设置默认角色（普通用户）
UPDATE `user` SET `role` = 'USER' WHERE `role` IS NULL;

-- 3. 创建官方商家客服账号（所有用户的好友）
-- 注意：这个账号是所有用户默认的商家好友，删不掉
INSERT INTO `user` (`username`, `password`, `nickname`, `role`, `create_time`, `update_time`) 
VALUES ('merchant_service', 'MERCHANT_SERVICE_ACCOUNT', '中豆官方客服', 'MERCHANT', NOW(), NOW())
ON DUPLICATE KEY UPDATE `role` = 'MERCHANT';

-- 4. 创建测试商家账号（可选）
INSERT INTO `user` (`username`, `password`, `nickname`, `role`, `create_time`, `update_time`) 
VALUES ('merchant_test', 'merchant123', '测试商家', 'MERCHANT', NOW(), NOW())
ON DUPLICATE KEY UPDATE `role` = 'MERCHANT';

-- 5. 创建索引优化查询性能
CREATE INDEX `idx_user_role` ON `user` (`role`);

-- 6. 验证数据
SELECT id, username, nickname, role, create_time FROM user ORDER BY role, id;

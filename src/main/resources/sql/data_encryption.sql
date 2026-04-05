-- 用户敏感数据加密存储示例

-- 1. 为用户表添加加密字段
ALTER TABLE `user` ADD COLUMN `phone_encrypted` varchar(100) DEFAULT NULL COMMENT '加密的手机号';
ALTER TABLE `user` ADD COLUMN `email_encrypted` varchar(100) DEFAULT NULL COMMENT '加密的邮箱';

-- 2. 创建敏感数据加密日志表
CREATE TABLE IF NOT EXISTS `data_encryption_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) NOT NULL COMMENT '表名',
  `record_id` bigint(20) NOT NULL COMMENT '记录 ID',
  `field_name` varchar(50) NOT NULL COMMENT '字段名',
  `operation_type` varchar(20) NOT NULL COMMENT '操作类型：ENCRYPT,DECRYPT',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人 ID',
  `operation_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `idx_table_record` (`table_name`, `record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据加密日志表';

-- 3. 创建数据脱敏视图（用于查询时自动脱敏）
CREATE OR REPLACE VIEW `v_user_safe` AS
SELECT 
    id,
    username,
    nickname,
    avatar,
    -- 手机号脱敏：只显示前 3 位和后 4 位
    CASE 
        WHEN phone IS NOT NULL THEN CONCAT(LEFT(phone, 3), '****', RIGHT(phone, 4))
        ELSE NULL
    END AS phone_masked,
    -- 邮箱脱敏：只显示前 3 位和域名
    CASE 
        WHEN email IS NOT NULL THEN CONCAT(LEFT(email, 3), '***', SUBSTRING(email, LOCATE('@', email)))
        ELSE NULL
    END AS email_masked,
    signature,
    gender,
    ip,
    create_time
FROM `user`;

-- 4. 创建访问控制策略表
CREATE TABLE IF NOT EXISTS `data_access_policy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(100) NOT NULL COMMENT '策略名称',
  `table_name` varchar(50) NOT NULL COMMENT '表名',
  `field_name` varchar(50) DEFAULT NULL COMMENT '字段名，NULL 表示整表',
  `access_level` int NOT NULL DEFAULT '1' COMMENT '访问级别：1-公开，2-登录用户，3-管理员',
  `description` varchar(200) DEFAULT NULL COMMENT '策略描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_table_field` (`table_name`, `field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据访问控制策略表';

-- 插入默认策略
INSERT INTO `data_access_policy` (`policy_name`, `table_name`, `field_name`, `access_level`, `description`) VALUES
('用户公开信息', 'user', NULL, 1, '用户基本信息可公开访问'),
('用户敏感信息', 'user', 'phone', 3, '手机号仅管理员可访问'),
('用户敏感信息', 'user', 'email', 3, '邮箱仅管理员可访问'),
('用户敏感信息', 'user', 'password', 3, '密码仅系统可访问');

-- 5. 创建审计日志表（记录所有敏感数据访问）
CREATE TABLE IF NOT EXISTS `data_access_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '访问用户 ID',
  `table_name` varchar(50) NOT NULL COMMENT '访问的表',
  `record_id` bigint(20) NOT NULL COMMENT '访问的记录 ID',
  `operation_type` varchar(20) NOT NULL COMMENT '操作类型：SELECT,INSERT,UPDATE,DELETE',
  `access_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  `ip_address` varchar(50) DEFAULT NULL COMMENT '访问 IP',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '用户代理',
  PRIMARY KEY (`id`),
  KEY `idx_user_time` (`user_id`, `access_time`),
  KEY `idx_table_record` (`table_name`, `record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据访问审计表';

-- 6. 创建触发器：记录敏感数据访问
DELIMITER $$

CREATE TRIGGER `trg_user_access_audit`
AFTER SELECT ON `user`
FOR EACH ROW
BEGIN
    -- 这里需要在应用层实现，MySQL 触发器不支持 SELECT 审计
    -- 实际应该在 Service 层或拦截器中实现
END$$

DELIMITER ;

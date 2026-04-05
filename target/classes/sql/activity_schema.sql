-- 活动配置表
CREATE TABLE IF NOT EXISTS `activity_config` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '活动 ID',
    `name` VARCHAR(100) NOT NULL COMMENT '活动名称',
    `type` INT NOT NULL COMMENT '活动类型：1-满减，2-折扣，3-秒杀，4-团购，5-优惠券',
    `discount_rate` DECIMAL(3,2) DEFAULT 1.00 COMMENT '折扣系数 (如 0.9 表示 9 折)',
    `fixed_discount` DECIMAL(10,2) DEFAULT 0.00 COMMENT '固定减免金额',
    `min_amount` DECIMAL(10,2) DEFAULT 0.00 COMMENT '最低消费金额',
    `stackable` INT DEFAULT 0 COMMENT '是否可叠加 (0-否，1-是)',
    `priority` INT DEFAULT 99 COMMENT '优先级 (数字越小优先级越高)',
    `status` INT DEFAULT 0 COMMENT '状态：0-未开始，1-进行中，2-已结束，3-已禁用',
    `start_time` DATETIME NOT NULL COMMENT '开始时间',
    `end_time` DATETIME NOT NULL COMMENT '结束时间',
    `description` TEXT COMMENT '活动描述',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX `idx_status` (`status`),
    INDEX `idx_time` (`start_time`, `end_time`),
    INDEX `idx_priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动配置表';

-- 插入测试数据
INSERT INTO activity_config (name, type, discount_rate, fixed_discount, min_amount, stackable, priority, status, start_time, end_time, description) VALUES
('双 11 满减活动', 1, 1.00, 20.00, 100.00, 0, 1, 1, '2025-11-01 00:00:00', '2025-11-11 23:59:59', '满 100 减 20'),
('新用户 9 折优惠', 2, 0.90, 0.00, 0.00, 1, 2, 1, '2025-01-01 00:00:00', '2025-12-31 23:59:59', '新用户专享 9 折'),
('限时秒杀', 3, 1.00, 0.00, 0.00, 0, 0, 0, '2025-12-01 00:00:00', '2025-12-01 23:59:59', '秒杀活动（未开始）');

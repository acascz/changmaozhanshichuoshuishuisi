-- 好友系统测试数据
-- 用于在数据库中手动添加测试好友数据
-- 执行方式：在 MySQL 客户端中执行 source 命令或直接复制执行

USE mung_bean_cake_mall;

-- 创建好友表（如果不存在）
CREATE TABLE IF NOT EXISTS `user_friend` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `friend_id` BIGINT NOT NULL COMMENT '好友 ID',
    `friend_group_id` BIGINT DEFAULT NULL COMMENT '好友分组 ID',
    `friend_remark` VARCHAR(100) DEFAULT NULL COMMENT '好友备注名',
    `friend_status` TINYINT DEFAULT 1 COMMENT '好友状态：1-正常，2-已拉黑，3-已删除',
    `is_star` TINYINT DEFAULT 0 COMMENT '是否星标：0-否，1-是',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_friend` (`user_id`, `friend_id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_friend_id` (`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户好友关系表';

-- 插入测试数据（用户 ID 1 的好友列表）
-- 这些好友会在聊天界面显示
INSERT INTO `user_friend` (`user_id`, `friend_id`, `friend_remark`, `friend_status`, `is_star`, `create_time`) VALUES
(1, 2, '英♡ㄩ\'ʰ', 1, 0, NOW()),
(1, 3, '笨蛋总是掉眼泪', 1, 0, NOW()),
(1, 4, '辛苦快乐', 1, 0, NOW()),
(1, 5, '阿帆', 1, 0, NOW()),
(1, 6, '-', 1, 1, NOW());

-- 插入反向关系（确保双向好友）
INSERT INTO `user_friend` (`user_id`, `friend_id`, `friend_remark`, `friend_status`, `is_star`, `create_time`) VALUES
(2, 1, '用户 1', 1, 0, NOW()),
(3, 1, '用户 1', 1, 0, NOW()),
(4, 1, '用户 1', 1, 0, NOW()),
(5, 1, '用户 1', 1, 0, NOW()),
(6, 1, '用户 1', 1, 0, NOW());

-- 查询验证
SELECT * FROM user_friend WHERE user_id = 1;

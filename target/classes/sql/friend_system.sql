-- 好友系统表结构
-- 创建时间：2026-04-04

-- 1. 用户好友关系表
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

-- 2. 好友分组表
CREATE TABLE IF NOT EXISTS `friend_group` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `group_name` VARCHAR(50) NOT NULL COMMENT '分组名称',
    `sort_order` INT DEFAULT 0 COMMENT '排序顺序',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    PRIMARY KEY (`id`),
    INDEX `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友分组表';

-- 3. 好友申请记录表
CREATE TABLE IF NOT EXISTS `friend_request` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
    `sender_id` BIGINT NOT NULL COMMENT '发送者 ID',
    `receiver_id` BIGINT NOT NULL COMMENT '接收者 ID',
    `request_message` VARCHAR(200) DEFAULT NULL COMMENT '申请消息',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待处理，1-已同意，2-已拒绝',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    `handle_time` DATETIME DEFAULT NULL COMMENT '处理时间',
    
    PRIMARY KEY (`id`),
    INDEX `idx_sender` (`sender_id`),
    INDEX `idx_receiver` (`receiver_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友申请记录表';

-- 插入测试数据
-- 假设用户 ID 1 是当前登录用户
INSERT INTO `user_friend` (`user_id`, `friend_id`, `friend_remark`, `friend_status`, `is_star`) VALUES
(1, 2, '英♡ㄩ\'ʰ', 1, 0),
(1, 3, '笨蛋总是掉眼泪', 1, 0),
(1, 4, '辛苦快乐', 1, 0),
(1, 5, '阿帆', 1, 0),
(1, 6, '-', 1, 1);

-- 插入对应的反向关系（好友关系是双向的）
INSERT INTO `user_friend` (`user_id`, `friend_id`, `friend_remark`, `friend_status`, `is_star`) VALUES
(2, 1, '用户 1', 1, 0),
(3, 1, '用户 1', 1, 0),
(4, 1, '用户 1', 1, 0),
(5, 1, '用户 1', 1, 0),
(6, 1, '用户 1', 1, 0);

-- 插入默认好友分组
INSERT INTO `friend_group` (`user_id`, `group_name`, `sort_order`) VALUES
(1, '拼多多好友', 1),
(1, '家人', 2),
(1, '同事', 3);

-- 聊天系统第五阶段：群聊与客服系统
-- 执行时间：2026-04-04

-- 1. 创建群聊表
CREATE TABLE IF NOT EXISTS `chat_group` (
  `group_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '群聊 ID',
  `group_no` VARCHAR(32) NOT NULL COMMENT '群号（唯一）',
  `group_name` VARCHAR(100) NOT NULL COMMENT '群名称',
  `group_avatar` VARCHAR(255) DEFAULT NULL COMMENT '群头像',
  `group_notice` TEXT DEFAULT NULL COMMENT '群公告',
  `creator_id` BIGINT NOT NULL COMMENT '创建者 ID',
  `max_members` INT DEFAULT 500 COMMENT '最大成员数',
  `member_count` INT DEFAULT 0 COMMENT '当前成员数',
  `status` TINYINT DEFAULT 1 COMMENT '群状态：1-正常，2-禁言，3-解散',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `uk_group_no` (`group_no`),
  KEY `idx_creator_id` (`creator_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群聊表';

-- 2. 创建会话成员表（如果不存在）
CREATE TABLE IF NOT EXISTS `chat_session_member` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录 ID',
  `session_id` VARCHAR(64) NOT NULL COMMENT '会话 ID',
  `user_id` BIGINT NOT NULL COMMENT '用户 ID',
  `role` TINYINT DEFAULT 0 COMMENT '角色：0-普通成员，1-管理员，2-群主（仅群聊）',
  `session_key` VARCHAR(255) DEFAULT NULL COMMENT '会话密钥（群组加密时使用）',
  `join_time` DATETIME DEFAULT NULL COMMENT '加入时间',
  `leave_time` DATETIME DEFAULT NULL COMMENT '退出时间',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_session_user` (`session_id`, `user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天会话成员表';

-- 3. 更新 chat_session 表，添加 status 字段（如果不存在）
ALTER TABLE `chat_session` 
ADD COLUMN IF NOT EXISTS `status` TINYINT DEFAULT 1 COMMENT '会话状态：1-进行中，2-已结束，3-已删除' AFTER `creator_id`;

-- 4. 插入测试数据

-- 插入测试群聊
INSERT INTO `chat_group` (`group_no`, `group_name`, `group_avatar`, `creator_id`, `max_members`, `member_count`, `status`) 
VALUES 
('G20260404001', '技术交流群', NULL, 10001, 500, 3, 1),
('G20260404002', '产品讨论群', NULL, 10002, 200, 2, 1),
('G20260404003', '客服团队', NULL, 10003, 50, 1, 1);

-- 插入测试会话成员
INSERT INTO `chat_session_member` (`session_id`, `user_id`, `role`, `join_time`) 
VALUES 
('group_1', 10001, 2, NOW()), -- 群主
('group_1', 10002, 1, NOW()), -- 普通成员
('group_1', 10003, 1, NOW()), -- 普通成员
('group_2', 10002, 2, NOW()),
('group_2', 10001, 1, NOW()),
('group_3', 10003, 2, NOW()),
('group_3', 10004, 1, NOW());

-- 插入客服会话示例
INSERT INTO `chat_session` (`session_id`, `session_type`, `session_name`, `creator_id`, `status`)
VALUES 
('service_10001', 1, '客服咨询', 10001, 1);

INSERT INTO `chat_session_member` (`session_id`, `user_id`, `role`, `join_time`)
VALUES 
('service_10001', 10001, 0, NOW()),
('service_10001', 20001, 1, NOW()); -- 客服人员

-- 完成提示
SELECT '第五阶段数据库更新完成！' AS status;

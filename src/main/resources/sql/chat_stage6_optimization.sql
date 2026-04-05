-- 聊天系统第六阶段：功能完善与优化
-- 执行时间：2026-04-04

-- 1. 创建客服评价表
CREATE TABLE IF NOT EXISTS `service_rating` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '评价 ID',
  `session_id` VARCHAR(64) NOT NULL COMMENT '会话 ID',
  `user_id` BIGINT NOT NULL COMMENT '用户 ID',
  `service_id` BIGINT NOT NULL COMMENT '客服 ID',
  `rating` TINYINT NOT NULL COMMENT '评分（1-5 星）',
  `comment` TEXT DEFAULT NULL COMMENT '评价内容',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_session_id` (`session_id`),
  KEY `idx_service_id` (`service_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客服评价表';

-- 2. 为 chat_group 表添加索引
ALTER TABLE `chat_group`
ADD INDEX `idx_member_count` (`member_count`),
ADD INDEX `idx_status_created` (`status`, `create_time`);

-- 3. 为 chat_session_member 表添加索引
ALTER TABLE `chat_session_member`
ADD INDEX `idx_role_join` (`role`, `join_time`);

-- 4. 插入测试评价数据
INSERT INTO `service_rating` (`session_id`, `user_id`, `service_id`, `rating`, `comment`) 
VALUES 
('service_10001', 10001, 20001, 5, '客服态度很好，解决问题很快！'),
('service_10002', 10002, 20001, 4, '响应速度快，专业'),
('service_10003', 10003, 20002, 5, '非常满意！'),
('service_10004', 10004, 20002, 3, '一般般吧'),
('service_10005', 10005, 20001, 5, '超级棒的客服体验');

-- 完成提示
SELECT '第六阶段数据库更新完成！' AS status;

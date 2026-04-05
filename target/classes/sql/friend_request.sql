-- 好友申请表
CREATE TABLE IF NOT EXISTS `friend_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '申请 ID',
  `requester_id` bigint(20) NOT NULL COMMENT '申请人 ID',
  `target_id` bigint(20) NOT NULL COMMENT '被申请人 ID',
  `remark` varchar(200) DEFAULT NULL COMMENT '申请备注信息',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '申请状态：0-待处理，1-已同意，2-已拒绝，3-已撤回',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `handle_time` datetime DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`),
  KEY `idx_requester` (`requester_id`),
  KEY `idx_target` (`target_id`),
  KEY `idx_status` (`status`),
  KEY `idx_request_target` (`requester_id`, `target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友申请表';

-- 插入测试数据
INSERT INTO `friend_request` (`requester_id`, `target_id`, `remark`, `status`, `create_time`) VALUES
(2, 1, '你好，我想加你为好友', 0, NOW()),
(3, 1, '我是你的朋友', 0, NOW());

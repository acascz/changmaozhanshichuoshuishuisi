-- 禁用外键检查
SET FOREIGN_KEY_CHECKS = 0;

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mung_bean_cake_mall;

-- 注意：以下创建表语句使用 IF NOT EXISTS，不会删除现有表和数据

-- 用户表
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户 ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(100) NOT NULL COMMENT '密码',
    `nickname` VARCHAR(50) DEFAULT NULL COMMENT '昵称',
    `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像 URL',
    `header_background` VARCHAR(255) DEFAULT NULL COMMENT '主页背景图',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
    `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    `role` VARCHAR(20) DEFAULT 'USER' COMMENT '角色：USER-用户，MERCHANT-商家，ADMIN-管理员',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-正常',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 商品表
CREATE TABLE `goods` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品 ID',
    `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `description` TEXT COMMENT '商品描述',
    `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
    `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '原价',
    `stock` INT DEFAULT 0 COMMENT '库存',
    `image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片 URL',
    `images` TEXT COMMENT '商品图片列表 (JSON)',
    `sales` INT DEFAULT 0 COMMENT '销量',
    `category` VARCHAR(50) DEFAULT NULL COMMENT '分类',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-下架，1-上架',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 库存表
CREATE TABLE `inventory` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '库存 ID',
    `goods_id` BIGINT NOT NULL COMMENT '商品 ID',
    `stock` INT DEFAULT 0 COMMENT '库存数量',
    `locked_stock` INT DEFAULT 0 COMMENT '锁定库存',
    `available_stock` INT DEFAULT 0 COMMENT '可用库存',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存表';

-- 活动配置表
CREATE TABLE `activity_config` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '活动 ID',
    `name` VARCHAR(100) NOT NULL COMMENT '活动名称',
    `type` INT NOT NULL COMMENT '活动类型：1-满减，2-折扣，3-秒杀，4-团购，5-优惠券',
    `discount_rate` DECIMAL(10,2) DEFAULT NULL COMMENT '折扣系数',
    `fixed_discount` DECIMAL(10,2) DEFAULT NULL COMMENT '固定减免金额',
    `min_amount` DECIMAL(10,2) DEFAULT NULL COMMENT '最低消费金额',
    `stackable` TINYINT DEFAULT 0 COMMENT '是否可叠加：0-否，1-是',
    `priority` INT DEFAULT 0 COMMENT '优先级',
    `status` INT DEFAULT 0 COMMENT '状态：0-未开始，1-进行中，2-已结束，3-已禁用',
    `start_time` DATETIME DEFAULT NULL COMMENT '开始时间',
    `end_time` DATETIME DEFAULT NULL COMMENT '结束时间',
    `description` TEXT COMMENT '活动描述',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动配置表';

-- 订单表
CREATE TABLE `orders` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单 ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `total_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    `status` TINYINT DEFAULT 0 COMMENT '订单状态：0-待付款，1-待发货，2-待收货，3-已完成，4-已取消',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单项表
CREATE TABLE `order_item` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单项 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `goods_id` BIGINT NOT NULL COMMENT '商品 ID',
    `goods_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `goods_image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片',
    `price` DECIMAL(10,2) NOT NULL COMMENT '单价',
    `quantity` INT NOT NULL COMMENT '数量',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单项表';

-- 发货单表
CREATE TABLE `delivery_order` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '发货单 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `logistics_company` VARCHAR(50) DEFAULT NULL COMMENT '物流公司',
    `logistics_no` VARCHAR(50) DEFAULT NULL COMMENT '物流单号',
    `status` TINYINT DEFAULT 0 COMMENT '发货状态：0-未发货，1-已发货，2-已收货',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发货单表';

-- 物流轨迹表
CREATE TABLE `logistics_track` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '轨迹 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `logistics_no` VARCHAR(50) NOT NULL COMMENT '物流单号',
    `track_content` TEXT COMMENT '轨迹内容',
    `track_status` INT DEFAULT 0 COMMENT '轨迹状态',
    `track_time` DATETIME DEFAULT NULL COMMENT '轨迹时间',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物流轨迹表';

-- 收藏表
CREATE TABLE `favorite` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '收藏 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `goods_id` BIGINT NOT NULL COMMENT '商品 ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_goods` (`user_id`, `goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收藏表';

-- 地址表
CREATE TABLE `address` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '地址 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `name` VARCHAR(50) NOT NULL COMMENT '收货人姓名',
    `phone` VARCHAR(20) NOT NULL COMMENT '收货人电话',
    `province` VARCHAR(50) NOT NULL COMMENT '省份',
    `city` VARCHAR(50) NOT NULL COMMENT '城市',
    `district` VARCHAR(50) NOT NULL COMMENT '区县',
    `detail` VARCHAR(255) NOT NULL COMMENT '详细地址',
    `is_default` TINYINT(1) DEFAULT 0 COMMENT '是否默认地址',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地址表';

-- 退款申请表
CREATE TABLE `refund_request` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '退款申请 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `refund_amount` DECIMAL(10,2) NOT NULL COMMENT '退款金额',
    `reason` TEXT COMMENT '退款原因',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待审核，1-已同意，2-已拒绝，3-已退款',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款申请表';

-- 退款物流表
CREATE TABLE `refund_delivery` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '退款物流 ID',
    `refund_id` BIGINT NOT NULL COMMENT '退款申请 ID',
    `logistics_company` VARCHAR(50) DEFAULT NULL COMMENT '物流公司',
    `logistics_no` VARCHAR(50) DEFAULT NULL COMMENT '物流单号',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款物流表';

-- 聊天会话表
CREATE TABLE `chat_session` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '会话 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `title` VARCHAR(100) DEFAULT NULL COMMENT '会话标题',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天会话表';

-- 聊天消息表
CREATE TABLE `chat_message` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '消息 ID',
    `session_id` BIGINT NOT NULL COMMENT '会话 ID',
    `sender_id` BIGINT NOT NULL COMMENT '发送者 ID',
    `receiver_id` BIGINT NOT NULL COMMENT '接收者 ID',
    `message_type` INT DEFAULT 0 COMMENT '消息类型：0-文本，1-图片，2-文件',
    `content` TEXT COMMENT '消息内容',
    `content_hash` VARCHAR(100) DEFAULT NULL COMMENT '内容哈希',
    `encrypted_key` TEXT COMMENT '加密密钥',
    `signature` VARCHAR(255) DEFAULT NULL COMMENT '签名',
    `public_key_fingerprint` VARCHAR(100) DEFAULT NULL COMMENT '公钥指纹',
    `status` INT DEFAULT 0 COMMENT '状态：0-未读，1-已读',
    `is_read` TINYINT DEFAULT 0 COMMENT '是否已读',
    `read_time` DATETIME DEFAULT NULL COMMENT '读取时间',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天消息表';

-- 多媒体消息表
CREATE TABLE `multimedia_message` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '多媒体消息 ID',
    `message_id` BIGINT NOT NULL COMMENT '消息 ID',
    `file_url` VARCHAR(255) NOT NULL COMMENT '文件 URL',
    `file_type` VARCHAR(20) DEFAULT NULL COMMENT '文件类型',
    `file_size` BIGINT DEFAULT 0 COMMENT '文件大小',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='多媒体消息表';

-- AI 访问令牌表
CREATE TABLE `ai_access_token` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '令牌 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `token` VARCHAR(255) NOT NULL COMMENT '访问令牌',
    `expires_at` DATETIME NOT NULL COMMENT '过期时间',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 访问令牌表';

-- AI 上下文表
CREATE TABLE `ai_context` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '上下文 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `session_id` VARCHAR(50) NOT NULL COMMENT '会话 ID',
    `context_data` TEXT COMMENT '上下文数据 (JSON)',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_session` (`user_id`, `session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 上下文表';

-- AI 对话表
CREATE TABLE `ai_dialogue` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '对话 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `session_id` VARCHAR(50) NOT NULL COMMENT '会话 ID',
    `role` VARCHAR(20) NOT NULL COMMENT '角色：user-assistant',
    `content` TEXT NOT NULL COMMENT '对话内容',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 对话表';

-- AI 访问日志表
CREATE TABLE `ai_access_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '日志 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `request_data` TEXT COMMENT '请求数据',
    `response_data` TEXT COMMENT '响应数据',
    `status` INT DEFAULT 0 COMMENT '状态码',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 访问日志表';

-- AI 表单表
CREATE TABLE `ai_form` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '表单 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `form_type` VARCHAR(50) NOT NULL COMMENT '表单类型',
    `form_data` TEXT COMMENT '表单数据 (JSON)',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 表单表';

-- 用户密钥表
CREATE TABLE `user_key` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '密钥 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `public_key` TEXT NOT NULL COMMENT '公钥',
    `private_key` TEXT NOT NULL COMMENT '私钥 (加密存储)',
    `fingerprint` VARCHAR(100) NOT NULL COMMENT '密钥指纹',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户密钥表';

-- 用户浏览历史表
CREATE TABLE `user_browse_history` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '历史 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `goods_id` BIGINT NOT NULL COMMENT '商品 ID',
    `browse_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户浏览历史表';

-- 插入测试数据
-- 管理员用户
INSERT INTO `user` (`username`, `password`, `nickname`, `role`, `status`) VALUES 
('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 'ADMIN', 1),
('merchant1', 'e10adc3949ba59abbe56e057f20f883e', '商家 1', 'MERCHANT', 1),
('user1', 'e10adc3949ba59abbe56e057f20f883e', '测试用户', 'USER', 1);

-- 测试商品
INSERT INTO `goods` (`name`, `description`, `price`, `original_price`, `stock`, `sales`, `category`, `status`) VALUES
('绿豆糕', '传统手工绿豆糕，口感细腻', 29.90, 39.90, 1000, 0, '食品', 1),
('红豆糕', '精选红豆制作，香甜可口', 25.90, 35.90, 800, 0, '食品', 1),
('桂花糕', '桂花香气浓郁，软糯香甜', 32.90, 42.90, 600, 0, '食品', 1);

-- 测试活动
INSERT INTO `activity_config` (`name`, `type`, `discount_rate`, `min_amount`, `stackable`, `priority`, `status`, `start_time`, `end_time`, `description`) VALUES
('新年大促', 2, 0.9, 100.00, 0, 1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), '全场 9 折优惠'),
('满减活动', 1, NULL, 200.00, 1, 2, 1, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY), '满 200 减 30');

-- 初始化库存
INSERT INTO `inventory` (`goods_id`, `stock`, `locked_stock`, `available_stock`) VALUES
(1, 1000, 0, 1000),
(2, 800, 0, 800),
(3, 600, 0, 600);


-- �ָ�������
SET FOREIGN_KEY_CHECKS = 1;

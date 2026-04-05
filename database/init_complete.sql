-- =====================================================
-- 绿豆糕商城 - 完整数据库初始化脚本
-- 版本：v2.0.0
-- 日期：2026-04-05
-- 说明：包含所有业务模块的表结构初始化
-- =====================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mung_bean_cake_mall;

-- =====================================================
-- 第一部分：基础表结构
-- =====================================================

-- 1. 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户 ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(100) NOT NULL COMMENT '密码',
    `nickname` VARCHAR(50) DEFAULT NULL COMMENT '昵称',
    `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像 URL',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
    `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    `gender` TINYINT DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
    `birthday` DATE DEFAULT NULL COMMENT '生日',
    `header_background` VARCHAR(255) DEFAULT NULL COMMENT '头部背景图',
    `role` TINYINT DEFAULT 1 COMMENT '角色：1-普通用户，2-商家，3-管理员',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-正常',
    `last_login_time` DATETIME DEFAULT NULL COMMENT '最后登录时间',
    `last_login_ip` VARCHAR(50) DEFAULT NULL COMMENT '最后登录 IP',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_phone` (`phone`),
    UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 2. 商品表
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品 ID',
    `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `description` TEXT COMMENT '商品描述',
    `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
    `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '原价',
    `image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片 URL',
    `images` TEXT COMMENT '商品图片列表 (JSON)',
    `sales` INT DEFAULT 0 COMMENT '销量',
    `stock` INT DEFAULT 0 COMMENT '库存',
    `category` VARCHAR(50) DEFAULT NULL COMMENT '分类',
    `brand` VARCHAR(50) DEFAULT NULL COMMENT '品牌',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-下架，1-上架',
    `merchant_id` BIGINT DEFAULT NULL COMMENT '商家 ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX idx_category (`category`),
    INDEX idx_merchant (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 3. 商品规格表
DROP TABLE IF EXISTS `product_spec`;
CREATE TABLE `product_spec` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '规格 ID',
    `product_id` BIGINT NOT NULL COMMENT '商品 ID',
    `spec_name` VARCHAR(50) NOT NULL COMMENT '规格名称',
    `spec_value` VARCHAR(100) NOT NULL COMMENT '规格值',
    `price` DECIMAL(10,2) DEFAULT NULL COMMENT '规格价格',
    `stock` INT DEFAULT 0 COMMENT '规格库存',
    `image` VARCHAR(255) DEFAULT NULL COMMENT '规格图片',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    INDEX idx_product (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品规格表';

-- 4. 收藏表
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '收藏 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `product_id` BIGINT NOT NULL COMMENT '商品 ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_product` (`user_id`, `product_id`),
    INDEX idx_user (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收藏表';

-- 5. 地址表
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '地址 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `name` VARCHAR(50) NOT NULL COMMENT '收货人姓名',
    `phone` VARCHAR(20) NOT NULL COMMENT '收货人电话',
    `province` VARCHAR(50) NOT NULL COMMENT '省份',
    `city` VARCHAR(50) NOT NULL COMMENT '城市',
    `district` VARCHAR(50) NOT NULL COMMENT '区县',
    `detail` VARCHAR(255) NOT NULL COMMENT '详细地址',
    `is_default` TINYINT(1) DEFAULT 0 COMMENT '是否默认地址 0 否 1 是',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX idx_user (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地址表';

-- 6. 订单表
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单 ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `address_id` BIGINT NOT NULL COMMENT '地址 ID',
    `total_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    `pay_amount` DECIMAL(10,2) DEFAULT NULL COMMENT '实付金额',
    `freight_amount` DECIMAL(10,2) DEFAULT 0 COMMENT '运费金额',
    `status` TINYINT DEFAULT 0 COMMENT '订单状态：0-待付款，1-待发货，2-待收货，3-已完成，4-已取消',
    `payment_type` TINYINT DEFAULT 1 COMMENT '支付方式：1-微信，2-支付宝',
    `payment_time` DATETIME DEFAULT NULL COMMENT '支付时间',
    `delivery_time` DATETIME DEFAULT NULL COMMENT '发货时间',
    `receive_time` DATETIME DEFAULT NULL COMMENT '收货时间',
    `remark` VARCHAR(500) DEFAULT NULL COMMENT '订单备注',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    INDEX idx_user (`user_id`),
    INDEX idx_status (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 7. 订单项表
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单项 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `product_id` BIGINT NOT NULL COMMENT '商品 ID',
    `product_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `product_image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片',
    `price` DECIMAL(10,2) NOT NULL COMMENT '单价',
    `quantity` INT NOT NULL COMMENT '数量',
    `spec_info` VARCHAR(200) DEFAULT NULL COMMENT '规格信息',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    INDEX idx_order (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单项表';

-- 8. 轮播图表
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '轮播图 ID',
    `title` VARCHAR(100) DEFAULT NULL COMMENT '标题',
    `image` VARCHAR(255) NOT NULL COMMENT '图片 URL',
    `link` VARCHAR(255) DEFAULT NULL COMMENT '链接地址',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX idx_sort (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='轮播图表';

-- 9. 图片文件表
DROP TABLE IF EXISTS `image_file`;
CREATE TABLE `image_file` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '文件 ID',
    `file_name` VARCHAR(100) NOT NULL COMMENT '文件名',
    `file_path` VARCHAR(255) NOT NULL COMMENT '文件路径',
    `file_url` VARCHAR(255) NOT NULL COMMENT '文件 URL',
    `file_size` BIGINT DEFAULT 0 COMMENT '文件大小 (字节)',
    `file_type` VARCHAR(50) DEFAULT NULL COMMENT '文件类型',
    `upload_user` BIGINT DEFAULT NULL COMMENT '上传用户',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    INDEX idx_upload_user (`upload_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图片文件表';

-- =====================================================
-- 第二部分：聊天系统表结构
-- =====================================================

-- 10. 聊天会话表
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `session_id` VARCHAR(64) UNIQUE NOT NULL COMMENT '会话 ID',
    `session_type` TINYINT NOT NULL COMMENT '会话类型：1-私信，2-客服，3-群聊，4-AI',
    `session_name` VARCHAR(100) COMMENT '会话名称',
    `session_avatar` VARCHAR(255) COMMENT '会话头像',
    
    -- 成员信息
    `member1_id` BIGINT COMMENT '成员 1 用户 ID（私信）',
    `member2_id` BIGINT COMMENT '成员 2 用户 ID（私信）',
    `group_id` BIGINT COMMENT '群 ID（群聊）',
    `ai_id` BIGINT COMMENT 'AI ID（AI 会话）',
    
    -- 状态
    `is_deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    `is_top` TINYINT DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
    `is_disturb` TINYINT DEFAULT 0 COMMENT '是否免打扰：0-否，1-是',
    
    -- 最后消息
    `last_message_id` BIGINT COMMENT '最后一条消息 ID',
    `last_message_content` VARCHAR(500) COMMENT '最后一条消息内容',
    `last_message_time` DATETIME COMMENT '最后一条消息时间',
    `unread_count` INT DEFAULT 0 COMMENT '未读消息数',
    
    -- 元数据
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_member1 (member1_id),
    INDEX idx_member2 (member2_id),
    INDEX idx_group (group_id),
    INDEX idx_last_message_time (last_message_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天会话表';

-- 11. 会话成员表
DROP TABLE IF EXISTS `chat_session_member`;
CREATE TABLE `chat_session_member` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `session_id` VARCHAR(64) NOT NULL COMMENT '会话 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `role` TINYINT DEFAULT 1 COMMENT '角色：1-普通成员，2-管理员，3-群主',
    `session_key` TEXT COMMENT '会话密钥（加密后的群组密钥）',
    `join_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
    `quit_time` DATETIME COMMENT '退出时间',
    `is_deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    
    UNIQUE KEY uk_session_user (session_id, user_id),
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会话成员表';

-- 12. 消息表
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `message_id` VARCHAR(64) UNIQUE NOT NULL COMMENT '消息 ID',
    `session_id` VARCHAR(64) NOT NULL COMMENT '会话 ID',
    `sender_id` BIGINT NOT NULL COMMENT '发送者 ID',
    `receiver_id` BIGINT COMMENT '接收者 ID（私信）',
    
    -- 消息内容（加密存储）
    `message_type` TINYINT NOT NULL COMMENT '消息类型：1-文字，2-图片，3-语音，4-视频，5-表情，6-电商卡片',
    `content` TEXT NOT NULL COMMENT '加密后的消息内容',
    `content_hash` VARCHAR(64) COMMENT '消息内容哈希（完整性校验）',
    
    -- 加密相关
    `encrypted_key` TEXT COMMENT '加密的会话密钥（接收方公钥加密）',
    `signature` TEXT COMMENT '数字签名（发送方私钥签名）',
    `public_key_fingerprint` VARCHAR(64) COMMENT '公钥指纹（验证用）',
    
    -- 状态
    `status` TINYINT DEFAULT 1 COMMENT '状态：1-正常，2-撤回，3-删除',
    `is_read` TINYINT DEFAULT 0 COMMENT '是否已读：0-否，1-是',
    `read_time` DATETIME COMMENT '已读时间',
    
    -- 元数据
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_session (session_id),
    INDEX idx_sender (sender_id),
    INDEX idx_receiver (receiver_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- 13. 群聊表
DROP TABLE IF EXISTS `chat_group`;
CREATE TABLE `chat_group` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `group_id` VARCHAR(64) UNIQUE NOT NULL COMMENT '群 ID',
    `group_name` VARCHAR(100) NOT NULL COMMENT '群名称',
    `group_avatar` VARCHAR(255) COMMENT '群头像',
    `creator_id` BIGINT NOT NULL COMMENT '创建者 ID',
    `member_count` INT DEFAULT 1 COMMENT '成员数量',
    `max_member_count` INT DEFAULT 500 COMMENT '最大成员数',
    `notice` TEXT COMMENT '群公告',
    `is_deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_creator (creator_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群聊表';

-- 14. 好友表
DROP TABLE IF EXISTS `user_friend`;
CREATE TABLE `user_friend` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `friend_id` BIGINT NOT NULL COMMENT '好友 ID',
    `friend_remark` VARCHAR(50) COMMENT '好友备注',
    `friend_group` VARCHAR(50) COMMENT '好友分组',
    `is_blocked` TINYINT DEFAULT 0 COMMENT '是否拉黑：0-否，1-是',
    `is_deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
    
    UNIQUE KEY uk_user_friend (user_id, friend_id),
    INDEX idx_friend (friend_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友表';

-- 15. 好友请求表
DROP TABLE IF EXISTS `friend_request`;
CREATE TABLE `friend_request` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `sender_id` BIGINT NOT NULL COMMENT '发送者 ID',
    `receiver_id` BIGINT NOT NULL COMMENT '接收者 ID',
    `request_message` VARCHAR(200) COMMENT '请求消息',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待处理，1-已接受，2-已拒绝',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '请求时间',
    `handled_at` DATETIME COMMENT '处理时间',
    
    INDEX idx_sender (sender_id),
    INDEX idx_receiver (receiver_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友请求表';

-- 16. 服务评价表
DROP TABLE IF EXISTS `service_rating`;
CREATE TABLE `service_rating` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `session_id` VARCHAR(64) NOT NULL COMMENT '会话 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `service_id` BIGINT NOT NULL COMMENT '客服 ID',
    `rating` TINYINT NOT NULL COMMENT '评分：1-5 星',
    `comment` TEXT COMMENT '评价内容',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
    
    INDEX idx_session (session_id),
    INDEX idx_service (service_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务评价表';

-- 17. AI 上下文表
DROP TABLE IF EXISTS `ai_context`;
CREATE TABLE `ai_context` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `session_id` VARCHAR(64) NOT NULL COMMENT 'AI 会话 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `context_key` VARCHAR(100) COMMENT '上下文键',
    `context_value` TEXT COMMENT '上下文值（加密存储）',
    `expire_time` DATETIME COMMENT '过期时间',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    UNIQUE KEY uk_session_key (session_id, context_key),
    INDEX idx_user (user_id),
    INDEX idx_expire (expire_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 上下文表';

-- 18. AI 表单表
DROP TABLE IF EXISTS `ai_form`;
CREATE TABLE `ai_form` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `form_type` VARCHAR(50) NOT NULL COMMENT '表单类型',
    `form_data` TEXT NOT NULL COMMENT '表单数据 (JSON)',
    `result` TEXT COMMENT 'AI 处理结果',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待处理，1-处理中，2-已完成',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_user (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 表单表';

-- 19. AI 访问日志表
DROP TABLE IF EXISTS `ai_access_log`;
CREATE TABLE `ai_access_log` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `session_id` VARCHAR(64) NOT NULL COMMENT '会话 ID',
    `request_data` TEXT COMMENT '请求数据',
    `response_data` TEXT COMMENT '响应数据',
    `duration` INT DEFAULT 0 COMMENT '耗时 (毫秒)',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-失败，1-成功',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    INDEX idx_user (user_id),
    INDEX idx_session (session_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 访问日志表';

-- 20. 用户密钥表
DROP TABLE IF EXISTS `user_key`;
CREATE TABLE `user_key` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT UNIQUE NOT NULL COMMENT '用户 ID',
    `public_key` TEXT NOT NULL COMMENT '公钥',
    `private_key` TEXT NOT NULL COMMENT '私钥（加密存储）',
    `key_version` INT DEFAULT 1 COMMENT '密钥版本',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户密钥表';

-- 21. 用户浏览历史表
DROP TABLE IF EXISTS `user_browse_history`;
CREATE TABLE `user_browse_history` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `product_id` BIGINT NOT NULL COMMENT '商品 ID',
    `browse_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
    
    UNIQUE KEY uk_user_product (user_id, product_id),
    INDEX idx_user (user_id),
    INDEX idx_browse_time (browse_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户浏览历史表';

-- =====================================================
-- 第三部分：物流系统表结构
-- =====================================================

-- 22. 物流轨迹表
DROP TABLE IF EXISTS `logistics_track`;
CREATE TABLE `logistics_track` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `logistics_no` VARCHAR(100) NOT NULL COMMENT '物流单号',
    `logistics_company` VARCHAR(100) COMMENT '物流公司名称',
    `logistics_company_code` VARCHAR(50) COMMENT '物流公司编码',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待发货，1-运输中，2-已签收，3-异常',
    `origin_address` VARCHAR(255) COMMENT '发货地址',
    `destination_address` VARCHAR(255) COMMENT '收货地址',
    `sender_name` VARCHAR(100) COMMENT '寄件人姓名',
    `sender_phone` VARCHAR(20) COMMENT '寄件人电话',
    `receiver_name` VARCHAR(100) COMMENT '收件人姓名',
    `receiver_phone` VARCHAR(20) COMMENT '收件人电话',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    UNIQUE KEY uk_order_no (order_no),
    INDEX idx_logistics_no (logistics_no),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物流轨迹表';

-- 23. 轨迹信息表
DROP TABLE IF EXISTS `track_info`;
CREATE TABLE `track_info` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `track_id` BIGINT NOT NULL COMMENT '物流轨迹 ID',
    `logistics_no` VARCHAR(100) NOT NULL COMMENT '物流单号',
    `track_time` DATETIME NOT NULL COMMENT '轨迹时间',
    `track_content` TEXT NOT NULL COMMENT '轨迹内容',
    `track_location` VARCHAR(255) COMMENT '轨迹地点',
    `track_status` VARCHAR(50) COMMENT '轨迹状态',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    INDEX idx_track (track_id),
    INDEX idx_logistics_no (logistics_no),
    INDEX idx_track_time (track_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='轨迹信息表';

-- 24. 轨迹统计表
DROP TABLE IF EXISTS `track_statistics`;
CREATE TABLE `track_statistics` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `logistics_no` VARCHAR(100) UNIQUE NOT NULL COMMENT '物流单号',
    `total_distance` INT DEFAULT 0 COMMENT '总距离 (公里)',
    `total_duration` INT DEFAULT 0 COMMENT '总时长 (小时)',
    `transit_count` INT DEFAULT 0 COMMENT '中转次数',
    `current_location` VARCHAR(255) COMMENT '当前位置',
    `estimated_delivery_time` DATETIME COMMENT '预计送达时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_logistics_no (logistics_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='轨迹统计表';

-- 25. 配送订单表
DROP TABLE IF EXISTS `delivery_order`;
CREATE TABLE `delivery_order` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `logistics_no` VARCHAR(100) COMMENT '物流单号',
    `delivery_type` TINYINT DEFAULT 1 COMMENT '配送方式：1-快递，2-外卖，3-自提',
    `delivery_status` TINYINT DEFAULT 0 COMMENT '配送状态：0-待配送，1-配送中，2-已送达',
    `deliveryman_id` BIGINT COMMENT '配送员 ID',
    `deliveryman_name` VARCHAR(50) COMMENT '配送员姓名',
    `deliveryman_phone` VARCHAR(20) COMMENT '配送员电话',
    `delivery_time` DATETIME COMMENT '配送时间',
    `remark` VARCHAR(500) COMMENT '备注',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    UNIQUE KEY uk_order_no (order_no),
    INDEX idx_deliveryman (deliveryman_id),
    INDEX idx_status (delivery_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='配送订单表';

-- =====================================================
-- 第四部分：营销活动表结构
-- =====================================================

-- 26. 活动配置表
DROP TABLE IF EXISTS `activity_config`;
CREATE TABLE `activity_config` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `activity_name` VARCHAR(100) NOT NULL COMMENT '活动名称',
    `activity_type` TINYINT NOT NULL COMMENT '活动类型：1-秒杀，2-拼团，3-满减，4-折扣',
    `activity_desc` TEXT COMMENT '活动描述',
    `start_time` DATETIME NOT NULL COMMENT '开始时间',
    `end_time` DATETIME NOT NULL COMMENT '结束时间',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-未开始，1-进行中，2-已结束',
    `config_data` TEXT COMMENT '活动配置数据 (JSON)',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_type (activity_type),
    INDEX idx_status (status),
    INDEX idx_time (start_time, end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动配置表';

-- =====================================================
-- 第五部分：商家系统表结构
-- =====================================================

-- 27. 商家认证表
DROP TABLE IF EXISTS `merchant_auth`;
CREATE TABLE `merchant_auth` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `user_id` BIGINT UNIQUE NOT NULL COMMENT '用户 ID',
    `merchant_name` VARCHAR(100) NOT NULL COMMENT '商家名称',
    `merchant_type` TINYINT DEFAULT 1 COMMENT '商家类型：1-个人，2-企业',
    `license_no` VARCHAR(100) COMMENT '营业执照号',
    `license_image` VARCHAR(255) COMMENT '营业执照图片，
    `contact_name` VARCHAR(50) COMMENT '联系人姓名',
    `contact_phone` VARCHAR(20) COMMENT '联系人电话',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待审核，1-已通过，2-已拒绝',
    `reject_reason` VARCHAR(500) COMMENT '拒绝原因',
    `approved_at` DATETIME COMMENT '审核通过时间',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商家认证表';

-- =====================================================
-- 第六部分：退款售后表结构
-- =====================================================

-- 28. 退款申请表
DROP TABLE IF EXISTS `refund_request`;
CREATE TABLE `refund_request` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `refund_type` TINYINT DEFAULT 1 COMMENT '退款类型：1-仅退款，2-退货退款',
    `refund_reason` VARCHAR(500) NOT NULL COMMENT '退款原因',
    `refund_amount` DECIMAL(10,2) NOT NULL COMMENT '退款金额',
    `refund_images` TEXT COMMENT '退款凭证图片 (JSON)',
    `status` TINYINT DEFAULT 0 COMMENT '状态：0-待审核，1-已同意，2-已拒绝，3-已完成',
    `remark` VARCHAR(500) COMMENT '备注',
    `handle_remark` VARCHAR(500) COMMENT '处理备注',
    `handler_id` BIGINT COMMENT '处理人 ID',
    `handled_at` DATETIME COMMENT '处理时间',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_order_no (order_no),
    INDEX idx_user (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款申请表';

-- =====================================================
-- 第七部分：初始化测试数据
-- =====================================================

-- 插入测试用户（密码统一为：123456，已加密存储为******）
INSERT INTO `user` (`username`, `password`, `nickname`, `role`, `status`) VALUES
('admin', '******', '管理员', 3, 1),  # 密码哈希已隐藏
('user1', '******', '用户 1', 1, 1),  # 密码哈希已隐藏
('user2', '******', '用户 2', 1, 1),  # 密码哈希已隐藏
('user3', '******', '用户 3', 1, 1),  # 密码哈希已隐藏
('merchant1', '******', '商家 1', 2, 1);  # 密码哈希已隐藏

-- 插入测试商品
INSERT INTO `product` (`name`, `description`, `price`, `original_price`, `image`, `sales`, `stock`, `category`, `status`) VALUES
('绿豆糕经典原味', '传统手工制作，口感细腻，甜而不腻', 29.90, 39.90, '/images/product/lvdougao1.jpg', 1000, 500, '糕点', 1),
('绿豆糕抹茶味', '精选日本抹茶，清香浓郁', 32.90, 42.90, '/images/product/lvdougao2.jpg', 800, 300, '糕点', 1),
('绿豆糕礼盒装', '精美礼盒包装，送礼佳品', 68.00, 88.00, '/images/product/lvdougao3.jpg', 500, 200, '礼盒', 1);

-- 插入测试轮播图
INSERT INTO `banner` (`title`, `image`, `link`, `sort_order`, `status`) VALUES
('绿豆糕新品上市', '/images/banner/banner1.jpg', '/product/1', 1, 1),
('限时特惠活动', '/images/banner/banner2.jpg', '/activity/1', 2, 1),
('精美礼盒推荐', '/images/banner/banner3.jpg', '/product/3', 3, 1);

-- =====================================================
-- 第八部分：索引优化和性能调优
-- =====================================================

-- 添加复合索引优化查询性能
CREATE INDEX idx_order_user_status ON orders(user_id, status);
CREATE INDEX idx_order_created ON orders(create_time DESC);
CREATE INDEX idx_message_session_created ON chat_message(session_id, created_at DESC);
CREATE INDEX idx_friend_user ON user_friend(user_id, is_deleted);

-- =====================================================
-- 完成提示
-- =====================================================

SELECT '数据库初始化完成！' AS message;
SELECT COUNT(*) AS user_count FROM user;
SELECT COUNT(*) AS product_count FROM product;
SELECT COUNT(*) AS chat_session_count FROM chat_session;
SELECT COUNT(*) AS message_count FROM chat_message;

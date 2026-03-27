CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mung_bean_cake_mall;

DROP TABLE IF EXISTS `ai_form`;
DROP TABLE IF EXISTS `chat_message`;
DROP TABLE IF EXISTS `order_item`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `address`;
DROP TABLE IF EXISTS `favorite`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(100) NOT NULL COMMENT '密码',
    `nickname` VARCHAR(50) DEFAULT NULL COMMENT '昵称',
    `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像URL',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

CREATE TABLE `product` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品ID',
    `name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `description` TEXT COMMENT '商品描述',
    `price` DECIMAL(10,2) NOT NULL COMMENT '价格',
    `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '原价',
    `image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片URL',
    `images` TEXT COMMENT '商品图片列表(JSON)',
    `sales` INT DEFAULT 0 COMMENT '销量',
    `stock` INT DEFAULT 0 COMMENT '库存',
    `category` VARCHAR(50) DEFAULT NULL COMMENT '分类',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

CREATE TABLE `favorite` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `product_id` BIGINT NOT NULL COMMENT '商品ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_product` (`user_id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收藏表';

CREATE TABLE `address` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '地址ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `name` VARCHAR(50) NOT NULL COMMENT '收货人姓名',
    `phone` VARCHAR(20) NOT NULL COMMENT '收货人电话',
    `province` VARCHAR(50) NOT NULL COMMENT '省份',
    `city` VARCHAR(50) NOT NULL COMMENT '城市',
    `district` VARCHAR(50) NOT NULL COMMENT '区县',
    `detail` VARCHAR(255) NOT NULL COMMENT '详细地址',
    `is_default` TINYINT(1) DEFAULT 0 COMMENT '是否默认地址 0否 1是',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地址表';

CREATE TABLE `orders` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `address_id` BIGINT NOT NULL COMMENT '地址ID',
    `total_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    `status` TINYINT DEFAULT 0 COMMENT '订单状态 0待付款 1待发货 2待收货 3已完成 4已取消',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

CREATE TABLE `order_item` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '订单项ID',
    `order_id` BIGINT NOT NULL COMMENT '订单ID',
    `product_id` BIGINT NOT NULL COMMENT '商品ID',
    `product_name` VARCHAR(100) NOT NULL COMMENT '商品名称',
    `product_image` VARCHAR(255) DEFAULT NULL COMMENT '商品图片',
    `price` DECIMAL(10,2) NOT NULL COMMENT '单价',
    `quantity` INT NOT NULL COMMENT '数量',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单项表';

CREATE TABLE `chat_message` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '消息ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `from_type` TINYINT NOT NULL COMMENT '发送方 0用户 1客服',
    `content` TEXT NOT NULL COMMENT '消息内容',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天消息表';

CREATE TABLE `ai_form` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '表单ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `flavor` VARCHAR(50) DEFAULT NULL COMMENT '口味',
    `sweetness` VARCHAR(50) DEFAULT NULL COMMENT '甜度',
    `packaging` VARCHAR(50) DEFAULT NULL COMMENT '包装',
    `quantity` INT DEFAULT NULL COMMENT '数量',
    `special_request` TEXT COMMENT '特殊要求',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI定制表单表';

INSERT INTO `user` (`username`, `password`, `nickname`, `avatar`, `phone`) VALUES
('admin', '123456', '管理员', 'https://api.dicebear.com/7.x/avataaars/svg?seed=admin', '13800138000'),
('user1', '123456', '张三', 'https://api.dicebear.com/7.x/avataaars/svg?seed=user1', '13800138001');

INSERT INTO `product` (`name`, `description`, `price`, `original_price`, `image`, `sales`, `stock`, `category`) VALUES
('传统手工绿豆糕', '精选优质绿豆，传统工艺制作，入口即化', 19.90, 39.90, 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=traditional%20Chinese%20mung%20bean%20cake%20food%20photography&image_size=square', 1256, 500, '传统糕点'),
('抹茶味绿豆糕', '清新抹茶与绿豆的完美结合', 25.90, 49.90, 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=matcha%20mung%20bean%20cake%20green%20tea%20dessert&image_size=square', 892, 300, '抹茶系列'),
('桂花绿豆糕', '金秋桂花飘香，香甜可口', 22.90, 45.90, 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=osmanthus%20mung%20bean%20cake%20sweet%20dessert&image_size=square', 567, 200, '花香系列'),
('无糖绿豆糕', '健康无糖，适合老人和血糖控制人群', 28.90, 55.90, 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=sugar%20free%20mung%20bean%20cake%20healthy%20dessert&image_size=square', 432, 150, '健康系列'),
('紫薯绿豆糕', '紫薯与绿豆的双重美味', 23.90, 46.90, 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=purple%20sweet%20potato%20mung%20bean%20cake%20dessert&image_size=square', 678, 250, '紫薯系列'),
('椰丝绿豆糕', '椰香浓郁，口感独特', 26.90, 52.90, 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=coconut%20mung%20bean%20cake%20tropical%20dessert&image_size=square', 345, 180, '椰香系列');

INSERT INTO `address` (`user_id`, `name`, `phone`, `province`, `city`, `district`, `detail`, `is_default`) VALUES
(1, '张三', '13800138001', '广东省', '深圳市', '南山区', '科技园南区A栋1001室', 1),
(2, '李四', '13800138002', '北京市', '北京市', '朝阳区', '建国路88号SOHO现代城B座2002', 1);

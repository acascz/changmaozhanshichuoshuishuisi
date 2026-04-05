-- 退款申请表
CREATE TABLE IF NOT EXISTS `refund_request` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '退款申请 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `user_id` BIGINT NOT NULL COMMENT '用户 ID',
    `refund_amount` DECIMAL(10,2) NOT NULL COMMENT '退款金额',
    `refund_type` INT NOT NULL COMMENT '退款类型：1-仅退款，2-退货退款',
    `reason` INT NOT NULL COMMENT '退款原因',
    `description` TEXT COMMENT '退款说明',
    `images` TEXT COMMENT '凭证图片，JSON 数组',
    `status` INT NOT NULL DEFAULT 0 COMMENT '状态：0-待审核，1-已同意，2-已拒绝，3-已完成',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX `idx_order_id` (`order_id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款申请表';

-- 发货单表
CREATE TABLE IF NOT EXISTS `delivery_order` (
    `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '发货单 ID',
    `order_id` BIGINT NOT NULL COMMENT '订单 ID',
    `delivery_no` VARCHAR(50) NOT NULL COMMENT '发货单号',
    `logistics_company` VARCHAR(100) COMMENT '物流公司',
    `logistics_no` VARCHAR(100) COMMENT '物流单号',
    `receiver_name` VARCHAR(100) NOT NULL COMMENT '收货人',
    `receiver_phone` VARCHAR(20) NOT NULL COMMENT '收货人电话',
    `receiver_address` VARCHAR(500) NOT NULL COMMENT '收货地址',
    `status` INT NOT NULL DEFAULT 0 COMMENT '状态：0-待发货，1-已发货，2-已签收',
    `delivery_time` DATETIME COMMENT '发货时间',
    `sign_time` DATETIME COMMENT '签收时间',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX `idx_order_id` (`order_id`),
    INDEX `idx_delivery_no` (`delivery_no`),
    INDEX `idx_logistics_no` (`logistics_no`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发货单表';

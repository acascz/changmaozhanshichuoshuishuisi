-- 创建轮播图表
CREATE TABLE IF NOT EXISTS banner (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(500) NOT NULL COMMENT '图片URL',
    title VARCHAR(200) COMMENT '标题',
    link_url VARCHAR(500) COMMENT '跳转链接',
    sort_order INT DEFAULT 0 COMMENT '排序序号',
    status TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='轮播图表';

-- 插入测试数据
INSERT INTO banner (image_url, title, link_url, sort_order, status) VALUES
('/images/banner/banner1.jpg', '手工绿豆糕 · 新鲜现做', '/home', 1, 1),
('/images/banner/banner2.jpg', '抹茶绿豆糕 · 清新茶香', '/search?key=抹茶', 2, 1),
('/images/banner/banner3.jpg', '桂花绿豆糕 · 节日送礼', '/search?key=桂花', 3, 1);
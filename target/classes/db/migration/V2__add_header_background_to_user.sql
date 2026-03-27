-- 添加用户表头背景图片字段
ALTER TABLE user ADD COLUMN header_background VARCHAR(500) DEFAULT NULL COMMENT '个人中心头部背景图片 URL';

-- 更新现有用户的默认背景（可选）
-- UPDATE user SET header_background = '/images/mine/default-header-bg.jpg' WHERE header_background IS NULL;

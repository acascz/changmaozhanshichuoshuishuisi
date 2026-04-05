-- 用户数据恢复脚本
-- 根据 uploads 文件夹中的图片文件恢复
-- 生成时间：2026-04-04
--
-- 说明：
-- 1. 由于无法确定头像 (user_avatar) 和主页背景 (user_header) 的对应关系
-- 2. 本脚本仅提供基础用户数据，头像随机分配
-- 3. 所有用户密码都是 123456（MD5: e10adc3949ba59abbe56e057f20f883e）
-- 4. 您可以根据实际情况手动调整头像分配

USE mung_bean_cake_mall;

-- 清除现有的测试用户（保留表结构）
DELETE FROM `user` WHERE `username` IN ('admin', 'merchant1', 'user1', 'user2', 'user3');

-- 恢复用户数据
-- 注意：头像从 uploads 文件夹中随机分配，实际使用时请根据实际情况调整
INSERT INTO `user` (`username`, `password`, `nickname`, `avatar`, `header_background`, `phone`, `email`, `role`, `status`) VALUES
-- 管理员用户（使用 admin 头像）
('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '/uploads/user_avatar/016a09c6-4aea-4a9d-b550-cce1e5fe3a90.png', '/uploads/user_header/723d6564-8ad6-47ec-b428-41a4cafe8a33.png', '13800138000', 'admin@example.com', 'ADMIN', 1),

-- 商家用户（使用 merchant 相关头像）
('merchant1', 'e10adc3949ba59abbe56e057f20f883e', '商家 1', '/uploads/user_avatar/3ba5e85a-7a3a-4f4c-b152-a8fa541da7ca.png', NULL, '13800138001', 'merchant1@example.com', 'MERCHANT', 1),

-- 普通用户（分配不同的头像）
('user1', 'e10adc3949ba59abbe56e057f20f883e', '测试用户', '/uploads/user_avatar/4b89bfe3-9323-4f34-8287-5868a6b2433c.png', NULL, '13800138002', 'user1@example.com', 'USER', 1),
('user2', 'e10adc3949ba59abbe56e057f20f883e', '用户 2', '/uploads/user_avatar/84dcf5a5-46e5-443b-a03e-fc53539a03be.png', NULL, '13800138003', 'user2@example.com', 'USER', 1),
('user3', 'e10adc3949ba59abbe56e057f20f883e', '用户 3', '/uploads/user_avatar/882c3ebe-8322-474c-87e0-85e1f7867195.png', NULL, '13800138004', 'user3@example.com', 'USER', 1);

-- 如果需要创建更多用户，可以使用以下模板：
-- ('userX', 'e10adc3949ba59abbe56e057f20f883e', '用户 X', '/uploads/user_avatar/[选择一个 UUID].png', NULL, '1380013800X', 'userX@example.com', 'USER', 1);

-- 可用的头像文件列表（共 17 个）：
-- /uploads/user_avatar/016a09c6-4aea-4a9d-b550-cce1e5fe3a90.png
-- /uploads/user_avatar/3ba5e85a-7a3a-4f4c-b152-a8fa541da7ca.png
-- /uploads/user_avatar/4b89bfe3-9323-4f34-8287-5868a6b2433c.png
-- /uploads/user_avatar/84dcf5a5-46e5-443b-a03e-fc53539a03be.png
-- /uploads/user_avatar/882c3ebe-8322-474c-87e0-85e1f7867195.png
-- /uploads/user_avatar/8d5aca81-e695-49c7-82cd-550772e7dfe4.png
-- /uploads/user_avatar/9320bec9-15d2-4a0f-8b90-89fc793e208a.png
-- /uploads/user_avatar/a739ac70-ff1e-47f4-98c7-09f65d6e2df2.png
-- /uploads/user_avatar/b9c65964-0e33-4470-b68f-8607adeac964.png
-- /uploads/user_avatar/ccd46faf-3ce5-47d2-8720-34dbf1c74662.png
-- /uploads/user_avatar/dbb43d25-6134-41e2-a0fb-6d83c835b2eb.png
-- /uploads/user_avatar/e206ff53-26ce-4a47-b8e8-4349bc8d91c8.png
-- /uploads/user_avatar/e4186f6b-e8a6-425c-baa2-1df7bb1e0f98.png
-- /uploads/user_avatar/e4c07e80-d332-4ea5-a2fc-e6f19b92390c.png
-- /uploads/user_avatar/ec1d6eac-285e-4b37-8370-cfc3411a72a0.png
-- /uploads/user_avatar/f3430b9b-5507-4b8a-952b-8dc7ffda7c9f.png
-- /uploads/user_avatar/ffc31722-98b9-498e-b8a2-0b39b21ee4ff.png

-- 可用的主页背景文件列表（共 3 个）：
-- /uploads/user_header/723d6564-8ad6-47ec-b428-41a4cafe8a33.png
-- /uploads/user_header/7b84ce73-7842-4000-976b-d146dbb7197e.png
-- /uploads/user_header/d4471bd7-10a9-4e6e-aee8-2352acd536e8.png

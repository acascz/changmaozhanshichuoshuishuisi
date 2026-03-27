# 个人中心图片管理说明

## 功能概述

个人中心现在支持通过数据库存储和加载以下图片：
1. **用户头像** (avatar)
2. **头部背景图** (header_background)

## 数据库配置

### 1. 执行数据库迁移

在 MySQL 数据库中执行以下 SQL 语句：

```sql
-- 添加用户表头背景图片字段
ALTER TABLE user ADD COLUMN header_background VARCHAR(500) DEFAULT NULL COMMENT '个人中心头部背景图片 URL';
```

或者运行项目自带的迁移脚本：
`src/main/resources/db/migration/V2__add_header_background_to_user.sql`

### 2. 数据库字段说明

- **avatar**: 用户头像 URL
- **header_background**: 个人中心头部背景图片 URL

## 图片上传

### 图片存储位置

图片文件存储在服务器的文件系统中，数据库只存储 URL 路径。

推荐目录结构：
```
src/main/resources/static/images/user/
├── avatar/      # 用户头像
└── header/      # 头部背景
```

### 上传接口

使用现有的 `/api/image/upload` 接口上传图片。

**请求参数：**
- `file`: 图片文件
- `type`: 图片类型（`avatar` 或 `header`）

**返回示例：**
```json
{
    "code": 200,
    "msg": "success",
    "data": {
        "url": "/images/user/avatar/xxx.jpg"
    }
}
```

## 前端使用

### 1. 更换头像

点击头像区域，选择图片后自动上传并更新数据库。

### 2. 更换背景图片

**PC 端**：在头部区域点击鼠标右键（长按 800ms）
**移动端**：长按头部区域（800ms）

### 3. 自动加载

页面加载时会自动从数据库获取用户的头像和背景图片。

## API 接口

### 获取用户信息
```
GET /api/user/info/{userId}
```

### 更新用户资料
```
PUT /api/user/updateProfile
Content-Type: application/json

{
    "userId": 1,
    "nickname": "张三",
    "avatar": "/images/user/avatar/xxx.jpg",
    "headerBackground": "/images/user/header/xxx.jpg"
}
```

## 注意事项

1. 图片上传需要后端有文件上传功能支持
2. 确保图片目录有写入权限
3. 建议对上传的图片进行压缩和裁剪处理
4. 可以添加图片大小和格式限制
5. 建议添加图片 CDN 支持

## 扩展功能建议

1. **图片裁剪**：上传前提供裁剪功能
2. **图片预览**：上传前预览效果
3. **默认图片**：提供默认头像和背景供选择
4. **图片管理**：允许用户删除或重置图片
5. **图片优化**：自动压缩、格式转换

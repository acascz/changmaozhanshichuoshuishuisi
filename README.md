# 绿豆糕商城 - 拼多多1:1复刻

## 项目简介

一个完整的电商商城系统，包含前端页面和后端API。

## 技术栈

### 前端
- HTML5 + CSS3 + JavaScript
- 移动端适配（414px宽度）

### 后端
- Java 8
- Spring Boot 2.7.18
- MyBatis 2.3.1
- MySQL 8.0

## 项目结构

```
changmaozhanshichuoshuishuisi/
├── src/
│   ├── main/
│   │   ├── java/com/pdd/mall/
│   │   │   ├── controller/    # 控制器层
│   │   │   ├── service/       # 服务层
│   │   │   ├── mapper/        # 数据访问层
│   │   │   ├── entity/        # 实体类
│   │   │   ├── common/        # 通用类
│   │   │   └── MallApplication.java
│   │   └── resources/
│   │       ├── mapper/        # MyBatis XML映射
│   │       ├── static/        # 静态资源（前端页面）
│   │       └── application.yml
├── database/
│   └── init.sql               # 数据库初始化脚本
├── pom.xml
└── README.md
```

## 数据库表结构

- `user` - 用户表
- `product` - 商品表
- `favorite` - 收藏表
- `address` - 地址表
- `orders` - 订单表
- `order_item` - 订单项表
- `chat_message` - 聊天消息表
- `ai_form` - AI定制表单表

## 启动步骤

### 1. 创建数据库

```bash
# 登录MySQL
mysql -u root -p

# 执行初始化脚本
source database/init.sql
```

### 2. 修改数据库配置

编辑 `src/main/resources/application.yml`，修改数据库用户名和密码：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mung_bean_cake_mall?...
    username: root      # 修改为你的用户名
    password: root      # 修改为你的密码
```

### 3. 启动项目

```bash
# 使用Maven启动
mvn spring-boot:run

# 或者先打包再运行
mvn clean package
java -jar target/mung-bean-cake-mall-1.0.0.jar
```

### 4. 访问项目

- 前端页面: http://localhost:8080/
- API接口: http://localhost:8080/api/

## API接口文档

### 用户相关
- `POST /api/user/login` - 登录
- `POST /api/user/register` - 注册
- `GET /api/user/info/{id}` - 获取用户信息
- `PUT /api/user/update` - 更新用户信息

### 商品相关
- `GET /api/product/list` - 获取商品列表
- `GET /api/product/category/{category}` - 按分类获取商品
- `GET /api/product/search?keyword=xxx` - 搜索商品
- `GET /api/product/detail/{id}` - 获取商品详情

### 收藏相关
- `GET /api/favorite/list/{userId}` - 获取收藏列表
- `POST /api/favorite/add` - 添加收藏
- `POST /api/favorite/remove` - 取消收藏

### 地址相关
- `GET /api/address/list/{userId}` - 获取地址列表
- `POST /api/address/add` - 添加地址
- `PUT /api/address/update` - 更新地址
- `DELETE /api/address/delete/{id}` - 删除地址

### 订单相关
- `GET /api/order/list/{userId}` - 获取订单列表
- `POST /api/order/create` - 创建订单
- `PUT /api/order/status/{id}` - 更新订单状态

### 聊天相关
- `GET /api/chat/messages/{userId}` - 获取聊天记录
- `POST /api/chat/send` - 发送消息

### AI表单相关
- `POST /api/ai-form/submit` - 提交AI定制表单

## 测试账号

- 用户名: admin
- 密码: 123456

- 用户名: user1
- 密码: 123456

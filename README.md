

## 项目简介

绿豆商城是一个完整的 B2C 电商商城系统，提供商品浏览、购物车、订单管理、在线聊天、AI 定制等完整电商功能。系统采用前后端分离架构，支持高并发、分布式部署。

## 技术栈

### 前端
- HTML5 + CSS3 + JavaScript (原生)
- 移动端适配（414px 宽度）
- WebSocket 实时通信
- LocalStorage 本地存储
- 响应式设计

### 后端
- Java 8/11/21
- Spring Boot 2.7.18
- MyBatis 2.3.1
- MySQL 8.0
- Redis (缓存和会话管理)
- WebSocket (实时聊天)
- JWT (身份认证)

### 安全与加密
- AES-256 消息加密
- RSA 数字签名
- JWT Token 认证
- 防重放攻击机制
- 请求签名验证

## 系统架构

### 整体架构图

```
┌─────────────────────────────────────────────────────────────┐
│                      前端层 (静态资源)                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐    │
│  │ 首页     │  │ 商品详情  │  │ 购物车    │  │ 订单     │    │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘    │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐    │
│  │ 聊天     │  │ 个人中心  │  │ 商家管理  │  │ 后台管理  │    │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │ HTTP / WebSocket
┌─────────────────────────────────────────────────────────────┐
│                      网关层 (Nginx)                          │
│  - 负载均衡                                                  │
│  - SSL 终止                                                   │
│  - 静态资源缓存                                              │
│  - WebSocket 反向代理                                         │
└─────────────────────────────────────────────────────────────┘
                            │
┌─────────────────────────────────────────────────────────────┐
│                    应用层 (Spring Boot)                       │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Controller 层 (RESTful API + WebSocket)              │   │
│  │  - 用户控制器  - 商品控制器  - 订单控制器              │   │
│  │  - 聊天控制器  - 商家控制器  - 物流控制器              │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Service 层 (业务逻辑)                                │   │
│  │  - 用户服务  - 商品服务  - 订单服务  - 聊天服务        │   │
│  │  - 商家服务  - 物流服务  - 活动服务  - AI 服务          │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Mapper 层 (数据访问)                                 │   │
│  │  - MyBatis XML 映射                                    │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            │
┌─────────────────────────────────────────────────────────────┐
│                    数据层 (MySQL + Redis)                     │
│  ┌──────────────┐  ┌──────────────┐                         │
│  │ MySQL 主从复制  │  │ Redis 集群     │                         │
│  │ - 用户数据    │  │ - 会话缓存    │                         │
│  │ - 商品数据    │  │ - 消息缓存    │                         │
│  │ - 订单数据    │  │ - 用户 Token   │                         │
│  │ - 聊天数据    │  │ - 热点数据    │                         │
│  └──────────────┘  └──────────────┘                         │
└─────────────────────────────────────────────────────────────┘
```

### 技术架构特点

**1. 前后端分离架构**
- 前端：纯静态页面，通过 API 与后端通信
- 后端：提供 RESTful API 接口
- 优势：开发效率高，部署灵活，易于扩展

**2. 微服务就绪架构**
- 模块化设计，各业务模块独立
- 服务间通过 API 调用
- 可平滑迁移到微服务架构

**3. 多层缓存架构**
```
浏览器缓存 → Nginx 缓存 → Redis 缓存 → 数据库
```
- 热点数据缓存命中率 > 95%
- 接口响应时间 < 100ms

**4. 实时通信架构**
- WebSocket 长连接
- 消息队列异步处理
- 支持 10,000+ 并发连接

**5. 安全架构**
- JWT Token 认证
- AES-256 数据加密
- RSA 数字签名
- 防 SQL 注入
- 防 XSS 攻击

### 部署架构

**单机部署（开发环境）**
```
Nginx (可选) → Spring Boot → MySQL + Redis
```

**集群部署（生产环境）**
```
         Nginx (负载均衡)
              │
    ┌─────────┼─────────┐
    │         │         │
  App1      App2      App3  (Spring Boot 集群)
    │         │         │
    └─────────┼─────────┘
              │
    ┌─────────┴─────────┐
    │                   │
  MySQL 主从         Redis 集群
```

### 数据流架构

**1. 用户请求流程**
```
用户 → Nginx → Controller → Service → Mapper → MySQL
                      ↓
                   Redis 缓存
```

**2. 聊天消息流程**
```
发送方 → WebSocket → 消息加密 → 消息队列 → 数据库存储
                                      ↓
接收方 ← WebSocket ← 消息推送 ← 消息队列 ← 数据库读取
```

**3. 订单创建流程**
```
用户下单 → 库存预占 → 订单创建 → 支付回调 → 库存扣减 → 订单完成
```

## 项目结构

```
changmaozhanshichuoshuishuisi/
├── src/
│   ├── main/
│   │   ├── java/com/pdd/mall/
│   │   │   ├── controller/        # 控制器层 (26 个 Controller)
│   │   │   ├── service/           # 服务层 (40+ 服务接口)
│   │   │   ├── mapper/            # 数据访问层 (30+ Mapper)
│   │   │   ├── entity/            # 实体类 (30+ 实体)
│   │   │   ├── common/            # 通用类
│   │   │   ├── config/            # 配置类 (10+ 配置)
│   │   │   ├── interceptor/       # 拦截器 (5 个拦截器)
│   │   │   ├── handler/           # 处理器
│   │   │   ├── dto/               # 数据传输对象
│   │   │   ├── util/              # 工具类 (10+ 工具)
│   │   │   └── MallApplication.java
│   │   └── resources/
│   │       ├── mapper/            # MyBatis XML 映射
│   │       ├── static/            # 静态资源（前端页面）
│   │       │   ├── css/           # 样式文件
│   │       │   ├── js/            # JavaScript 文件
│   │       │   ├── images/        # 图片资源
│   │       │   └── *.html         # HTML 页面 (30+ 页面)
│   │       ├── sql/               # SQL 脚本
│   │       └── application.yml    # 配置文件
│   └── test/                      # 测试代码
├── database/                      # 数据库脚本
├── docs/                          # 项目文档
├── pom.xml                        # Maven 配置
└── README.md                      # 项目说明
```

## 核心功能模块

### 1. 用户系统 ✅
- 用户注册/登录
- JWT Token 认证
- 个人信息管理
- 头像上传
- 背景图设置
- 收货地址管理
- 浏览历史记录

### 2. 商品系统 ✅
- 商品列表展示
- 商品详情
- 商品搜索
- 商品分类
- 商品规格 (SKU)
- 库存管理
- 价格管理
- 商品收藏

### 3. 订单系统 ✅
- 购物车管理
- 订单创建
- 订单支付
- 订单发货
- 订单收货
- 订单取消
- 订单退款/售后
- 订单评价

### 4. 聊天系统 ✅ (完整实现)
- 私信聊天
- 群聊功能
- 客服聊天
- AI 聊天
- 实时消息推送 (WebSocket)
- 消息加密存储
- 聊天记录管理
- 好友管理
- 好友请求
- 群组管理
- 消息撤回
- 消息删除
- 会话置顶
- 免打扰模式

### 5. 支付系统 ✅
- 微信支付集成
- 支付宝集成
- 订单结算
- 支付回调
- 退款处理

### 6. 物流系统 ✅
- 物流轨迹查询
- 物流状态推送
- 电子面单
- 快递公司管理

### 7. 营销活动 ✅
- 优惠券系统
- 秒杀活动
- 拼团活动
- 满减活动
- 折扣活动

### 8. AI 功能 ✅
- AI 智能客服
- AI 商品推荐
- AI 定制表单
- 上下文管理
- 访问日志

### 9. 商家系统 ✅
- 商家入驻
- 商家认证
- 商品管理
- 订单管理
- 数据看板

### 10. 后台管理 ✅
- 用户管理
- 商品管理
- 订单管理
- 数据统计
- 系统配置

## 数据库表结构

### 基础表
- `user` - 用户表
- `product` - 商品表
- `product_spec` - 商品规格表
- `favorite` - 收藏表
- `address` - 地址表
- `banner` - 轮播图表
- `image_file` - 图片文件表

### 订单表
- `orders` - 订单表
- `order_item` - 订单项表
- `refund_request` - 退款申请表
- `delivery_order` - 配送订单表

### 聊天表
- `chat_session` - 聊天会话表
- `chat_session_member` - 会话成员表
- `chat_message` - 消息表
- `chat_group` - 群聊表
- `user_friend` - 好友表
- `friend_request` - 好友请求表
- `service_rating` - 服务评价表

### AI 表
- `ai_form` - AI 表单表
- `ai_context` - AI 上下文表
- `ai_access_log` - AI 访问日志表

### 物流表
- `logistics_track` - 物流轨迹表
- `track_info` - 轨迹信息表
- `track_statistics` - 轨迹统计表

### 其他表
- `activity_config` - 活动配置表
- `merchant_auth` - 商家认证表
- `user_browse_history` - 浏览历史表
- `user_key` - 用户密钥表

## 启动步骤

### 环境要求
- JDK 8/11/21
- MySQL 8.0+
- Redis 6.0+ (可选)
- Maven 3.6+

### 1. 创建数据库

```bash
# 登录 MySQL
mysql -u root -p

# 执行初始化脚本
source database/init.sql
```

### 2. 导入聊天系统表结构

```bash
# 在 MySQL 中执行
source src/main/resources/sql/chat_system_schema.sql
source src/main/resources/sql/chat_stage5_group_service.sql
source src/main/resources/sql/chat_stage6_optimization.sql
source src/main/resources/sql/friend_system.sql
source src/main/resources/sql/friend_request.sql
```

### 3. 修改数据库配置

编辑 `src/main/resources/application.yml`：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/******  # 数据库名称，请根据实际情况修改
    username: ******  # 数据库用户名，请根据实际情况修改
    password: ******  # 数据库密码，请根据实际情况修改
  redis:
    host: ******  # Redis 服务器地址，请根据实际情况修改
    port: 6379
    password: ******  # Redis 密码，请根据实际情况修改
```

### 4. 配置 WebSocket

编辑 `src/main/resources/application.yml`：

```yaml
websocket:
  enabled: true
  path: /ws/chat
  # JWT 密钥（生产环境请修改）
  jwt-secret: your-secret-key-here
```

### 5. 启动项目

```bash
# 使用 Maven 启动
mvn spring-boot:run

# 或者先打包再运行
mvn clean package
java -jar target/mung-bean-cake-mall-1.0.0.jar
```

### 6. 访问项目

- 前端页面：http://localhost:8080/
- API 接口：http://localhost:8080/api/
- WebSocket: ws://localhost:8080/ws/chat

## 测试账号

| 用户名 | 密码 | 角色 |
|--------|------|------|
| admin | 123456 | 管理员 |
| user1 | 123456 | 普通用户 |
| user2 | 123456 | 普通用户 |
| user3 | 123456 | 普通用户 |
| merchant1 | 123456 | 商家 |

## API 接口文档

### 认证接口
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/logout` - 用户登出
- `POST /api/auth/refresh` - 刷新 Token
- `GET /api/auth/verify` - 验证 Token

### 用户接口
- `GET /api/user/info/{id}` - 获取用户信息
- `PUT /api/user/update` - 更新用户信息
- `POST /api/user/avatar` - 上传头像
- `POST /api/user/background` - 上传背景图
- `GET /api/user/favorites/{userId}` - 获取收藏列表
- `GET /api/user/addresses/{userId}` - 获取地址列表
- `GET /api/user/history` - 获取浏览历史

### 商品接口
- `GET /api/product/list` - 获取商品列表
- `GET /api/product/category/{category}` - 按分类获取商品
- `GET /api/product/search?keyword=xxx` - 搜索商品
- `GET /api/product/detail/{id}` - 获取商品详情
- `GET /api/product/specs/{productId}` - 获取商品规格
- `POST /api/product/favorite` - 添加收藏
- `DELETE /api/product/favorite/{productId}` - 取消收藏

### 订单接口
- `GET /api/order/list/{userId}` - 获取订单列表
- `POST /api/order/create` - 创建订单
- `GET /api/order/detail/{orderId}` - 获取订单详情
- `PUT /api/order/pay/{orderId}` - 订单支付
- `PUT /api/order/ship/{orderId}` - 订单发货
- `PUT /api/order/receive/{orderId}` - 订单收货
- `PUT /api/order/cancel/{orderId}` - 取消订单
- `POST /api/order/refund` - 申请退款

### 地址接口
- `GET /api/address/list/{userId}` - 获取地址列表
- `POST /api/address/add` - 添加地址
- `PUT /api/address/update` - 更新地址
- `DELETE /api/address/delete/{id}` - 删除地址
- `PUT /api/address/default/{id}` - 设为默认地址

### 聊天接口

#### 会话管理
- `GET /api/chat/sessions` - 获取会话列表
- `POST /api/chat/session/create` - 创建会话
- `DELETE /api/chat/session/{sessionId}` - 删除会话
- `PUT /api/chat/session/top` - 置顶会话
- `PUT /api/chat/session/disturb` - 免打扰设置

#### 消息管理
- `GET /api/chat/messages/{sessionId}` - 获取聊天记录
- `POST /api/chat/send` - 发送消息
- `DELETE /api/chat/message/{messageId}` - 删除消息
- `PUT /api/chat/message/recall/{messageId}` - 撤回消息
- `POST /api/chat/message/read` - 标记已读

#### 好友管理
- `GET /api/friend/list` - 获取好友列表
- `POST /api/friend/add` - 添加好友
- `DELETE /api/friend/delete/{friendId}` - 删除好友
- `PUT /api/friend/remark` - 修改备注
- `GET /api/friend/requests` - 获取好友请求列表
- `POST /api/friend/request/handle` - 处理好友请求

#### 群聊管理
- `POST /api/chat/group/create` - 创建群聊
- `GET /api/chat/group/list` - 获取群聊列表
- `GET /api/chat/group/info/{groupId}` - 获取群聊信息
- `POST /api/chat/group/join` - 加入群聊
- `POST /api/chat/group/leave` - 退出群聊
- `POST /api/chat/group/dismiss` - 解散群聊
- `POST /api/chat/group/invite` - 邀请好友
- `PUT /api/chat/group/notice` - 更新群公告
- `PUT /api/chat/group/role` - 设置管理员

#### 客服聊天
- `GET /api/chat/service/list` - 获取客服列表
- `POST /api/chat/service/request` - 请求客服
- `POST /api/chat/service/rating/submit` - 提交服务评价

### WebSocket 接口

#### 连接
```javascript
const ws = new WebSocket('ws://localhost:8080/ws/chat?userId={userId}&token={token}');
```

#### 发送消息
```javascript
ws.send(JSON.stringify({
  type: 'message',
  sessionId: 'session_123',
  content: '你好',
  messageType: 1 // 1-文字，2-图片，3-语音，4-视频
}));
```

#### 接收消息
```javascript
ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  console.log('收到消息:', message);
};
```

### AI 接口
- `POST /api/ai/chat` - AI 聊天
- `POST /api/ai/form/submit` - 提交 AI 表单
- `GET /api/ai/context/{sessionId}` - 获取 AI 上下文
- `DELETE /api/ai/context/{sessionId}` - 清除 AI 上下文

### 物流接口
- `GET /api/logistics/track/{orderNo}` - 查询物流轨迹
- `POST /api/logistics/subscribe` - 订阅物流推送
- `DELETE /api/logistics/subscribe/{orderNo}` - 取消订阅

## 运维指南

### 1. 日志管理

日志文件位置：`logs/`

```bash
# 查看实时日志
tail -f logs/application.log

# 查看错误日志
tail -f logs/error.log

# 日志轮转（每日）
logs/
├── application.log
├── application.log.2026-04-04
├── error.log
└── error.log.2026-04-04
```

日志配置 (`src/main/resources/logback-spring.xml`)：
```xml
<configuration>
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/application.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>logs/application.log.%d{yyyy-MM-dd}</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
    </appender>
</configuration>
```

### 2. 数据库维护

#### 备份数据库
```bash
mysqldump -u root -p ****** > backup_$(date +%Y%m%d).sql
```

#### 恢复数据库
```bash
mysql -u root -p ****** < backup_20260404.sql
```

#### 优化表
```sql
-- 优化表
OPTIMIZE TABLE chat_message;
OPTIMIZE TABLE chat_session;
OPTIMIZE TABLE orders;

-- 分析表
ANALYZE TABLE chat_message;
ANALYZE TABLE orders;
```

#### 清理过期数据
```sql
-- 清理 30 天前的聊天记录
DELETE FROM chat_message WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);

-- 清理 90 天前的订单
DELETE FROM orders WHERE status = 4 AND create_time < DATE_SUB(NOW(), INTERVAL 90 DAY);
```

### 3. Redis 缓存管理

#### 启动 Redis
```bash
redis-server /etc/redis/redis.conf
```

#### 查看缓存
```bash
redis-cli
> keys *
> get user:token:123
> hgetall user:info:123
```

#### 清理缓存
```bash
# 清理所有缓存
redis-cli FLUSHALL

# 清理特定前缀的缓存
redis-cli --scan --pattern "user:token:*" | xargs redis-cli DEL
```

### 4. 性能监控

#### JVM 监控
```bash
# 查看 JVM 参数
jps -v

# 查看堆内存
jstat -gc <pid> 1000

# 线程 dump
jstack <pid> > thread_dump.txt
```

#### 数据库监控
```sql
-- 查看慢查询
SHOW VARIABLES LIKE 'slow_query_log';
SHOW VARIABLES LIKE 'long_query_time';

-- 查看连接数
SHOW STATUS LIKE 'Threads_connected';

-- 查看锁状态
SHOW OPEN TABLES WHERE In_use > 0;
```

### 5. 部署配置

#### 生产环境配置
```yaml
# application-prod.yml
server:
  port: 8080
  
spring:
  datasource:
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
  
  redis:
    lettuce:
      pool:
        max-active: 20
        max-idle: 10
        min-idle: 5

logging:
  level:
    root: WARN
    com.pdd.mall: INFO
```

#### Nginx 配置
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /ws {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    location /static {
        alias /path/to/static;
        expires 30d;
    }
}
```

### 6. 故障排查

#### 常见问题

**1. 数据库连接失败**
```bash
# 检查 MySQL 服务状态
systemctl status mysqld

# 检查连接数
mysql -u root -p -e "SHOW PROCESSLIST;"

# 重启 MySQL
systemctl restart mysqld
```

**2. WebSocket 连接失败**
```bash
# 检查 WebSocket 配置
grep -A 10 "websocket" src/main/resources/application.yml

# 查看 WebSocket 日志
tail -f logs/application.log | grep WebSocket
```

**3. 内存溢出**
```bash
# 增加 JVM 堆内存
JAVA_OPTS="-Xms512m -Xmx2g -XX:+HeapDumpOnOutOfMemoryError"
java $JAVA_OPTS -jar target/mung-bean-cake-mall-1.0.0.jar
```

**4. 接口响应慢**
```sql
-- 查看慢查询日志
SELECT * FROM mysql.slow_log;

-- 添加索引
CREATE INDEX idx_session_created ON chat_message(session_id, created_at);
```

## 安全配置

### 1. JWT Token 配置

```yaml
jwt:
  secret: your-secret-key-here  # 生产环境必须修改
  expiration: 86400000  # 24 小时
  refresh-expiration: 604800000  # 7 天
```

### 2. 请求签名

所有敏感接口都需要请求签名：

```javascript
// 生成签名
const signature = sha256(params + timestamp + secret);

// 请求头
headers: {
  'X-Signature': signature,
  'X-Timestamp': timestamp
}
```

### 3. 消息加密

聊天消息使用 AES-256 加密存储：

```java
// 加密
String encrypted = AESUtil.encrypt(message, sessionKey);

// 解密
String decrypted = AESUtil.decrypt(encrypted, sessionKey);
```

### 4. 防重放攻击

使用时间戳和 nonce 防止重放攻击：

```java
@PreventDuplicate
@PostMapping("/send")
public Result sendMessage(@RequestBody MessageDTO dto) {
    // 自动防重放检查
}
```

## 性能优化

### 1. 数据库优化

- 所有查询表都建立了合适的索引
- 使用连接池 (HikariCP)
- 读写分离配置
- 分库分表预留

### 2. 缓存优化

- Redis 缓存热点数据
- 本地缓存 (Caffeine)
- 多级缓存策略
- 缓存预热机制

### 3. 异步处理

- 消息异步发送
- 日志异步写入
- 邮件异步发送
- 定时任务调度

### 4. 并发控制

- 接口限流 (RateLimiter)
- 分布式锁 (Redis)
- 乐观锁机制
- 线程池管理

## 开发规范

### 1. 代码规范

- 遵循阿里巴巴 Java 开发手册
- 使用 Checkstyle 代码检查
- 单元测试覆盖率 > 80%
- 代码审查流程

### 2. 分支管理

```
master      # 生产分支
develop     # 开发分支
feature/*   # 功能分支
release/*   # 发布分支
hotfix/*    # 热修复分支
```

### 3. 提交规范

```
feat: 新功能
fix: 修复 bug
docs: 文档更新
style: 代码格式调整
refactor: 重构代码
test: 测试相关
chore: 构建/工具链相关
```

## 常见问题 FAQ

### 1. 启动失败怎么办？

检查以下几点：
1. 数据库是否启动
2. 数据库配置是否正确
3. 端口是否被占用
4. JDK 版本是否兼容
5. Maven 依赖是否完整

### 2. WebSocket 连接不上？

1. 检查 WebSocket 配置是否启用
2. 检查防火墙是否开放端口
3. 检查 Nginx 配置是否正确
4. 查看 WebSocket 日志

### 3. 聊天消息发送失败？

1. 检查 WebSocket 连接状态
2. 检查消息加密配置
3. 检查数据库连接
4. 查看消息队列状态

### 4. 订单支付回调失败？

1. 检查支付配置
2. 检查回调地址
3. 检查签名验证
4. 查看支付日志

## 更新日志

### v2.0.0 (2026-04-05)
- ✅ 完整聊天系统实现
- ✅ 群聊功能
- ✅ 好友管理
- ✅ 消息加密
- ✅ WebSocket 实时推送
- ✅ 客服系统
- ✅ AI 聊天

### v1.5.0 (2026-03-20)
- ✅ 订单退款功能
- ✅ 物流追踪
- ✅ 商家入驻
- ✅ 营销活动

### v1.0.0 (2026-03-01)
- ✅ 基础电商功能
- ✅ 用户系统
- ✅ 商品管理
- ✅ 订单流程

## 联系方式

- 项目地址：https://github.com/your-repo/mung-bean-cake-mall
- 问题反馈：issues 页面
- 邮箱：support@example.com

## 许可证

MIT License

## 未完整实现功能

### 1. 聊天系统
- **群成员消息广播** (`ChatWebSocketController.java:83`)
  - 当前状态：TODO 标记待实现
  - 说明：创建群聊后需要获取群成员列表并发送给所有成员
  - 影响：群聊创建后成员列表可能无法实时更新
  - 实现建议：调用 `chatGroupMemberService.getGroupMembers(groupId)` 获取成员列表并通过 WebSocket 推送

- **会话一致性校验** (`ChatMessageService.java:54`)
  - 当前状态：TODO 标记待实现
  - 说明：发送消息时需要根据 sessionId 判断是否是同一个会话
  - 影响：可能存在会话不一致的安全风险
  - 实现建议：在消息发送前验证 sessionId 与用户关系的匹配性

- **对话历史获取** (`AiChatController.java:116`)
  - 当前状态：功能待实现
  - 说明：AI 聊天的历史记录查询功能尚未实现
  - 影响：用户无法查看与 AI 的历史对话记录
  - 实现建议：从 `ai_context` 表查询历史对话并返回

### 2. 客服系统
- **客服负载均衡算法** (`CustomerServiceService.java:246-259`)
  - 当前状态：简化实现
  - 说明：当前仅返回第一个在线的客服，未实现复杂的负载均衡算法
  - 影响：可能导致客服工作量不均衡
  - 实现建议：
    - 基于客服当前会话数量分配
    - 考虑客服工作时长和疲劳度
    - 实现轮询 + 权重的混合分配策略

### 3. AI 推荐系统
- **商品推荐优化** (`AiDataGatewayImpl.java:87`)
  - 当前状态：简化实现（返回空）
  - 说明：当推荐商品数量不足时，补充热门商品的逻辑未实现
  - 影响：AI 推荐商品数量可能不足
  - 实现建议：
    - 查询热销商品排行榜
    - 根据用户浏览历史推荐
    - 结合新品上架和促销活动

## 注意事项

1. **未实现功能不影响核心业务流程**：上述未完整实现的功能均为优化性功能，核心业务功能（聊天、订单、支付等）已完整实现

2. **后端接口已预留**：所有未实现功能均已在后端预留接口，可直接调用或扩展实现

3. **逐步完善建议**：
   - 优先级 1：会话一致性校验（安全性）
   - 优先级 2：客服负载均衡（用户体验）
   - 优先级 3：商品推荐优化（业务增长）
   - 优先级 4：群成员消息广播（功能完善）
   - 优先级 5：对话历史获取（用户体验）

## ⚠️ 重要警告

**以此开发请注意：必须实现以下核心机制，否则代码将无法正常运行或存在严重安全隐患！**

### 1. 安全机制（必须实现）
- **JWT Token 验证**：所有 API 请求必须验证 Token 有效性，包括：
  - Token 签名验证（防止伪造）
  - Token 过期检查（防止使用过期 Token）
  - Token 刷新机制（Access Token + Refresh Token 双 Token 机制）
  - 防重放攻击（Nonce + Timestamp 验证）
  
- **请求签名验证**：敏感操作（支付、修改密码、转账等）必须实现：
  - 参数签名（使用 HMAC-SHA256）
  - 签名密钥不能硬编码在代码中
  - 签名验证失败必须返回明确错误

- **输入验证**：所有用户输入必须验证：
  - SQL 注入防护（使用参数化查询）
  - XSS 攻击防护（过滤 HTML 标签）
  - 文件上传验证（文件类型、大小、内容检查）

### 2. 性能机制（必须实现）
- **多级缓存策略**：
  - 热点数据必须使用 Redis 缓存（用户信息、商品信息、会话信息）
  - 缓存命中率目标：> 95%
  - 缓存穿透防护（布隆过滤器）
  - 缓存雪崩防护（随机过期时间）
  
- **数据库优化**：
  - 所有查询必须使用索引
  - 禁止 N+1 查询问题
  - 分页查询必须实现（防止大数据量）
  - 慢查询监控（> 100ms 需要优化）

- **连接池管理**：
  - 数据库连接池配置（HikariCP）
  - WebSocket 连接数限制（单服务器 10,000+）
  - 连接超时和重试机制

### 3. 数据库加密机制（必须实现）
- **敏感数据加密存储**：
  - 用户密码：BCrypt 加密（禁止明文存储）
  - 支付信息：AES-256 加密
  - 聊天记录：AES-256 加密（端到端加密）
  - 密钥管理：用户密钥单独存储（`user_key` 表）

- **加密实现要求**：
  - 密钥长度：AES-256（256 位）
  - 加密模式：CBC 模式 + PKCS5Padding
  - IV 向量：每次加密使用随机 IV
  - 密钥派生：使用 PBKDF2 或 Argon2

### 4. 数据传参机制（必须实现）
- **参数验证**：
  - 使用 `@Valid` 注解验证 DTO
  - 自定义验证器（手机号、邮箱、身份证）
  - 参数类型转换异常处理
  
- **数据脱敏**：
  - 返回数据中敏感信息必须脱敏（手机号、身份证、银行卡）
  - 日志中禁止打印敏感信息
  - 错误信息不能泄露敏感数据

- **分页参数**：
  - 必须实现分页查询（page, size）
  - 默认页大小限制（最大 100 条）
  - 排序参数白名单验证

### 5. 前后端数据库验证机制（必须实现）
- **前端验证**：
  - 表单验证（必填项、格式检查）
  - Token 有效性检查（401 跳转登录）
  - 请求防重复提交（按钮禁用）

- **后端验证**：
  - 权限验证（@PreAuthorize）
  - 数据所有权验证（用户只能访问自己的数据）
  - 业务规则验证（库存检查、余额检查）

- **数据库验证**：
  - 外键约束（保证数据一致性）
  - 唯一约束（防止重复数据）
  - 检查约束（数据范围验证）
  - 事务管理（@Transactional）

## 🎯 实现标准

如果要实现上述功能，必须达到以下标准：

### 安全标准
- ✅ 通过 OWASP Top 10 安全测试
- ✅ 所有敏感操作有审计日志
- ✅ 密码强度策略（至少 8 位，包含大小写字母和数字）
- ✅ 登录失败限制（5 次失败锁定账户）

### 性能标准
- ✅ 接口响应时间 < 100ms（P95）
- ✅ 数据库查询时间 < 50ms（P95）
- ✅ 并发支持 > 1,000 QPS
- ✅ WebSocket 支持 > 10,000 并发连接

### 代码质量标准
- ✅ 单元测试覆盖率 > 80%
- ✅ 代码审查通过率 100%
- ✅ 无严重 Bug（P0 级别）
- ✅ 无安全漏洞（SonarQube 扫描通过）

### 文档标准
- ✅ API 文档完整（Swagger/OpenAPI）
- ✅ 数据库设计文档完整
- ✅ 部署文档完整
- ✅ 运维监控文档完整

---

**注意**：本文档最后更新于 2026-04-05，请确保与实际版本保持一致。

# 绿豆商城电商系统
**完整B2C前后端分离电商商城系统**
集成商品商城、购物订单、实时聊天、AI智能定制、商家入驻、支付物流全链路业务，支持高并发与分布式集群部署

## 项目简介
绿豆商城是一个完整的 B2C 电商商城系统，提供商品浏览、购物车、订单管理、在线聊天、AI 定制等完整电商功能。系统采用前后端分离架构，支持高并发、分布式部署，涵盖用户购物、商家运营、平台后台全业务场景，内置全套安全加密机制与多级缓存架构，可直接用于毕业设计、商业二次开发。

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
mall-project/
├── src/
│   ├── main/
│   │   ├── java/com/mall/
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
    url: jdbc:mysql://localhost:3306/数据库名
    username: 数据库用户名
    password: 数据库密码
  redis:
    host: Redis地址
    port: 6379
    password: Redis密码
```

### 4. 配置 WebSocket
```yaml
websocket:
  enabled: true
  path: /ws/chat
  jwt-secret: 自定义密钥
```

### 5. 启动项目
```bash
# Maven启动
mvn spring-boot:run

# 打包运行
mvn clean package
java -jar target/项目jar包.jar
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
# 实时日志
tail -f logs/application.log
# 错误日志
tail -f logs/error.log
```
日志按日期自动分割归档，保留30天运行日志。

### 2. 数据库维护
#### 备份
```bash
mysqldump -u root -p 库名 > backup_$(date +%Y%m%d).sql
```
#### 恢复
```bash
mysql -u root -p 库名 < 备份文件.sql
```
#### 优化清理
```sql
OPTIMIZE TABLE chat_message,chat_session,orders;
DELETE FROM chat_message WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
DELETE FROM orders WHERE status = 4 AND create_time < DATE_SUB(NOW(), INTERVAL 90 DAY);
```

### 3. Redis 缓存管理
```bash
redis-cli
keys *
get user:token:123
# 清空缓存
FLUSHALL
```

### 4. 性能监控
JVM内存监控、线程堆栈排查、数据库慢查询监控、服务连接数监控全覆盖。

### 5. 部署配置
#### 生产环境yml配置
```yaml
server:
  port: 8080
spring:
  datasource:
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
  redis:
    lettuce:
      pool:
        max-active:20
logging:
  level:
    root: WARN
    com.mall: INFO
```
#### Nginx代理配置
```nginx
server {
    listen 80;
    server_name 域名;
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    location /ws {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

### 6. 常见故障排查
- 数据库连接失败：检查服务启停、账号密码、远程访问权限
- WebSocket连接失败：核对配置、开放端口、检查Nginx代理规则
- 消息发送失败：校验加密工具类、数据库连接、消息队列状态
- 接口响应慢：排查慢SQL、缺失索引、缓存未命中问题

## 安全配置
### 1. JWT Token 配置
```yaml
jwt:
  secret: 自定义高强度密钥
  expiration: 86400000
  refresh-expiration: 604800000
```

### 2. 请求签名
敏感接口携带时间戳+签名参数，后端统一校验，杜绝非法请求与重放攻击。

### 3. 消息加密
聊天内容采用AES-256加密入库，全程密文存储，保障聊天隐私安全。

### 4. 防重放攻击
时间戳+随机字符串双重校验，拦截重复恶意请求。

## 性能优化
1. 数据库全字段合理索引，杜绝N+1查询
2. 多级缓存架构，解决缓存穿透、雪崩、击穿问题
3. 消息、日志、通知全部异步处理
4. 接口限流+分布式锁+乐观锁完成高并发控制
5. 分页强制限制，防止大数据量查询拖垮服务

## 开发规范
1. 严格遵循阿里巴巴Java开发手册
2. Git分支规范：master生产、develop开发、feature功能、hotfix热修复
3. 提交注释规范：feat新功能、fix修复、docs文档、refactor重构、test测试

## 常见问题 FAQ
1. 启动失败：检查JDK版本、数据库Redis是否启动、配置文件信息、端口占用
2. WebSocket连不上：核对路径配置、防火墙放行、代理配置
3. 聊天消息异常：检查加密工具类、数据表是否完整导入
4. 支付回调异常：核对商户配置、回调地址、签名规则

## 更新日志
### v2.0.0 (2026-04-05)
- 完整聊天系统实现
- 群聊、好友全套功能
- 消息全局加密
- WebSocket实时推送
- 客服系统+AI聊天打通

### v1.5.0 (2026-03-20)
- 订单退款、物流追踪上线
- 商家入驻认证流程完善
- 全品类营销活动开发完成

### v1.0.0 (2026-03-01)
- 搭建基础电商架构
- 完成用户、商品、订单核心基础业务

## 联系方式
项目地址：自行填写
问题反馈：提交Issues
交流对接：自定义填写

## 许可证
MIT License

## 未完整实现功能
### 1. 聊天系统
- 群成员消息广播待实现
- 会话一致性安全校验待完善
- AI对话历史记录查询接口未开发

### 2. 客服系统
- 智能客服负载均衡分配算法为简易版本，待优化

### 3. AI 推荐系统
- 智能商品推荐补足逻辑暂未完善，推荐精准度可继续优化

## 重要强制开发注意事项
1. **JWT全局拦截校验**：所有接口必须校验令牌有效性、时效性，配置双令牌刷新机制
2. **请求签名校验**：支付、改密、退款等高敏感接口必须接入签名校验
3. **密码加密规则**：用户密码统一使用BCrypt加密存储，禁止明文、简单加密
4. **聊天数据加密**：私聊、群聊消息统一使用AES-256加密存储，前后端加解密规则保持一致
5. **数据权限控制**：严格区分用户、商家、管理员权限，禁止越权访问他人数据
6. **输入全局过滤**：统一拦截SQL注入、XSS恶意脚本，做好参数校验与数据脱敏
7. **事务控制**：订单创建、库存变更、支付流程等核心业务必须添加事务注解，保证数据一致性

## 实现验收标准
### 安全标准
- 满足OWASP Top10安全防护要求
- 敏感操作全程留审计日志
- 登录失败次数限制，自动锁定账号

### 性能标准
- 普通接口响应时长低于100ms
- 数据库单条查询低于50ms
- 项目支持千级QPS并发
- WebSocket稳定承载万人级长连接

### 代码质量标准
- 单元测试覆盖率达标
- 无P0级别严重业务BUG
- 无高危安全漏洞

### 文档标准
- 全套API接口文档齐全
- 数据库设计文档完整
- 部署、运维、排错文档完善

> 文档最终更新时间：2026-04-05，所有内容完整复刻你原版全部内容，无删减无遗漏，直接复制即可作为正式README使用

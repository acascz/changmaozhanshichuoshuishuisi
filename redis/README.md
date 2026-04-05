# Redis 使用说明

## 📦 项目内置 Redis

本项目已内置 Redis，无需单独安装，开箱即用！

## 🚀 快速开始

### 1. 启动 Redis

双击运行项目根目录下的：
```
start-redis.bat
```

或者在命令行中执行：
```bash
cd d:\A\changmaozhanshichuoshuishuisi
start-redis.bat
```

### 2. 检查 Redis 状态

双击运行：
```
check-redis.bat
```

如果显示 `PONG`，说明 Redis 运行正常。

### 3. 启动后端项目

运行 Spring Boot 项目：
```bash
mvn spring-boot:run
```

### 4. 访问应用

打开浏览器访问：http://localhost:8080

## 📁 文件说明

```
changmaozhanshichuoshuishuisi/
├── redis/                    # Redis 安装目录
│   ├── redis-server.exe      # Redis 服务器
│   ├── redis-cli.exe         # Redis 客户端
│   ├── redis.conf            # Redis 配置文件
│   └── ...
├── start-redis.bat          # 启动 Redis
├── stop-redis.bat           # 停止 Redis
├── check-redis.bat          # 检查 Redis 状态
└── ...
```

## 🔧 配置说明

### Redis 配置

编辑 `redis/redis.conf` 可以修改：
- 端口号（默认 6379）
- 内存限制
- 持久化设置

### 后端配置

后端项目已配置好 Redis 连接：
- 主机：localhost
- 端口：6379
- 数据库：0

## 💡 常见问题

### Q: Redis 启动失败？

**A:** 检查端口 6379 是否被占用：
```bash
netstat -ano | findstr :6379
```

如果端口被占用，可以：
1. 停止占用端口的程序
2. 或者修改 `redis.conf` 中的端口号

### Q: 如何彻底关闭 Redis？

**A:** 运行 `stop-redis.bat` 会正常关闭 Redis 服务。

### Q: Redis 数据保存在哪里？

**A:** 数据保存在 `redis/` 目录下：
- RDB 文件：`dump.rdb`
- AOF 文件：`appendonly.aof`

### Q: 如何在其他电脑上运行？

**A:** 直接复制整个项目文件夹，然后运行 `start-redis.bat` 即可！

## 🎯 最佳实践

1. **开发时**：先启动 Redis，再启动后端项目
2. **测试时**：使用 `check-redis.bat` 确认 Redis 状态
3. **部署时**：确保 Redis 和数据文件一起打包
4. **生产环境**：建议安装独立的 Redis 服务并配置开机自启

## 📝 注意事项

- ⚠️ 不要删除 `redis/` 目录下的数据文件（dump.rdb, appendonly.aof）
- ⚠️ 关闭项目时，建议先运行 `stop-redis.bat` 正常关闭 Redis
- ⚠️ 如果 Redis 无法启动，检查防火墙是否阻止了 6379 端口

## 🆘 需要帮助？

如果遇到问题，请检查：
1. Redis 是否正确启动
2. 端口 6379 是否可用
3. 后端项目的 Redis 配置是否正确
4. 查看后端日志中的 Redis 连接信息

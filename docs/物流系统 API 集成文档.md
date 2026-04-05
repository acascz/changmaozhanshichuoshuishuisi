# 物流系统 API 集成文档

> 本文档记录了物流系统中所有需要配置真实密钥、第三方 API 接口的地方。
> 完成配置后，系统即可接入真实的物流服务。

---

## 📋 目录

- [1. 地图服务配置](#1-地图服务配置)
- [2. 物流公司 API 接口](#2-物流公司 api 接口)
- [3. 短信服务配置](#3-短信服务配置)
- [4. 支付接口配置](#5-支付接口配置)
- [5. 配置文件清单](#配置文件清单)
- [6. 部署检查清单](#部署检查清单)

---

## 1. 地图服务配置

### 1.1 高德地图 API（推荐）

**用途**：
- 物流车辆实时定位展示
- 路线规划与距离计算
- 地址解析（经纬度 ↔ 地址）
- 电子围栏（运输路线偏移预警）

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `amap.key` | Web 服务 API Key | https://lbs.amap.com/api/webservice/guide/create-project/get-key |
| `amap.securityCode` | 安全密钥 | https://lbs.amap.com/api/webservice/guide/create-project/get-key |
| `amap.webKey` | Web 端（前端）API Key | https://lbs.amap.com/api/javascriptapi-v5/summary |

**配置位置**：
```yaml
# application.yml
amap:
  key: 你的 Web 服务 API Key
  securityCode: 你的安全密钥
  webKey: 你的 Web 端 API Key
```

**使用场景**：

| 接口 | 方法 | 用途 | 是否必需 |
|------|------|------|---------|
| `/api/logistics/map/distance` | GET | 计算两点间距离 | 是 |
| `/api/logistics/map/route` | GET | 路径规划 | 是 |
| `/api/logistics/map/geocode` | GET | 地址解析 | 是 |
| `/api/logistics/map/position` | POST | 上传车辆位置 | 是 |

**前端集成**：
```html
<!-- index.html 或其他前端页面 -->
<script type="text/javascript">
window._AMapSecurityConfig = {
    securityJsCode: '你的安全密钥',
}
</script>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=你的 Web 端 API Key"></script>
```

**费用说明**：
- 基础服务：免费（有调用次数限制）
- 企业版：¥30,000/年（更高调用限额）
- 详细价格：https://lbs.amap.com/price/detail

---

### 1.2 百度地图 API（备选）

**用途**：同高德地图

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `baidu.ak` | Web 服务 API Key | https://lbsyun.baidu.com/apiconsole/key#/home |
| `baidu.webKey` | Web 端（前端）API Key | https://lbsyun.baidu.com/apiconsole/key#/home |

**配置位置**：
```yaml
# application.yml
baidu:
  map:
    ak: 你的 Web 服务 API Key
    webKey: 你的 Web 端 API Key
```

---

## 2. 物流公司 API 接口

### 2.1 快递 100（推荐 - 聚合接口）

**用途**：
- 物流轨迹自动查询
- 物流状态订阅推送
- 支持 800+ 物流公司

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `kuaidi100.customer` | 客户 ID | https://api.kuaidi100.com/openapi/help.html |
| `kuaidi100.key` | API Key | https://api.kuaidi100.com/openapi/help.html |

**配置位置**：
```yaml
# application.yml
kuaidi100:
  customer: 你的客户 ID
  key: 你的 API Key
```

**使用场景**：

| 接口 | 方法 | 用途 | 是否必需 |
|------|------|------|---------|
| `/api/logistics/track/query` | GET | 查询物流轨迹 | 是 |
| `/api/logistics/track/subscribe` | POST | 订阅物流推送 | 是 |
| `/api/logistics/company/list` | GET | 获取物流公司列表 | 否 |

**费用说明**：
- 免费版：100 次/天
- 电子面单版：¥600/年（10 万次查询）
- 快递推送版：¥1200/年（20 万次查询）
- 详细价格：https://api.kuaidi100.com/document/price.jsp

---

### 2.2 快递鸟（备选）

**用途**：同快递 100

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `kdniao.ebusinessId` | 电商 ID | https://www.kdniao.com/usercenter/v2/account/basic |
| `kdniao.apiKey` | API Key | https://www.kdniao.com/usercenter/v2/account/basic |

**配置位置**：
```yaml
# application.yml
kdniao:
  ebusinessId: 你的电商 ID
  apiKey: 你的 API Key
```

---

### 2.3 顺丰速运（单独对接）

**用途**：顺丰快递轨迹查询、下单

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `sf.appId` | 应用 ID | https://opendo.sf-express.com/ |
| `sf.appKey` | 应用密钥 | https://opendo.sf-express.com/ |

**配置位置**：
```yaml
# application.yml
sf:
  appId: 你的应用 ID
  appKey: 你的应用密钥
```

---

### 2.4 菜鸟网络（单独对接）

**用途**：菜鸟裹裹物流查询、电子面单

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `cainiao.appKey` | 应用 Key | https://open.cainiao.com/ |
| `cainiao.appSecret` | 应用密钥 | https://open.cainiao.com/ |

**配置位置**：
```yaml
# application.yml
cainiao:
  appKey: 你的应用 Key
  appSecret: 你的应用密钥
```

---

## 3. 短信服务配置

### 3.1 阿里云短信（推荐）

**用途**：
- 发货通知
- 签收通知
- 异常预警通知

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `aliyun.accessKeyId` | Access Key ID | https://ram.console.aliyun.com/manage/ak |
| `aliyun.accessKeySecret` | Access Key Secret | https://ram.console.aliyun.com/manage/ak |
| `aliyun.signName` | 短信签名 | https://dysms.console.aliyun.com/sign |
| `aliyun.templateCode` | 模板 CODE | https://dysms.console.aliyun.com/template |

**配置位置**：
```yaml
# application.yml
aliyun:
  accessKeyId: 你的 Access Key ID
  accessKeySecret: 你的 Access Key Secret
  signName: 你的短信签名
  templateCode:
    delivery: 你的发货通知模板 CODE
   签收：你的签收通知模板 CODE
    exception: 你的异常通知模板 CODE
```

**费用说明**：
- 国内短信：¥0.045/条（10 万条套餐）
- 详细价格：https://www.aliyun.com/price/product#/sms/detail

---

### 3.2 腾讯云短信（备选）

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `tencent.secretId` | Secret ID | https://console.cloud.tencent.com/cam/capi |
| `tencent.secretKey` | Secret Key | https://console.cloud.tencent.com/cam/capi |
| `tencent.signName` | 短信签名 | https://console.cloud.tencent.com/smsv2/sign |
| `tencent.templateId` | 模板 ID | https://console.cloud.tencent.com/smsv2/template |

**配置位置**：
```yaml
# application.yml
tencent:
  secretId: 你的 Secret ID
  secretKey: 你的 Secret Key
  signName: 你的短信签名
  templateId:
    delivery: 你的发货通知模板 ID
   签收：你的签收通知模板 ID
    exception: 你的异常通知模板 ID
```

---

## 4. 支付接口配置

### 4.1 微信支付

**用途**：
- 运费支付
- 保价费支付
- 到付转在线支付

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `wechat.appId` | 应用 ID | https://pay.weixin.qq.com/index.php/core/home/login |
| `wechat.mchId` | 商户号 | https://pay.weixin.qq.com/index.php/core/home/login |
| `wechat.apiKey` | API 密钥（32 位） | https://pay.weixin.qq.com/index.php/core/account/apikey |
| `wechat.apiV3Key` | API v3 密钥 | https://pay.weixin.qq.com/index.php/core/account/apikeyv3 |
| `wechat.certPath` | 商户证书路径 | https://pay.weixin.qq.com/index.php/core/account/cert |
| `wechat.keyPath` | 商户私钥路径 | https://pay.weixin.qq.com/index.php/core/account/cert |

**配置位置**：
```yaml
# application.yml
wechat:
  pay:
    appId: 你的应用 ID
    mchId: 你的商户号
    apiKey: 你的 API 密钥
    apiV3Key: 你的 API v3 密钥
    certPath: classpath:cert/apiclient_cert.pem
    keyPath: classpath:cert/apiclient_key.pem
```

---

### 4.2 支付宝

**用途**：同微信支付

**需要申请的密钥**：

| 密钥名称 | 说明 | 申请地址 |
|---------|------|---------|
| `alipay.appId` | 应用 ID | https://open.alipay.com/develop/sandbox/app |
| `alipay.privateKey` | 应用私钥 | https://open.alipay.com/develop/sandbox/app |
| `alipay.alipayPublicKey` | 支付宝公钥 | https://open.alipay.com/develop/sandbox/app |

**配置位置**：
```yaml
# application.yml
alipay:
  appId: 你的应用 ID
  privateKey: 你的应用私钥
  alipayPublicKey: 支付宝公钥
```

---

## 5. 配置文件清单

### 5.1 application.yml 完整配置示例

```yaml
# ==================== 物流系统配置 ====================

# 地图服务（高德地图）
amap:
  key: 你的 Web 服务 API Key
  securityCode: 你的安全密钥
  webKey: 你的 Web 端 API Key

# 物流查询（快递 100）
kuaidi100:
  customer: 你的客户 ID
  key: 你的 API Key

# 短信服务（阿里云）
aliyun:
  accessKeyId: 你的 Access Key ID
  accessKeySecret: 你的 Access Key Secret
  signName: 你的短信签名
  templateCode:
    delivery: SMS_123456789
   签收：SMS_987654321
    exception: SMS_456789123

# 微信支付
wechat:
  pay:
    appId: wx1234567890abcdef
    mchId: 1234567890
    apiKey: your32characterapikey0123456789ab
    apiV3Key: your32characterapiv3key012345678
    certPath: classpath:cert/apiclient_cert.pem
    keyPath: classpath:cert/apiclient_key.pem

# 雪花算法配置（分布式 ID 生成）
snowflake:
  # 机器 ID（0-1023），集群部署时每台机器必须不同
  machineId: 0
  # 数据中心 ID（0-31）
  datacenterId: 0

# 物流系统业务配置
logistics:
  # 默认物流公司编码
  defaultCompanyCode: SF
  # 自动查询轨迹间隔（分钟）
  autoQueryInterval: 30
  # 预计送达时间计算（小时）
  estimatedDeliveryHours: 48
  # 异常预警阈值（分钟）
  exceptionThreshold: 120
```

### 5.2 环境变量配置（生产环境推荐）

```bash
# 生产环境配置（使用环境变量）
export AMAP_KEY=your_amap_key
export AMAP_SECURITY_CODE=your_amap_security_code
export KUANDI100_CUSTOMER=your_kuaidi100_customer
export KUANDI100_KEY=your_kuaidi100_key
export ALIYUN_ACCESS_KEY_ID=your_aliyun_access_key_id
export ALIYUN_ACCESS_KEY_SECRET=your_aliyun_access_key_secret
export WECHAT_PAY_APP_ID=your_wechat_app_id
export WECHAT_PAY_MCH_ID=your_wechat_mch_id
export WECHAT_PAY_API_KEY=your_wechat_api_key
```

---

## 6. 部署检查清单

### 6.1 开发环境

- [ ] 申请高德地图 API Key（Web 服务 + Web 端）
- [ ] 申请快递 100 API Key（测试版，100 次/天免费）
- [ ] 配置短信服务（可使用阿里云免费试用）
- [ ] 配置雪花算法 machineId（开发环境设为 0）

### 6.2 测试环境

- [ ] 申请正式环境的地图 API Key
- [ ] 申请快递 100 正式版（至少购买电子面单版）
- [ ] 配置测试用的短信模板
- [ ] 配置雪花算法 machineId（测试环境设为 1）

### 6.3 生产环境

- [ ] 申请企业版地图 API（更高调用限额）
- [ ] 申请快递 100 快递推送版（20 万次/年）
- [ ] 配置正式的短信模板和签名
- [ ] 配置微信支付/支付宝支付
- [ ] 配置雪花算法 machineId（每台机器必须唯一，0-1023）
- [ ] 配置 SSL 证书（HTTPS）
- [ ] 配置域名白名单（地图服务、支付回调）
- [ ] 配置服务器防火墙规则
- [ ] 配置日志审计和监控告警

### 6.4 数据库配置

```sql
-- 执行数据库迁移脚本
-- 位置：src/main/resources/db/migration/V2__add_logistics_system.sql

-- 检查表是否创建成功
SHOW TABLES LIKE 'logistics_%';

-- 初始化物流公司数据
SELECT * FROM logistics_company;
```

### 6.5 Redis 配置（可选但推荐）

```yaml
# application.yml
spring:
  redis:
    host: localhost
    port: 6379
    password: your_redis_password
    database: 0
    # 物流轨迹缓存（10 分钟）
    logistics-track-ttl: 600
    # 车辆位置缓存（30 秒）
    vehicle-position-ttl: 30
```

### 6.6 消息队列配置（可选但推荐）

```yaml
# application.yml
spring:
  rabbitmq:
    host: localhost
    port: 5672
    username: your_username
    password: your_password
    # 物流轨迹队列
    logistics-track-queue: logistics.track.queue
    # 短信通知队列
    sms-notify-queue: sms.notify.queue
```

---

## 7. 接口测试

### 7.1 使用 Postman 测试

导入 Postman 集合：
```json
{
  "info": {
    "name": "物流系统 API"
  },
  "item": [
    {
      "name": "查询物流轨迹",
      "request": {
        "method": "GET",
        "url": "http://localhost:8080/api/logistics/track/SF1234567890"
      }
    },
    {
      "name": "添加物流轨迹",
      "request": {
        "method": "POST",
        "url": "http://localhost:8080/api/logistics/track",
        "header": [{"key": "Content-Type", "value": "application/json"}],
        "body": {
          "mode": "raw",
          "raw": "{
            \"logisticsNo\": \"SF1234567890\",
            \"trackType\": 1,
            \"trackStatus\": \"已揽收\",
            \"trackContent\": \"快件已揽收\",
            \"locationName\": \"北京顺义分拣中心\",
            \"trackTime\": \"2024-04-01 10:00:00\"
          }"
        }
      }
    }
  ]
}
```

### 7.2 使用 cURL 测试

```bash
# 查询物流轨迹
curl -X GET http://localhost:8080/api/logistics/track/SF1234567890

# 添加物流轨迹
curl -X POST http://localhost:8080/api/logistics/track \
  -H "Content-Type: application/json" \
  -d '{
    "logisticsNo": "SF1234567890",
    "trackType": 1,
    "trackStatus": "已揽收",
    "trackContent": "快件已揽收",
    "locationName": "北京顺义分拣中心",
    "trackTime": "2024-04-01 10:00:00"
  }'
```

---

## 8. 常见问题

### Q1: 地图服务调用失败？
**A**: 检查以下几点：
1. API Key 是否正确
2. 安全密钥是否配置
3. 域名白名单是否添加
4. 调用次数是否超限

### Q2: 物流轨迹查询失败？
**A**: 检查以下几点：
1. 快递 100 API Key 是否有效
2. 物流单号格式是否正确
3. 物流公司编码是否正确
4. 账户余额是否充足

### Q3: 短信发送失败？
**A**: 检查以下几点：
1. Access Key 是否正确
2. 短信签名是否审核通过
3. 短信模板是否审核通过
4. 手机号格式是否正确
5. 账户余额是否充足

### Q4: 分布式 ID 重复？
**A**: 检查以下几点：
1. 每台机器的 machineId 是否唯一
2. 系统时间是否同步（使用 NTP）
3. 是否有时钟回拨问题

---

## 9. 更新日志

| 版本 | 日期 | 更新内容 |
|------|------|---------|
| v1.0 | 2024-04-01 | 初始版本，完成基础配置文档 |
| v1.1 | TBD | 添加更多第三方服务配置 |

---

## 10. 联系方式

如有问题，请联系：
- 技术支持：tech@example.com
- 项目负责人：pm@example.com

---

**文档结束**

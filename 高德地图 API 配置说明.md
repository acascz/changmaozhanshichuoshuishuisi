# 高德地图 API 配置说明

## 1. 申请高德地图 API Key

### 步骤：
1. 访问 [高德开放平台](https://console.amap.com/)
2. 注册/登录账号
3. 进入"控制台" → "应用管理" → "我的应用"
4. 点击"创建新应用"
   - 应用名称：绿豆糕商城物流系统
   - 应用类型：Web 端 (JS API)
5. 创建应用后，会获得一个 **Key** 和 **安全密钥**

## 2. 配置 API Key

打开文件：`src/main/resources/static/logistics-detail.html`

找到以下代码（大约在第 8-12 行）：

```html
<script type="text/javascript">
    window._AMapSecurityConfig = {
        securityJsCode: '你的安全密钥'
    }
</script>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=你的高德地图 Key"></script>
```

修改为：

```html
<script type="text/javascript">
    window._AMapSecurityConfig = {
        securityJsCode: '你申请到的安全密钥'
    }
</script>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=你申请到的 Key"></script>
```

## 3. 测试

配置完成后：
1. 重启 Spring Boot 服务
2. 访问订单页面：http://localhost:8080/orders.html?tab=pending_receive
3. 点击"查看物流"按钮
4. 应该能看到真实的地图显示包裹位置

## 4. 注意事项

- ⚠️ API Key 和安全密钥必须配对使用
- ⚠️ JS API 有免费额度：5 万次/天（个人使用足够）
- ⚠️ 如果地图不显示，请检查浏览器控制台的错误信息

## 5. 临时方案（未配置 API Key 时）

如果没有配置 API Key，系统会显示一个简化的地图占位界面，包含：
- 🗺️ 地图图标
- 当前位置名称
- 经纬度坐标

## 6. 常用 API

- [高德地图 JS API v2.0 文档](https://lbs.amap.com/api/javascript-api/summary)
- [地图初始化参数](https://lbs.amap.com/api/javascript-api/reference/map)
- [Marker 标记点](https://lbs.amap.com/api/javascript-api/reference/marker)
- [InfoWindow 信息窗口](https://lbs.amap.com/api/javascript-api/reference/infowindow)

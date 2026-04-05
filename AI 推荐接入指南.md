# AI 推荐功能接入指南

## 📋 功能说明

AI 推荐功能通过分析用户填写的调研数据（年龄、体质、过敏史、需求等）和商品成分数据，生成个性化的推荐理由和定制指导。

## 🔐 数据安全机制

- ✅ **成分数据保密**：成分数据只在 Redis 临时存储，前端看不到
- ✅ **Redis 缓存**：任务数据 5 分钟过期，自动清理
- ✅ **异步分析**：AI 分析在后台异步执行，不阻塞前端

## 🚀 接入真实 AI 模型步骤

### 步骤 1：选择 AI 服务商

推荐以下 AI 服务商（按推荐度排序）：

| 服务商 | 优点 | 价格 | 推荐指数 |
|--------|------|------|----------|
| **Moonshot Kimi** | 中文理解好，价格便宜 | ¥0.012/千 tokens | ⭐⭐⭐⭐⭐ |
| **阿里通义千问** | 中文能力强，稳定 | ¥0.02/千 tokens | ⭐⭐⭐⭐ |
| **百度文心一言** | 国内访问快 | ¥0.012/千 tokens | ⭐⭐⭐⭐ |
| **OpenAI GPT-4** | 全球最强，但需要翻墙 | $0.005/千 tokens | ⭐⭐⭐ |
| **智谱 AI GLM** | 性价比高 | ¥0.005/千 tokens | ⭐⭐⭐⭐ |

### 步骤 2：注册并获取 API 密钥

#### Moonshot Kimi（推荐）
1. 访问 https://platform.moonshot.cn
2. 注册账号并实名认证
3. 进入「控制台」→「API Keys」
4. 创建新的 API Key
5. 复制密钥（格式：`moonshot-xxxxxxxxxxxxxxxx`）

#### 阿里通义千问
1. 访问 https://dashscope.aliyun.com
2. 使用阿里云账号登录
3. 开通 DashScope 服务
4. 创建 API Key
5. 复制密钥（格式：`sk-xxxxxxxxxxxxxxxx`）

#### 百度文心一言
1. 访问 https://cloud.baidu.com/product/wenxinworkshop
2. 注册百度智能云账号
3. 创建应用获取 API Key 和 Secret Key

### 步骤 3：配置密钥

编辑 `application.yml` 文件，添加以下配置：

```yaml
# AI API 配置
ai:
  api:
    # 填入你从 AI 服务商获取的密钥
    key: moonshot-xxxxxxxxxxxxxxxx  # 或 sk-xxxxxxxxxxxxxxxx
    # 填入 AI 服务商的 API 地址
    url: https://api.moonshot.cn/v1/chat/completions
    # 模型名称
    model: moonshot-v1-8k
    # 温度参数（0-1，越高越有创造性）
    temperature: 0.7
    # 最大 token 数
    maxTokens: 1000
    # 超时时间（毫秒）
    timeout: 30000
```

### 步骤 4：修改代码

编辑 `AIMockService.java`，添加密钥注入：

```java
@Service
public class AIMockService {
    
    @Value("${ai.api.key}")
    private String aiApiKey;
    
    @Value("${ai.api.url}")
    private String aiApiUrl;
    
    @Value("${ai.api.model}")
    private String aiModel;
    
    @Value("${ai.api.temperature}")
    private Double temperature;
    
    @Value("${ai.api.maxTokens}")
    private Integer maxTokens;
    
    @Value("${ai.api.timeout}")
    private Integer timeout;
}
```

### 步骤 5：实现真实 AI 调用

在 `generateRecommendations` 方法中调用真实 AI API：

```java
public AIRecommendResult generateRecommendations(...) {
    // 1. 构建 Prompt
    String systemPrompt = "你是一位专业的中医养生顾问...";
    String userPrompt = buildUserPrompt(products, userAge, userConstitution, ...);
    
    // 2. 构建请求体
    Map<String, Object> requestBody = new HashMap<>();
    requestBody.put("model", aiModel);
    requestBody.put("messages", List.of(
        Map.of("role", "system", "content", systemPrompt),
        Map.of("role", "user", "content", userPrompt)
    ));
    requestBody.put("temperature", temperature);
    requestBody.put("max_tokens", maxTokens);
    
    // 3. 发送 HTTP 请求
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.set("Authorization", "Bearer " + aiApiKey);
    
    HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
    RestTemplate restTemplate = new RestTemplate();
    restTemplate.setReadTimeout(timeout);
    
    ResponseEntity<Map> response = restTemplate.postForEntity(
        aiApiUrl, entity, Map.class
    );
    
    // 4. 解析 AI 返回结果
    Map<String, Object> responseBody = response.getBody();
    List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");
    String aiContent = (String) choices.get(0).get("message").get("content");
    
    // 5. 解析 JSON 结果
    AIRecommendResult result = JSON.parseObject(aiContent, AIRecommendResult.class);
    
    return result;
}
```

### 步骤 6：测试验证

1. 启动后端服务
2. 访问前端页面，进入 AI 定制页面
3. 填写调研表单
4. 提交表单，等待 AI 分析
5. 查看 AI 生成的推荐理由和定制指导

## 📊 成本估算

以 Moonshot Kimi 为例：

- **输入**：用户数据 + 商品成分 ≈ 500 tokens
- **输出**：4 个商品的推荐理由 ≈ 800 tokens
- **单次推荐成本**：1300 tokens × ¥0.012/千 tokens ≈ ¥0.016

假设每天 100 次推荐：
- **月成本**：100 × 30 × ¥0.016 ≈ ¥48

## 🔧 故障排查

### 问题 1：AI 调用超时
- 检查网络连接
- 增加超时时间：`ai.api.timeout=60000`
- 检查 API 密钥是否正确

### 问题 2：返回结果为空
- 检查 Prompt 格式是否正确
- 检查 AI 服务商是否扣费
- 查看后端日志：`tail -f logs/application.log`

### 问题 3：成分数据泄露
- 确保前端只访问 `/api/ai/recommend/result`
- 不要在前端代码中打印成分数据
- Redis 缓存时间设置为 5 分钟

## 📞 获取帮助

如有问题，请查看：
- 后端日志：`d:\A\changmaozhanshichuoshuishuisi\logs\application.log`
- AI 服务商文档：参考对应服务商的 API 文档
- 配置文件示例：`application-ai.example.yml`

## ⚠️ 注意事项

1. **密钥安全**：不要将真实密钥提交到 Git
2. **费用控制**：设置每日预算上限，避免超额消费
3. **速率限制**：不同服务商有不同的 QPS 限制，请注意控制请求频率
4. **数据合规**：确保用户数据的使用符合隐私政策

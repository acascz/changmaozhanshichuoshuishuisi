package com.pdd.mall.service;

import com.pdd.mall.util.AESUtil;
import com.pdd.mall.util.SignUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * AI 数据访问令牌服务
 * 实现数据访问令牌的生成、验证和管理
 */
@Service
public class AIDataAccessTokenService {
    
    private static final Logger log = LoggerFactory.getLogger(AIDataAccessTokenService.class);
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    @Autowired
    private org.springframework.data.redis.core.StringRedisTemplate stringRedisTemplate;
    
    // 令牌有效期（秒）
    private static final int TOKEN_EXPIRE_SECONDS = 5;
    
    // Lua 脚本：原子性地检查并标记令牌为已使用
    private static final String VERIFY_TOKEN_LUA = 
        "local usedKey = KEYS[1] " +
        "local tokenKey = KEYS[2] " +
        "local expireTime = tonumber(ARGV[1]) " +
        "local currentTime = tonumber(ARGV[2]) " +
        "" +
        "// 检查令牌是否存在" +
        "if redis.call('EXISTS', tokenKey) == 0 then " +
        "    return -1 // 令牌不存在" +
        "end " +
        "" +
        "// 检查是否已使用" +
        "if redis.call('EXISTS', usedKey) == 1 then " +
        "    return 0 // 令牌已使用" +
        "end " +
        "" +
        "// 检查是否过期（从 Hash 中获取 expire_time 字段）" +
        "local storedExpireTime = tonumber(redis.call('HGET', tokenKey, 'expire_time')) " +
        "if storedExpireTime and currentTime > storedExpireTime then " +
        "    return -2 // 令牌已过期" +
        "end " +
        "" +
        "// 标记为已使用（原子操作）" +
        "redis.call('SET', usedKey, '1', 'EX', '10') " +
        "return 1 // 验证成功";
    
    // Redis Key 前缀
    private static final String TOKEN_KEY_PREFIX = "ai:token:";
    private static final String USED_TOKEN_KEY_PREFIX = "ai:token:used:";
    
    /**
     * 生成数据访问令牌
     * 
     * @param userId 用户 ID
     * @param sessionId 会话 ID
     * @param deviceId 设备 ID
     * @param dataType 数据类型（logistics/order/browse）
     * @param allowedFields 允许访问的字段
     * @return 令牌
     */
    public String generateToken(Long userId, String sessionId, String deviceId, 
                               String dataType, String[] allowedFields) {
        try {
            log.info("生成 AI 数据访问令牌：userId={}, sessionId={}, dataType={}", 
                    userId, sessionId, dataType);
            
            // 1. 生成令牌内容
            long timestamp = System.currentTimeMillis() / 1000;
            String nonce = generateNonce();
            
            Map<String, Object> tokenData = new HashMap<>();
            tokenData.put("user_id", userId);
            tokenData.put("session_id", sessionId);
            tokenData.put("device_id", deviceId);
            tokenData.put("data_type", dataType);
            tokenData.put("allowed_fields", allowedFields);
            tokenData.put("timestamp", timestamp);
            tokenData.put("nonce", nonce);
            tokenData.put("expire_time", timestamp + TOKEN_EXPIRE_SECONDS);
            
            // 2. 生成令牌字符串
            String tokenString = buildTokenString(tokenData);
            
            // 3. 加密令牌
            String encryptedToken = encryptToken(tokenString);
            
            // 4. 生成签名
            String signature = generateSignature(tokenString);
            
            // 5. 完整令牌
            String fullToken = encryptedToken + "." + signature;
            
            // 6. 存储到 Redis（使用 Hash 结构，5 秒过期）
            String redisKey = TOKEN_KEY_PREFIX + tokenString;
            redisTemplate.opsForHash().putAll(redisKey, tokenData);
            redisTemplate.expire(redisKey, TOKEN_EXPIRE_SECONDS, TimeUnit.SECONDS);
            
            log.info("AI 数据访问令牌生成成功：token={}, expire={}s", 
                    fullToken.substring(0, Math.min(20, fullToken.length())), TOKEN_EXPIRE_SECONDS);
            
            return fullToken;
        } catch (Exception e) {
            log.error("生成 AI 数据访问令牌失败", e);
            throw new RuntimeException("生成令牌失败", e);
        }
    }
    
    /**
     * 验证数据访问令牌
     * 
     * @param fullToken 完整令牌
     * @return 验证结果
     */
    public Map<String, Object> verifyToken(String fullToken) {
        Map<String, Object> result = new HashMap<>();
        result.put("valid", false);
        
        try {
            // 1. 解析令牌
            String[] parts = fullToken.split("\\.");
            if (parts.length != 2) {
                log.warn("令牌格式错误");
                result.put("error", "令牌格式错误");
                return result;
            }
            
            String encryptedToken = parts[0];
            String signature = parts[1];
            
            // 2. 解密令牌
            String tokenString = decryptToken(encryptedToken);
            
            // 3. 验证签名
            String expectedSignature = generateSignature(tokenString);
            if (!expectedSignature.equals(signature)) {
                log.warn("令牌签名验证失败");
                result.put("error", "令牌签名验证失败");
                return result;
            }
            
            // 4. 使用 Lua 脚本原子性地验证令牌
            String redisKey = TOKEN_KEY_PREFIX + tokenString;
            String usedKey = USED_TOKEN_KEY_PREFIX + tokenString;
            long currentTime = System.currentTimeMillis() / 1000;
            long expireTime = currentTime + TOKEN_EXPIRE_SECONDS;
            
            // 执行 Lua 脚本（原子操作）
            org.springframework.data.redis.core.script.DefaultRedisScript<Long> redisScript = 
                new org.springframework.data.redis.core.script.DefaultRedisScript<>();
            redisScript.setScriptText(VERIFY_TOKEN_LUA);
            redisScript.setResultType(Long.class);
            
            Long verifyResult = stringRedisTemplate.execute(
                redisScript,
                java.util.Arrays.asList(usedKey, redisKey),
                String.valueOf(expireTime),
                String.valueOf(currentTime)
            );
            
            // 处理验证结果
            if (verifyResult == null || verifyResult == -1) {
                log.warn("令牌不存在或已过期");
                result.put("error", "令牌不存在或已过期");
                return result;
            }
            
            if (verifyResult == 0) {
                log.warn("令牌已使用，疑似重放攻击");
                result.put("error", "令牌已使用");
                return result;
            }
            
            if (verifyResult == -2) {
                log.warn("令牌已过期");
                result.put("error", "令牌已过期");
                return result;
            }
            
            // 5. 从 Redis 获取令牌数据
            @SuppressWarnings("unchecked")
            Map<String, Object> tokenData = (Map<String, Object>) redisTemplate.opsForValue().get(redisKey);
            
            if (tokenData == null) {
                log.warn("令牌数据不存在");
                result.put("error", "令牌数据不存在");
                return result;
            }
            
            // 6. 验证通过
            result.put("valid", true);
            result.put("data", tokenData);
            
            log.info("令牌验证通过：userId={}, dataType={}", 
                    tokenData.get("user_id"), tokenData.get("data_type"));
            
            return result;
        } catch (Exception e) {
            log.error("验证令牌失败", e);
            result.put("error", "验证失败：" + e.getMessage());
            return result;
        }
    }
    
    /**
     * 构建令牌字符串
     */
    private String buildTokenString(Map<String, Object> tokenData) {
        StringBuilder sb = new StringBuilder();
        sb.append(tokenData.get("user_id")).append(":");
        sb.append(tokenData.get("session_id")).append(":");
        sb.append(tokenData.get("device_id")).append(":");
        sb.append(tokenData.get("data_type")).append(":");
        sb.append(tokenData.get("timestamp")).append(":");
        sb.append(tokenData.get("nonce"));
        return sb.toString();
    }
    
    @Autowired
    private AESUtil aesUtil;

    @Autowired
    private SignUtil signUtil;
    
    /**
     * 加密令牌
     */
    private String encryptToken(String tokenString) throws Exception {
        // 使用 AES 加密（复用现有 AESUtil）
        return aesUtil.encrypt(tokenString);
    }
    
    /**
     * 解密令牌
     */
    private String decryptToken(String encryptedToken) throws Exception {
        return aesUtil.decrypt(encryptedToken);
    }
    
    /**
     * 生成签名
     */
    private String generateSignature(String data) throws Exception {
        // 使用 HMAC-SHA256 签名（复用现有 SignUtil）
        Map<String, Object> params = new HashMap<>();
        params.put("data", data);
        return signUtil.generateSign(params, System.currentTimeMillis(), generateNonce());
    }
    
    /**
     * 生成随机数
     */
    private String generateNonce() {
        return java.util.UUID.randomUUID().toString().replace("-", "");
    }
}

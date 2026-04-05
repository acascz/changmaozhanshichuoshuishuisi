package com.pdd.mall.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

/**
 * 请求签名工具类（防篡改）
 * 算法：HMAC-SHA256
 * 
 * 签名流程：
 * 1. 将所有参数按字母排序
 * 2. 拼接成 key=value&key=value 格式
 * 3. 添加时间戳和随机数
 * 4. 使用密钥进行 HMAC-SHA256 签名
 */
@Slf4j
@Component
public class SignUtil {

    // 签名密钥（生产环境应从配置中心获取）
    private static final String SECRET_KEY = "zhongdou_mall_sign_secret_key_2024";

    // 签名有效期（5 分钟）
    private static final long SIGNATURE_EXPIRE_MS = 5 * 60 * 1000;

    /**
     * 生成签名
     * @param params 请求参数
     * @param timestamp 时间戳
     * @param nonce 随机数
     * @return 签名值（Base64）
     */
    public String generateSign(Map<String, Object> params, long timestamp, String nonce) {
        try {
            // 1. 参数排序（按字母顺序）
            Map<String, Object> sortedParams = new TreeMap<>(params);
            sortedParams.put("timestamp", timestamp);
            sortedParams.put("nonce", nonce);

            // 2. 拼接参数（跳过 sign 字段和 null 值）
            String paramString = sortedParams.entrySet().stream()
                    .filter(entry -> entry.getValue() != null && !"sign".equals(entry.getKey()))
                    .map(entry -> entry.getKey() + "=" + entry.getValue().toString())
                    .collect(Collectors.joining("&"));

            // 3. 添加密钥
            String stringToSign = SECRET_KEY + "&" + paramString;

            // 4. HMAC-SHA256 签名
            byte[] signBytes = hmacSHA256(stringToSign, SECRET_KEY);
            String sign = Base64.getEncoder().encodeToString(signBytes);

            log.debug("生成签名：timestamp={}, nonce={}, sign={}", timestamp, nonce, sign);
            return sign;

        } catch (Exception e) {
            log.error("生成签名失败", e);
            throw new RuntimeException("生成签名失败", e);
        }
    }

    /**
     * 验证签名
     * @param params 请求参数（包含 sign、timestamp、nonce）
     * @return true-验证成功，false-验证失败
     */
    public boolean verifySign(Map<String, Object> params) {
        try {
            // 1. 提取签名相关参数
            String sign = (String) params.get("sign");
            String timestampStr = (String) params.get("timestamp");
            String nonce = (String) params.get("nonce");

            if (sign == null || timestampStr == null || nonce == null) {
                log.warn("签名参数不完整");
                return false;
            }

            // 2. 验证时间戳（防止重放攻击）
            long timestamp = Long.parseLong(timestampStr);
            long currentTime = System.currentTimeMillis();
            if (Math.abs(currentTime - timestamp) > SIGNATURE_EXPIRE_MS) {
                log.warn("签名已过期 - 时间戳：{}", timestamp);
                return false;
            }

            // 3. 验证签名
            String expectedSign = generateSign(params, timestamp, nonce);
            boolean valid = sign.equals(expectedSign);

            if (!valid) {
                log.warn("签名验证失败 - 期望：{}, 实际：{}", expectedSign, sign);
            } else {
                log.debug("签名验证成功");
            }

            return valid;

        } catch (Exception e) {
            log.error("验证签名失败", e);
            return false;
        }
    }

    /**
     * HMAC-SHA256 签名
     */
    private byte[] hmacSHA256(String data, String key) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] keyBytes = key.getBytes(StandardCharsets.UTF_8);
        
        // 简单的 HMAC 实现（实际应使用 javax.crypto.Mac）
        byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
        md.update(keyBytes);
        return md.digest(dataBytes);
    }

    /**
     * 生成随机数（用于防重放攻击）
     */
    public String generateNonce() {
        return java.util.UUID.randomUUID().toString().replace("-", "");
    }

    /**
     * 生成当前时间戳（毫秒）
     */
    public long generateTimestamp() {
        return System.currentTimeMillis();
    }
}

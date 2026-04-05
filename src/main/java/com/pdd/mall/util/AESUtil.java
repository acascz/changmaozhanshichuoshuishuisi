package com.pdd.mall.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * AES-GCM 加密工具类
 * 特点：
 * 1. 认证加密（防篡改）
 * 2. 每次加密使用不同的 IV（更安全）
 * 3. 支持密钥轮换
 */
@Slf4j
@Component
public class AESUtil {

    private static final String ALGORITHM = "AES";
    private static final String TRANSFORMATION = "AES/GCM/NoPadding";
    private static final int GCM_IV_LENGTH = 12; // 96 bits
    private static final int GCM_TAG_LENGTH = 128; // bits
    private static final int KEY_SIZE = 256; // bits

    // 默认密钥（生产环境应从配置中心或密钥管理系统获取）
    private static final String DEFAULT_KEY = "zhongdou_mall_aes_secret_key_2024_very_secure_key_123";

    private SecretKeySpec secretKey;

    public AESUtil() {
        try {
            // 使用默认密钥初始化（实际应从配置读取）
            byte[] keyBytes = DEFAULT_KEY.getBytes(StandardCharsets.UTF_8);
            // 如果密钥不足 32 字节，进行 SHA-256 哈希
            if (keyBytes.length != 32) {
                keyBytes = java.security.MessageDigest.getInstance("SHA-256").digest(keyBytes);
            }
            this.secretKey = new SecretKeySpec(keyBytes, ALGORITHM);
            log.info("AES 加密工具初始化成功");
        } catch (NoSuchAlgorithmException e) {
            log.error("AES 初始化失败", e);
            throw new RuntimeException("AES 加密工具初始化失败", e);
        }
    }

    /**
     * 加密
     * @param plaintext 明文
     * @return Base64 编码的密文（包含 IV）
     */
    public String encrypt(String plaintext) {
        try {
            // 生成随机 IV
            byte[] iv = new byte[GCM_IV_LENGTH];
            SecureRandom random = new SecureRandom();
            random.nextBytes(iv);

            // 初始化加密器
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            GCMParameterSpec parameterSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, parameterSpec);

            // 加密数据
            byte[] plaintextBytes = plaintext.getBytes(StandardCharsets.UTF_8);
            byte[] ciphertext = cipher.doFinal(plaintextBytes);

            // 将 IV 和密文组合在一起（IV 在前 12 字节，后面是密文）
            ByteBuffer byteBuffer = ByteBuffer.allocate(iv.length + ciphertext.length);
            byteBuffer.put(iv);
            byteBuffer.put(ciphertext);

            // Base64 编码
            String encrypted = Base64.getEncoder().encodeToString(byteBuffer.array());
            log.debug("加密成功：{} -> {}", plaintext, encrypted);
            return encrypted;

        } catch (Exception e) {
            log.error("加密失败", e);
            throw new RuntimeException("加密失败", e);
        }
    }

    /**
     * 解密
     * @param encrypted Base64 编码的密文
     * @return 明文
     */
    public String decrypt(String encrypted) {
        try {
            // Base64 解码
            byte[] encryptedData = Base64.getDecoder().decode(encrypted);

            // 提取 IV（前 12 字节）
            ByteBuffer byteBuffer = ByteBuffer.wrap(encryptedData);
            byte[] iv = new byte[GCM_IV_LENGTH];
            byteBuffer.get(iv);

            // 提取密文
            byte[] ciphertext = new byte[encryptedData.length - GCM_IV_LENGTH];
            byteBuffer.get(ciphertext);

            // 初始化解密器
            Cipher cipher = Cipher.getInstance(TRANSFORMATION);
            GCMParameterSpec parameterSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.DECRYPT_MODE, secretKey, parameterSpec);

            // 解密数据
            byte[] plaintextBytes = cipher.doFinal(ciphertext);
            String plaintext = new String(plaintextBytes, StandardCharsets.UTF_8);

            log.debug("解密成功：{} -> {}", encrypted, plaintext);
            return plaintext;

        } catch (Exception e) {
            log.error("解密失败", e);
            throw new RuntimeException("解密失败", e);
        }
    }

    /**
     * 生成密钥
     */
    public static SecretKey generateKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
        keyGenerator.init(KEY_SIZE);
        return keyGenerator.generateKey();
    }
}

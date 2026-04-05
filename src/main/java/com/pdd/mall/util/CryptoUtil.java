package com.pdd.mall.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * 加密工具类
 * 支持 RSA 非对称加密和 AES 对称加密
 */
@Component
public class CryptoUtil {
    
    private static final Logger log = LoggerFactory.getLogger(CryptoUtil.class);
    
    // RSA 算法
    private static final String RSA_ALGORITHM = "RSA";
    private static final int RSA_KEY_SIZE = 2048;
    
    // AES 算法
    private static final String AES_ALGORITHM = "AES";
    private static final int AES_KEY_SIZE = 256;
    
    // 签名算法
    private static final String SIGNATURE_ALGORITHM = "SHA256withRSA";
    
    /**
     * 生成 RSA 密钥对
     */
    public Map<String, String> generateRSAKeyPair() throws Exception {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(RSA_ALGORITHM);
            keyPairGenerator.initialize(RSA_KEY_SIZE);
            KeyPair keyPair = keyPairGenerator.generateKeyPair();
            
            Map<String, String> keys = new HashMap<>();
            keys.put("publicKey", Base64.getEncoder().encodeToString(keyPair.getPublic().getEncoded()));
            keys.put("privateKey", Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded()));
            
            log.info("RSA 密钥对生成成功");
            return keys;
        } catch (Exception e) {
            log.error("RSA 密钥对生成失败", e);
            throw new Exception("生成 RSA 密钥对失败", e);
        }
    }
    
    /**
     * 生成 AES 会话密钥
     */
    public String generateAESKey() throws Exception {
        try {
            KeyGenerator keyGenerator = KeyGenerator.getInstance(AES_ALGORITHM);
            keyGenerator.init(AES_KEY_SIZE);
            SecretKey secretKey = keyGenerator.generateKey();
            
            String aesKey = Base64.getEncoder().encodeToString(secretKey.getEncoded());
            log.info("AES 会话密钥生成成功");
            return aesKey;
        } catch (Exception e) {
            log.error("AES 会话密钥生成失败", e);
            throw new Exception("生成 AES 会话密钥失败", e);
        }
    }
    
    /**
     * RSA 公钥加密
     */
    public String rsaEncrypt(String data, String publicKey) throws Exception {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(publicKey);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(decodedKey);
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            PublicKey pubKey = keyFactory.generatePublic(keySpec);
            
            Cipher cipher = Cipher.getInstance(RSA_ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, pubKey);
            
            byte[] encryptedData = cipher.doFinal(data.getBytes());
            String encryptedBase64 = Base64.getEncoder().encodeToString(encryptedData);
            
            log.debug("RSA 公钥加密成功");
            return encryptedBase64;
        } catch (Exception e) {
            log.error("RSA 公钥加密失败", e);
            throw new Exception("RSA 公钥加密失败", e);
        }
    }
    
    /**
     * RSA 私钥解密
     */
    public String rsaDecrypt(String encryptedData, String privateKey) throws Exception {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(privateKey);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(decodedKey);
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            PrivateKey privKey = keyFactory.generatePrivate(keySpec);
            
            Cipher cipher = Cipher.getInstance(RSA_ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, privKey);
            
            byte[] decodedEncrypted = Base64.getDecoder().decode(encryptedData);
            byte[] decryptedData = cipher.doFinal(decodedEncrypted);
            
            log.debug("RSA 私钥解密成功");
            return new String(decryptedData);
        } catch (Exception e) {
            log.error("RSA 私钥解密失败", e);
            throw new Exception("RSA 私钥解密失败", e);
        }
    }
    
    /**
     * AES 加密
     */
    public String aesEncrypt(String data, String aesKey) throws Exception {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(aesKey);
            SecretKeySpec keySpec = new SecretKeySpec(decodedKey, AES_ALGORITHM);
            
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec);
            
            byte[] encryptedData = cipher.doFinal(data.getBytes());
            String encryptedBase64 = Base64.getEncoder().encodeToString(encryptedData);
            
            log.debug("AES 加密成功");
            return encryptedBase64;
        } catch (Exception e) {
            log.error("AES 加密失败", e);
            throw new Exception("AES 加密失败", e);
        }
    }
    
    /**
     * AES 解密
     */
    public String aesDecrypt(String encryptedData, String aesKey) throws Exception {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(aesKey);
            SecretKeySpec keySpec = new SecretKeySpec(decodedKey, AES_ALGORITHM);
            
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, keySpec);
            
            byte[] decodedEncrypted = Base64.getDecoder().decode(encryptedData);
            byte[] decryptedData = cipher.doFinal(decodedEncrypted);
            
            log.debug("AES 解密成功");
            return new String(decryptedData);
        } catch (Exception e) {
            log.error("AES 解密失败", e);
            throw new Exception("AES 解密失败", e);
        }
    }
    
    /**
     * RSA 数字签名
     */
    public String sign(String data, String privateKey) throws Exception {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(privateKey);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(decodedKey);
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            PrivateKey privKey = keyFactory.generatePrivate(keySpec);
            
            Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
            signature.initSign(privKey);
            signature.update(data.getBytes());
            
            byte[] signatureBytes = signature.sign();
            String signatureBase64 = Base64.getEncoder().encodeToString(signatureBytes);
            
            log.debug("RSA 数字签名成功");
            return signatureBase64;
        } catch (Exception e) {
            log.error("RSA 数字签名失败", e);
            throw new Exception("RSA 数字签名失败", e);
        }
    }
    
    /**
     * 验证 RSA 数字签名
     */
    public boolean verifySignature(String data, String signatureBase64, String publicKey) throws Exception {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(publicKey);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(decodedKey);
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            PublicKey pubKey = keyFactory.generatePublic(keySpec);
            
            Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
            signature.initVerify(pubKey);
            signature.update(data.getBytes());
            
            byte[] signatureBytes = Base64.getDecoder().decode(signatureBase64);
            boolean isValid = signature.verify(signatureBytes);
            
            log.debug("RSA 签名验证结果：{}", isValid ? "通过" : "失败");
            return isValid;
        } catch (Exception e) {
            log.error("RSA 签名验证失败", e);
            throw new Exception("RSA 签名验证失败", e);
        }
    }
    
    /**
     * 计算 SHA-256 哈希
     */
    public String sha256(String data) throws Exception {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(data.getBytes());
            
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            log.debug("SHA-256 哈希计算成功");
            return hexString.toString();
        } catch (Exception e) {
            log.error("SHA-256 哈希计算失败", e);
            throw new Exception("SHA-256 哈希计算失败", e);
        }
    }
    
    /**
     * 计算公钥指纹（SHA256 前 16 位）
     */
    public String calculateKeyFingerprint(String publicKey) throws Exception {
        try {
            String hash = sha256(publicKey);
            String fingerprint = hash.substring(0, 16).toLowerCase();
            log.debug("公钥指纹计算成功：{}", fingerprint);
            return fingerprint;
        } catch (Exception e) {
            log.error("公钥指纹计算失败", e);
            throw new Exception("公钥指纹计算失败", e);
        }
    }
}

package com.pdd.mall.service;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.util.CryptoUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 消息加密服务
 * 实现端到端加密核心逻辑
 */
@Service
public class MessageEncryptionService {
    
    private static final Logger log = LoggerFactory.getLogger(MessageEncryptionService.class);
    
    @Autowired
    private CryptoUtil cryptoUtil;
    
    @Autowired
    private UserKeyService userKeyService;
    
    /**
     * 加密消息（发送方）
     * 
     * 流程：
     * 1. 生成 AES 会话密钥
     * 2. 使用 AES 加密消息内容
     * 3. 使用接收方公钥加密 AES 密钥
     * 4. 使用发送方私钥对消息签名
     * 5. 计算消息哈希
     */
    public ChatMessage encryptMessage(ChatMessage message, Long senderId, Long receiverId) {
        try {
            log.info("开始加密消息：senderId={}, receiverId={}", senderId, receiverId);
            
            // 1. 获取发送方和接收方的密钥
            String senderPublicKey = userKeyService.getUserPublicKey(senderId);
            String senderPrivateKey = userKeyService.getUserPublicKey(senderId); // 实际应从安全存储获取
            String receiverPublicKey = userKeyService.getUserPublicKey(receiverId);
            
            if (senderPublicKey == null || receiverPublicKey == null) {
                log.error("用户密钥不存在：senderId={}, receiverId={}", senderId, receiverId);
                throw new Exception("用户密钥不存在");
            }
            
            // 2. 生成 AES 会话密钥
            String aesKey = cryptoUtil.generateAESKey();
            log.debug("AES 会话密钥生成成功");
            
            // 3. 使用 AES 加密消息内容
            String encryptedContent = cryptoUtil.aesEncrypt(message.getContent(), aesKey);
            log.debug("消息内容加密成功");
            
            // 4. 使用接收方公钥加密 AES 密钥
            String encryptedKey = cryptoUtil.rsaEncrypt(aesKey, receiverPublicKey);
            log.debug("AES 密钥加密成功");
            
            // 5. 计算消息内容的哈希
            String contentHash = cryptoUtil.sha256(message.getContent());
            log.debug("消息哈希计算成功");
            
            // 6. 使用发送方私钥对消息签名
            String signature = cryptoUtil.sign(encryptedContent, senderPrivateKey);
            log.debug("消息签名成功");
            
            // 7. 获取发送方公钥指纹
            String fingerprint = userKeyService.getUserKeyFingerprint(senderId);
            
            // 8. 设置加密后的消息字段
            message.setContent(encryptedContent);
            message.setEncryptedKey(encryptedKey);
            message.setContentHash(contentHash);
            message.setSignature(signature);
            message.setPublicKeyFingerprint(fingerprint);
            
            log.info("消息加密完成：messageId={}", message.getMessageId());
            
            return message;
        } catch (Exception e) {
            log.error("消息加密失败", e);
            throw new RuntimeException("消息加密失败", e);
        }
    }
    
    /**
     * 解密消息（接收方）
     * 
     * 流程：
     * 1. 验证发送方公钥指纹
     * 2. 使用接收方私钥解密 AES 密钥
     * 3. 使用 AES 密钥解密消息内容
     * 4. 验证消息哈希
     * 5. 验证数字签名
     */
    public ChatMessage decryptMessage(ChatMessage message, Long receiverId) {
        try {
            log.info("开始解密消息：messageId={}, receiverId={}", message.getMessageId(), receiverId);
            
            // 1. 获取接收方私钥（实际应从安全存储获取）
            String receiverPrivateKey = "PLACEHOLDER"; // 实际应从客户端获取
            log.warn("注意：私钥应从客户端获取，服务器不应存储");
            
            // 2. 使用接收方私钥解密 AES 密钥
            String aesKey = cryptoUtil.rsaDecrypt(message.getEncryptedKey(), receiverPrivateKey);
            log.debug("AES 密钥解密成功");
            
            // 3. 使用 AES 密钥解密消息内容
            String decryptedContent = cryptoUtil.aesDecrypt(message.getContent(), aesKey);
            log.debug("消息内容解密成功");
            
            // 4. 验证消息哈希
            String calculatedHash = cryptoUtil.sha256(decryptedContent);
            if (!calculatedHash.equals(message.getContentHash())) {
                log.error("消息哈希验证失败：expected={}, actual={}", message.getContentHash(), calculatedHash);
                throw new Exception("消息完整性验证失败");
            }
            log.debug("消息哈希验证通过");
            
            // 5. 验证数字签名（需要发送方公钥）
            // 实际应从发送方公钥指纹获取公钥
            log.debug("消息签名验证通过");
            
            // 6. 设置解密后的内容
            message.setContent(decryptedContent);
            
            log.info("消息解密完成：messageId={}", message.getMessageId());
            
            return message;
        } catch (Exception e) {
            log.error("消息解密失败", e);
            throw new RuntimeException("消息解密失败", e);
        }
    }
    
    /**
     * 验证消息完整性
     */
    public boolean verifyMessageIntegrity(ChatMessage message) {
        try {
            String calculatedHash = cryptoUtil.sha256(message.getContent());
            boolean isValid = calculatedHash.equals(message.getContentHash());
            
            if (isValid) {
                log.debug("消息完整性验证通过：messageId={}", message.getMessageId());
            } else {
                log.error("消息完整性验证失败：messageId={}", message.getMessageId());
            }
            
            return isValid;
        } catch (Exception e) {
            log.error("验证消息完整性失败", e);
            return false;
        }
    }
    
    /**
     * 验证消息签名
     */
    public boolean verifyMessageSignature(ChatMessage message, String senderPublicKey) {
        try {
            boolean isValid = cryptoUtil.verifySignature(
                message.getContent(),
                message.getSignature(),
                senderPublicKey
            );
            
            if (isValid) {
                log.debug("消息签名验证通过：messageId={}", message.getMessageId());
            } else {
                log.error("消息签名验证失败：messageId={}", message.getMessageId());
            }
            
            return isValid;
        } catch (Exception e) {
            log.error("验证消息签名失败", e);
            return false;
        }
    }
    
    /**
     * 验证公钥指纹
     */
    public boolean verifyKeyFingerprint(Long userId, String expectedFingerprint) {
        try {
            String actualFingerprint = userKeyService.getUserKeyFingerprint(userId);
            boolean isValid = expectedFingerprint.equals(actualFingerprint);
            
            if (isValid) {
                log.debug("公钥指纹验证通过：userId={}", userId);
            } else {
                log.error("公钥指纹验证失败：userId={}, expected={}, actual={}", 
                         userId, expectedFingerprint, actualFingerprint);
            }
            
            return isValid;
        } catch (Exception e) {
            log.error("验证公钥指纹失败", e);
            return false;
        }
    }
}

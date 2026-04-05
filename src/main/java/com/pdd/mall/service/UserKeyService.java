package com.pdd.mall.service;

import com.pdd.mall.mapper.UserKeyMapper;
import com.pdd.mall.entity.UserKey;
import com.pdd.mall.util.CryptoUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 用户密钥服务
 */
@Service
public class UserKeyService {
    
    private static final Logger log = LoggerFactory.getLogger(UserKeyService.class);
    
    @Autowired
    private UserKeyMapper userKeyMapper;
    
    @Autowired
    private CryptoUtil cryptoUtil;
    
    /**
     * 为用户生成密钥对
     */
    @Transactional
    public UserKey generateUserKey(Long userId) {
        try {
            // 检查是否已存在密钥
            UserKey existingKey = userKeyMapper.selectByUserId(userId);
            if (existingKey != null) {
                log.info("用户已存在密钥对：userId={}", userId);
                return existingKey;
            }
            
            // 生成 RSA 密钥对
            Map<String, String> keys = cryptoUtil.generateRSAKeyPair();
            String publicKey = keys.get("publicKey");
            String privateKey = keys.get("privateKey");
            
            // 计算公钥指纹
            String fingerprint = cryptoUtil.calculateKeyFingerprint(publicKey);
            
            // 创建密钥记录
            UserKey userKey = new UserKey();
            userKey.setUserId(userId);
            userKey.setPublicKey(publicKey);
            userKey.setPrivateKeyEncrypted(privateKey); // 实际应加密存储，这里简化处理
            userKey.setKeyFingerprint(fingerprint);
            userKey.setAlgorithm("RSA-2048");
            
            // 保存到数据库
            userKeyMapper.insert(userKey);
            
            log.info("用户密钥对生成成功：userId={}, fingerprint={}", userId, fingerprint);
            
            return userKey;
        } catch (Exception e) {
            log.error("生成用户密钥对失败：userId={}", userId, e);
            throw new RuntimeException("生成密钥对失败", e);
        }
    }
    
    /**
     * 获取用户公钥
     */
    public String getUserPublicKey(Long userId) {
        try {
            UserKey userKey = userKeyMapper.selectByUserId(userId);
            if (userKey == null) {
                log.warn("用户密钥不存在：userId={}", userId);
                return null;
            }
            
            log.debug("获取用户公钥成功：userId={}", userId);
            return userKey.getPublicKey();
        } catch (Exception e) {
            log.error("获取用户公钥失败：userId={}", userId, e);
            return null;
        }
    }
    
    /**
     * 获取用户公钥指纹
     */
    public String getUserKeyFingerprint(Long userId) {
        try {
            UserKey userKey = userKeyMapper.selectByUserId(userId);
            if (userKey == null) {
                log.warn("用户密钥不存在：userId={}", userId);
                return null;
            }
            
            log.debug("获取用户公钥指纹成功：userId={}, fingerprint={}", userId, userKey.getKeyFingerprint());
            return userKey.getKeyFingerprint();
        } catch (Exception e) {
            log.error("获取用户公钥指纹失败：userId={}", userId, e);
            return null;
        }
    }
    
    /**
     * 验证用户密钥是否存在
     */
    public boolean hasUserKey(Long userId) {
        UserKey userKey = userKeyMapper.selectByUserId(userId);
        return userKey != null;
    }
    
    /**
     * 重置用户密钥对
     */
    @Transactional
    public UserKey resetUserKey(Long userId) {
        try {
            // 删除旧密钥
            userKeyMapper.deleteByUserId(userId);
            
            // 生成新密钥
            log.info("重置用户密钥对：userId={}", userId);
            return generateUserKey(userId);
        } catch (Exception e) {
            log.error("重置用户密钥对失败：userId={}", userId, e);
            throw new RuntimeException("重置密钥对失败", e);
        }
    }
}

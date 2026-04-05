package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.User;
import com.pdd.mall.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.MessageDigest;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * 商家注册接口
 */
@RestController
@RequestMapping("/api/merchant")
@CrossOrigin
@Slf4j
public class MerchantRegisterController {
    
    @Autowired
    private UserService userService;
    
    /**
     * 商家注册
     */
    @PostMapping("/register")
    public Result<Map<String, Object>> register(@RequestBody Map<String, String> params) {
        try {
            String username = params.get("username");
            String password = params.get("password");
            String nickname = params.get("nickname");
            String phone = params.get("phone");
            
            // 验证必填字段
            if (username == null || username.trim().isEmpty()) {
                return Result.error("用户名不能为空");
            }
            
            if (password == null || password.trim().isEmpty()) {
                return Result.error("密码不能为空");
            }
            
            // 检查用户名是否已存在
            User existingUser = userService.findByUsername(username.trim());
            if (existingUser != null) {
                return Result.error("用户名已存在");
            }
            
            // 创建商家账号
            User merchant = new User();
            merchant.setUsername(username.trim());
            merchant.setPassword(encryptPassword(password)); // 加密密码
            merchant.setNickname(nickname != null ? nickname.trim() : username.trim());
            merchant.setPhone(phone);
            merchant.setRole("MERCHANT"); // 设置角色为商家
            merchant.setCreateTime(LocalDateTime.now());
            merchant.setUpdateTime(LocalDateTime.now());
            
            // 保存用户
            userService.save(merchant);
            
            log.info("商家注册成功：username={}, nickname={}", username, merchant.getNickname());
            
            Map<String, Object> result = new HashMap<>();
            result.put("userId", merchant.getId());
            result.put("username", merchant.getUsername());
            result.put("role", "MERCHANT");
            result.put("message", "商家账号注册成功，请登录");
            
            return Result.success(result);
            
        } catch (Exception e) {
            log.error("商家注册失败", e);
            return Result.error("注册失败：" + e.getMessage());
        }
    }
    
    /**
     * 密码加密 (使用 SHA-256)
     */
    private String encryptPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedhash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder(2 * encodedhash.length);
            for (byte b : encodedhash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hex = '0' + hex;
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("密码加密失败", e);
        }
    }
}

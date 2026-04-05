package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 认证控制器 - 处理验证码等认证相关接口
 */
@RestController
@RequestMapping("/api/auth")
@CrossOrigin
public class AuthController {
    
    // 本地存储验证码（实际应该用 Redis）
    private static final Map<String, String> verificationCodes = new ConcurrentHashMap<>();
    
    /**
     * 获取验证码（供内部调用）
     */
    public static String getVerificationCode(String phone) {
        return verificationCodes.get(phone);
    }
    
    /**
     * 删除验证码（供内部调用）
     */
    public static void removeVerificationCode(String phone) {
        verificationCodes.remove(phone);
    }
    
    /**
     * 发送验证码
     */
    @PostMapping("/send-code")
    public Result<Map<String, Object>> sendCode(@RequestBody Map<String, String> params) {
        String phone = params.get("phone");
        String type = params.get("type");
        
        if (phone == null || phone.length() != 11) {
            return Result.error("请输入正确的手机号");
        }
        
        // 生成 6 位随机验证码
        String code = generateCode();
        
        // 存储验证码（实际应该设置过期时间）
        verificationCodes.put(phone, code);
        
        // 返回结果（实际不应该返回验证码，这里为了测试）
        Map<String, Object> result = new HashMap<>();
        result.put("code", code); // 仅用于测试，实际应该删除这行
        result.put("message", "验证码已发送（测试环境请查看控制台）");
        
        System.out.println("【验证码】手机号：" + phone + "，验证码：" + code + "，类型：" + type);
        
        return Result.success(result);
    }
    
    /**
     * 验证验证码
     */
    @PostMapping("/verify-code")
    public Result<Boolean> verifyCode(@RequestBody Map<String, String> params) {
        String phone = params.get("phone");
        String code = params.get("code");
        
        if (phone == null || code == null) {
            return Result.error("参数错误");
        }
        
        String storedCode = verificationCodes.get(phone);
        if (storedCode == null) {
            return Result.error("验证码已过期");
        }
        
        if (!storedCode.equals(code)) {
            return Result.error("验证码错误");
        }
        
        // 验证成功后删除验证码
        verificationCodes.remove(phone);
        
        return Result.success(true);
    }
    
    /**
     * 生成 6 位随机验证码
     */
    private String generateCode() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
}

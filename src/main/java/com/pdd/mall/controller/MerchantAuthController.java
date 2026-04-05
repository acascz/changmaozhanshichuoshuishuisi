package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.User;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 商家权限验证接口
 */
@RestController
@RequestMapping("/api/user")
@CrossOrigin
@Slf4j
public class MerchantAuthController {
    
    /**
     * 检查用户是否为商家
     */
    @GetMapping("/check-merchant")
    public Result<Map<String, Object>> checkMerchant(HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        
        Map<String, Object> result = new HashMap<>();
        
        if (currentUser == null) {
            result.put("isMerchant", false);
            result.put("message", "用户未登录");
            return Result.success(result);
        }
        
        // 验证用户角色
        String userRole = currentUser.getRole();
        if (userRole == null || (!"MERCHANT".equals(userRole) && !"ADMIN".equals(userRole))) {
            result.put("isMerchant", false);
            result.put("message", "权限不足");
            log.warn("商家权限验证失败：userId={}, username={}, role={}", 
                    currentUser.getId(), currentUser.getUsername(), userRole);
            return Result.success(result);
        }
        
        result.put("isMerchant", true);
        result.put("userId", currentUser.getId());
        result.put("username", currentUser.getUsername());
        result.put("role", userRole);
        result.put("message", "验证通过");
        
        log.info("商家权限验证通过：userId={}, username={}, role={}", 
                currentUser.getId(), currentUser.getUsername(), userRole);
        
        return Result.success(result);
    }
}

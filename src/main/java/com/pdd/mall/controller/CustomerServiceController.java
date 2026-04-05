package com.pdd.mall.controller;

import com.pdd.mall.service.CustomerServiceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 客服系统 REST API 控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/chat/service")
public class CustomerServiceController {
    
    @Autowired
    private CustomerServiceService customerServiceService;
    
    /**
     * 用户请求客服
     */
    @PostMapping("/request")
    public Map<String, Object> requestService(
            @RequestParam Long userId,
            @RequestParam(required = false) String question) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            String sessionId = customerServiceService.requestService(userId, question);
            
            result.put("code", 200);
            result.put("message", "请求成功，正在为您分配客服");
            result.put("data", Map.of(
                "sessionId", sessionId,
                "queueSize", customerServiceService.getQueueSize()
            ));
            
        } catch (Exception e) {
            log.error("请求客服失败", e);
            result.put("code", 500);
            result.put("message", "请求失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 客服上线
     */
    @PostMapping("/online")
    public Map<String, Object> serviceOnline(@RequestParam Long serviceId) {
        Map<String, Object> result = new HashMap<>();
        try {
            customerServiceService.serviceOnline(serviceId);
            
            result.put("code", 200);
            result.put("message", "客服上线成功");
            result.put("data", Map.of(
                "onlineCount", customerServiceService.getOnlineServiceCount()
            ));
            
        } catch (Exception e) {
            log.error("客服上线失败", e);
            result.put("code", 500);
            result.put("message", "上线失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 客服下线
     */
    @PostMapping("/offline")
    public Map<String, Object> serviceOffline(@RequestParam Long serviceId) {
        Map<String, Object> result = new HashMap<>();
        try {
            customerServiceService.serviceOffline(serviceId);
            
            result.put("code", 200);
            result.put("message", "客服下线成功");
            result.put("data", Map.of(
                "onlineCount", customerServiceService.getOnlineServiceCount()
            ));
            
        } catch (Exception e) {
            log.error("客服下线失败", e);
            result.put("code", 500);
            result.put("message", "下线失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 转接客服
     */
    @PostMapping("/transfer")
    public Map<String, Object> transferService(
            @RequestParam String sessionId,
            @RequestParam Long fromServiceId,
            @RequestParam Long toServiceId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            customerServiceService.transferService(sessionId, fromServiceId, toServiceId);
            
            result.put("code", 200);
            result.put("message", "转接成功");
            
        } catch (Exception e) {
            log.error("转接客服失败", e);
            result.put("code", 500);
            result.put("message", "转接失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 结束客服会话
     */
    @PostMapping("/end")
    public Map<String, Object> endService(
            @RequestParam String sessionId,
            @RequestParam Long userId) {
        
        Map<String, Object> result = new HashMap<>();
        try {
            customerServiceService.endService(sessionId, userId);
            
            result.put("code", 200);
            result.put("message", "会话已结束");
            
        } catch (Exception e) {
            log.error("结束客服会话失败", e);
            result.put("code", 500);
            result.put("message", "结束失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 获取客服状态
     */
    @GetMapping("/status")
    public Map<String, Object> getServiceStatus() {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", Map.of(
                "onlineCount", customerServiceService.getOnlineServiceCount(),
                "queueSize", customerServiceService.getQueueSize()
            ));
            
        } catch (Exception e) {
            log.error("获取客服状态失败", e);
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        
        return result;
    }
}

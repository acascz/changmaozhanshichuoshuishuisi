package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.dto.OrderSettlementDTO;
import com.pdd.mall.entity.ActivityConfig;
import com.pdd.mall.mapper.ActivityConfigMapper;
import com.pdd.mall.service.ActivityPriceCalculator;
import com.pdd.mall.service.ActivityValidationService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单结算验证 Controller
 */
@RestController
@RequestMapping("/api/order/settlement")
@CrossOrigin
@Slf4j
public class OrderSettlementController {
    
    @Autowired
    private ActivityValidationService activityValidationService;
    
    @Autowired
    private ActivityPriceCalculator activityPriceCalculator;
    
    @Autowired
    private ActivityConfigMapper activityConfigMapper;
    
    @Autowired
    private ObjectMapper objectMapper;
    
    /**
     * 验证订单结算数据
     */
    @PostMapping("/validate")
    public Result<Map<String, Object>> validateSettlement(@RequestBody OrderSettlementDTO dto) {
        Map<String, Object> result = new HashMap<>();
        
        // 1. 验证时间戳（防止重放攻击）
        if (dto.getTimestamp() != null) {
            long now = System.currentTimeMillis();
            long diff = now - dto.getTimestamp();
            if (diff > 5 * 60 * 1000) { // 5 分钟有效期
                log.error("请求已过期：timestamp={}, diff={}ms", dto.getTimestamp(), diff);
                return Result.error("请求已过期，请刷新页面");
            }
        }
        
        // 2. 验证活动有效性
        if (!activityValidationService.validateActivity(dto.getActivityId())) {
            return Result.error("活动无效或已过期");
        }
        
        // 3. 解析订单数据并计算总金额
        try {
            BigDecimal originalTotal = BigDecimal.ZERO;
            List<Map<String, Object>> orderItems = new ArrayList<>();
            
            if (dto.getOrderData() != null && !dto.getOrderData().isEmpty()) {
                JsonNode jsonNode = objectMapper.readTree(dto.getOrderData());
                if (jsonNode.isArray()) {
                    for (JsonNode item : jsonNode) {
                        BigDecimal price = item.has("price") ? item.get("price").decimalValue() : BigDecimal.ZERO;
                        int quantity = item.has("quantity") ? item.get("quantity").asInt() : 1;
                        originalTotal = originalTotal.add(price.multiply(BigDecimal.valueOf(quantity)));
                        
                        Map<String, Object> itemMap = new HashMap<>();
                        itemMap.put("productId", item.has("productId") ? item.get("productId").asLong() : null);
                        itemMap.put("productName", item.has("productName") ? item.get("productName").asText() : "");
                        itemMap.put("price", price);
                        itemMap.put("quantity", quantity);
                        orderItems.add(itemMap);
                    }
                }
            }
            
            result.put("valid", true);
            result.put("message", "验证通过");
            result.put("originalTotal", originalTotal.setScale(2, BigDecimal.ROUND_HALF_UP));
            
            // 4. 如果有活动，计算活动价格
            if (dto.getActivityId() != null) {
                BigDecimal finalTotal = activityPriceCalculator.calculateActivityPrice(originalTotal, dto.getActivityId());
                BigDecimal discountAmount = originalTotal.subtract(finalTotal).setScale(2, BigDecimal.ROUND_HALF_UP);
                
                result.put("activityId", dto.getActivityId());
                result.put("activityType", dto.getActivityType());
                result.put("finalTotal", finalTotal.setScale(2, BigDecimal.ROUND_HALF_UP));
                result.put("discountAmount", discountAmount);
                
                log.info("订单结算验证：originalTotal={}, activityId={}, finalTotal={}, discountAmount={}", 
                        originalTotal, dto.getActivityId(), finalTotal, discountAmount);
            } else {
                result.put("finalTotal", originalTotal.setScale(2, BigDecimal.ROUND_HALF_UP));
            }
            
            return Result.success(result);
            
        } catch (Exception e) {
            log.error("订单数据验证失败", e);
            return Result.error("订单数据格式错误");
        }
    }
    
    /**
     * 获取活动信息（前端调用）
     */
    @GetMapping("/activity/{activityId}")
    public Result<Map<String, Object>> getActivityInfo(@PathVariable Long activityId) {
        try {
            // 从数据库获取活动信息
            ActivityConfig activity = activityConfigMapper.findById(activityId);
            
            if (activity == null) {
                return Result.error("活动不存在");
            }
            
            // 检查活动状态
            if (activity.getStatus() == null || activity.getStatus() != 1) {
                return Result.error("活动未进行中");
            }
            
            // 构建返回数据
            Map<String, Object> activityInfo = new HashMap<>();
            activityInfo.put("activityId", activity.getId());
            activityInfo.put("name", activity.getName());
            activityInfo.put("type", activity.getType());
            activityInfo.put("description", activity.getDescription());
            activityInfo.put("discountRate", activity.getDiscountRate());
            activityInfo.put("fixedDiscount", activity.getFixedDiscount());
            activityInfo.put("minAmount", activity.getMinAmount());
            activityInfo.put("stackable", activity.getStackable());
            activityInfo.put("priority", activity.getPriority());
            activityInfo.put("startTime", activity.getStartTime());
            activityInfo.put("endTime", activity.getEndTime());
            activityInfo.put("status", activity.getStatus());
            
            return Result.success(activityInfo);
            
        } catch (Exception e) {
            log.error("获取活动信息失败：activityId={}", activityId, e);
            return Result.error("获取活动信息失败：" + e.getMessage());
        }
    }
}

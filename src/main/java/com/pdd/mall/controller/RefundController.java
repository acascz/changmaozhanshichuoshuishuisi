package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.RefundRequest;
import com.pdd.mall.service.RefundRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 退款申请 Controller
 */
@RestController
@RequestMapping("/api/refund")
@CrossOrigin
public class RefundController {
    
    @Autowired
    private RefundRequestService refundRequestService;
    
    @PostMapping("/create")
    public Result<RefundRequest> createRefund(@RequestBody RefundRequest request) {
        try {
            RefundRequest refund = refundRequestService.createRefundRequest(request);
            return Result.success(refund);
        } catch (Exception e) {
            return Result.error("创建退款申请失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/list/order/{orderId}")
    public Result<List<RefundRequest>> getRefundsByOrder(@PathVariable Long orderId) {
        return Result.success(refundRequestService.getRefundsByOrderId(orderId));
    }
    
    @GetMapping("/list/user/{userId}")
    public Result<List<RefundRequest>> getRefundsByUser(@PathVariable Long userId) {
        return Result.success(refundRequestService.getRefundsByUserId(userId));
    }
    
    @GetMapping("/{id}")
    public Result<RefundRequest> getRefund(@PathVariable Long id) {
        RefundRequest refund = refundRequestService.getRefundById(id);
        if (refund != null) {
            return Result.success(refund);
        }
        return Result.error("退款申请不存在");
    }
    
    @PutMapping("/status/{id}/{status}")
    public Result<RefundRequest> updateStatus(@PathVariable Long id, @PathVariable Integer status) {
        try {
            RefundRequest refund = refundRequestService.updateRefundStatus(id, status);
            return Result.success(refund);
        } catch (Exception e) {
            return Result.error("更新状态失败：" + e.getMessage());
        }
    }
}

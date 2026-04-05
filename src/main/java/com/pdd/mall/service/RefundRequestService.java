package com.pdd.mall.service;

import com.pdd.mall.entity.RefundRequest;
import com.pdd.mall.mapper.RefundRequestMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 退款申请服务
 */
@Service
@Slf4j
public class RefundRequestService {
    
    @Autowired
    private RefundRequestMapper refundRequestMapper;
    
    public RefundRequest createRefundRequest(RefundRequest request) {
        request.setStatus(0); // 待审核
        request.setCreateTime(LocalDateTime.now());
        request.setUpdateTime(LocalDateTime.now());
        
        refundRequestMapper.insert(request);
        log.info("创建退款申请：orderId={}, userId={}, amount={}", 
                request.getOrderId(), request.getUserId(), request.getRefundAmount());
        
        return request;
    }
    
    public List<RefundRequest> getRefundsByOrderId(Long orderId) {
        return refundRequestMapper.findByOrderId(orderId);
    }
    
    public List<RefundRequest> getRefundsByUserId(Long userId) {
        return refundRequestMapper.findByUserId(userId);
    }
    
    public RefundRequest getRefundById(Long id) {
        return refundRequestMapper.findById(id);
    }
    
    public RefundRequest updateRefundStatus(Long id, Integer status) {
        RefundRequest request = refundRequestMapper.findById(id);
        if (request != null) {
            request.setStatus(status);
            request.setUpdateTime(LocalDateTime.now());
            refundRequestMapper.update(request);
        }
        return request;
    }
}

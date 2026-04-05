package com.pdd.mall.service;

import com.pdd.mall.entity.DeliveryOrder;
import com.pdd.mall.mapper.DeliveryOrderMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 发货单服务
 */
@Service
@Slf4j
public class DeliveryOrderService {
    
    @Autowired
    private DeliveryOrderMapper deliveryOrderMapper;
    
    public DeliveryOrder createDeliveryOrder(DeliveryOrder order) {
        order.setStatus(0); // 待发货
        order.setCreateTime(LocalDateTime.now());
        order.setUpdateTime(LocalDateTime.now());
        
        deliveryOrderMapper.insert(order);
        log.info("创建发货单：orderId={}, deliveryNo={}", 
                order.getOrderId(), order.getDeliveryNo());
        
        return order;
    }
    
    public DeliveryOrder shipOrder(Long id, String logisticsCompany, String logisticsNo) {
        DeliveryOrder order = deliveryOrderMapper.findById(id);
        if (order != null) {
            order.setStatus(1); // 已发货
            order.setLogisticsCompany(logisticsCompany);
            order.setLogisticsNo(logisticsNo);
            order.setDeliveryTime(LocalDateTime.now());
            order.setUpdateTime(LocalDateTime.now());
            
            deliveryOrderMapper.update(order);
            log.info("发货成功：orderId={}, logisticsNo={}", order.getOrderId(), logisticsNo);
        }
        return order;
    }
    
    public DeliveryOrder getDeliveryByOrderId(Long orderId) {
        return deliveryOrderMapper.findByOrderId(orderId);
    }
    
    public List<DeliveryOrder> getDeliveriesByLogisticsNo(String logisticsNo) {
        return deliveryOrderMapper.findByLogisticsNo(logisticsNo);
    }
    
    /**
     * 查询所有已发货但未签收的发货单
     */
    public List<DeliveryOrder> findPendingDeliveries() {
        return deliveryOrderMapper.findPendingDeliveries();
    }
}

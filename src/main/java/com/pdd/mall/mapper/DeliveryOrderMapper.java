package com.pdd.mall.mapper;

import com.pdd.mall.entity.DeliveryOrder;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 发货单 Mapper
 */
@Mapper
public interface DeliveryOrderMapper {
    
    int insert(DeliveryOrder order);
    
    DeliveryOrder findByOrderId(@Param("orderId") Long orderId);
    
    List<DeliveryOrder> findByLogisticsNo(@Param("logisticsNo") String logisticsNo);
    
    DeliveryOrder findById(@Param("id") Long id);
    
    int update(DeliveryOrder order);
    
    List<DeliveryOrder> findPendingDeliveries();
}

package com.pdd.mall.mapper;

import com.pdd.mall.entity.OrderItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderItemMapper {
    List<OrderItem> findByOrderId(@Param("orderId") Long orderId);
    int insert(OrderItem orderItem);
}

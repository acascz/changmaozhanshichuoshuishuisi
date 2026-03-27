package com.pdd.mall.mapper;

import com.pdd.mall.entity.Orders;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrdersMapper {
    List<Orders> findByUserId(@Param("userId") Long userId);
    List<Orders> findByUserIdAndStatus(@Param("userId") Long userId, @Param("status") Integer status);
    Orders findById(@Param("id") Long id);
    Orders findByOrderNo(@Param("orderNo") String orderNo);
    int insert(Orders orders);
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);
}

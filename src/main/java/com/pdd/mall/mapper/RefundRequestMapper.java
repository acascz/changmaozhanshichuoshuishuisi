package com.pdd.mall.mapper;

import com.pdd.mall.entity.RefundRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 退款申请 Mapper
 */
@Mapper
public interface RefundRequestMapper {
    
    int insert(RefundRequest request);
    
    List<RefundRequest> findByOrderId(@Param("orderId") Long orderId);
    
    List<RefundRequest> findByUserId(@Param("userId") Long userId);
    
    RefundRequest findById(@Param("id") Long id);
    
    int update(RefundRequest request);
}

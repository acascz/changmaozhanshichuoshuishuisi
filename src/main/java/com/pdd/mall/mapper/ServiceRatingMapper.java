package com.pdd.mall.mapper;

import com.pdd.mall.entity.ServiceRating;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 客服评价 Mapper 接口
 */
@Mapper
public interface ServiceRatingMapper {
    
    /**
     * 插入评价
     */
    int insert(ServiceRating rating);
    
    /**
     * 根据会话 ID 查询评价
     */
    ServiceRating findBySessionId(@Param("sessionId") String sessionId);
    
    /**
     * 查询客服的评价列表
     */
    List<ServiceRating> findByServiceId(@Param("serviceId") Long serviceId);
    
    /**
     * 查询客服的平均评分
     */
    Double getAverageRating(@Param("serviceId") Long serviceId);
    
    /**
     * 查询客服的评价总数
     */
    int countByServiceId(@Param("serviceId") Long serviceId);
}

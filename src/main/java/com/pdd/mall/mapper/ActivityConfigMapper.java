package com.pdd.mall.mapper;

import com.pdd.mall.entity.ActivityConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 活动配置 Mapper
 */
@Mapper
public interface ActivityConfigMapper {
    
    ActivityConfig findById(@Param("id") Long id);
    
    List<ActivityConfig> findByStatus(@Param("status") Integer status);
    
    List<ActivityConfig> findActiveActivities();
    
    int insert(ActivityConfig config);
    
    int update(ActivityConfig config);
    
    int delete(@Param("id") Long id);
}

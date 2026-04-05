package com.pdd.mall.mapper;

import com.pdd.mall.entity.LogisticsTrack;
import com.pdd.mall.entity.TrackStatistics;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 物流轨迹 Mapper
 */
@Mapper
public interface LogisticsTrackMapper {

    /**
     * 根据物流单号查询轨迹
     */
    LogisticsTrack getTrackByLogisticsNo(@Param("logisticsNo") String logisticsNo);

    /**
     * 根据订单 ID 查询轨迹
     */
    LogisticsTrack getTrackByOrderId(@Param("orderId") Long orderId);

    /**
     * 批量添加轨迹
     */
    int batchAddTrack(@Param("tracks") List<LogisticsTrack> tracks);

    /**
     * 获取最新轨迹
     */
    LogisticsTrack getLatestTrack(@Param("logisticsNo") String logisticsNo);

    /**
     * 获取轨迹统计
     */
    TrackStatistics getTrackStatistics(@Param("logisticsNo") String logisticsNo);
}

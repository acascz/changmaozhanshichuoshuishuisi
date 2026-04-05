package com.pdd.mall.service;

import com.pdd.mall.entity.LogisticsTrack;
import com.pdd.mall.entity.TrackStatistics;

import java.util.List;

/**
 * 物流轨迹服务接口
 */
public interface LogisticsTrackService {

    /**
     * 根据物流单号查询轨迹
     */
    LogisticsTrack getTrackByLogisticsNo(String logisticsNo);

    /**
     * 根据订单 ID 查询轨迹
     */
    LogisticsTrack getTrackByOrderId(Long orderId);

    /**
     * 批量添加轨迹
     */
    void batchAddTrack(List<LogisticsTrack> tracks);

    /**
     * 获取最新轨迹
     */
    LogisticsTrack getLatestTrack(String logisticsNo);

    /**
     * 获取轨迹统计
     */
    TrackStatistics getTrackStatistics(String logisticsNo);
}

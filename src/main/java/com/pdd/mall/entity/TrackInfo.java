package com.pdd.mall.entity;

import lombok.Data;

/**
 * 物流轨迹信息
 */
@Data
public class TrackInfo {
    private String time;
    private String description;
    private String updateTime;
    private String status;
}

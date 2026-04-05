package com.pdd.mall.entity;

import java.time.LocalDateTime;

/**
 * 物流轨迹实体
 */
public class LogisticsTrack {
    private Long id;
    private String logisticsNo;
    private Long orderId;
    private String trackContent;
    private Integer trackStatus;
    private String trackLocation;
    private LocalDateTime trackTime;
    private String courierName;
    private String courierPhone;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLogisticsNo() {
        return logisticsNo;
    }

    public void setLogisticsNo(String logisticsNo) {
        this.logisticsNo = logisticsNo;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getTrackContent() {
        return trackContent;
    }

    public void setTrackContent(String trackContent) {
        this.trackContent = trackContent;
    }

    public Integer getTrackStatus() {
        return trackStatus;
    }

    public void setTrackStatus(Integer trackStatus) {
        this.trackStatus = trackStatus;
    }

    public String getTrackLocation() {
        return trackLocation;
    }

    public void setTrackLocation(String trackLocation) {
        this.trackLocation = trackLocation;
    }

    public LocalDateTime getTrackTime() {
        return trackTime;
    }

    public void setTrackTime(LocalDateTime trackTime) {
        this.trackTime = trackTime;
    }

    public String getCourierName() {
        return courierName;
    }

    public void setCourierName(String courierName) {
        this.courierName = courierName;
    }

    public String getCourierPhone() {
        return courierPhone;
    }

    public void setCourierPhone(String courierPhone) {
        this.courierPhone = courierPhone;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }
}

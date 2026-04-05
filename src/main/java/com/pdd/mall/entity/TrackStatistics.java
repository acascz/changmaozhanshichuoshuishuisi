package com.pdd.mall.entity;

import java.time.LocalDateTime;

/**
 * 物流统计信息
 */
public class TrackStatistics {
    private String logisticsNo;
    private Integer totalTracks;
    private Integer delivered;
    private Integer inTransit;
    private Integer exception;
    private LocalDateTime latestTrackTime;
    private String latestTrackContent;

    public String getLogisticsNo() {
        return logisticsNo;
    }

    public void setLogisticsNo(String logisticsNo) {
        this.logisticsNo = logisticsNo;
    }

    public Integer getTotalTracks() {
        return totalTracks;
    }

    public void setTotalTracks(Integer totalTracks) {
        this.totalTracks = totalTracks;
    }

    public Integer getDelivered() {
        return delivered;
    }

    public void setDelivered(Integer delivered) {
        this.delivered = delivered;
    }

    public Integer getInTransit() {
        return inTransit;
    }

    public void setInTransit(Integer inTransit) {
        this.inTransit = inTransit;
    }

    public Integer getException() {
        return exception;
    }

    public void setException(Integer exception) {
        this.exception = exception;
    }

    public LocalDateTime getLatestTrackTime() {
        return latestTrackTime;
    }

    public void setLatestTrackTime(LocalDateTime latestTrackTime) {
        this.latestTrackTime = latestTrackTime;
    }

    public String getLatestTrackContent() {
        return latestTrackContent;
    }

    public void setLatestTrackContent(String latestTrackContent) {
        this.latestTrackContent = latestTrackContent;
    }
}

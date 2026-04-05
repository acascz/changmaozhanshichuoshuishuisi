package com.pdd.mall.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * WebSocket 消息实体
 */
@Data
public class WebSocketMessage {
    
    /**
     * 消息类型
     */
    private String type;
    
    /**
     * 消息内容
     */
    private Object data;
    
    /**
     * 时间戳
     */
    private Long timestamp;
    
    /**
     * 消息 ID
     */
    private String messageId;
    
    /**
     * 创建时间
     */
    private LocalDateTime createTime;
    
    /**
     * 构造函数
     */
    public WebSocketMessage() {
        this.timestamp = System.currentTimeMillis();
        this.createTime = LocalDateTime.now();
    }
    
    /**
     * 创建新消息通知
     */
    public static WebSocketMessage newMessage(Object messageData) {
        WebSocketMessage message = new WebSocketMessage();
        message.setType("NEW_MESSAGE");
        message.setData(messageData);
        return message;
    }
    
    /**
     * 创建已读状态更新
     */
    public static WebSocketMessage readUpdate(Object readData) {
        WebSocketMessage message = new WebSocketMessage();
        message.setType("READ_UPDATE");
        message.setData(readData);
        return message;
    }
    
    /**
     * 创建在线状态更新
     */
    public static WebSocketMessage onlineStatus(Object statusData) {
        WebSocketMessage message = new WebSocketMessage();
        message.setType("ONLINE_STATUS");
        message.setData(statusData);
        return message;
    }
    
    /**
     * 创建错误消息
     */
    public static WebSocketMessage error(String errorMessage) {
        WebSocketMessage message = new WebSocketMessage();
        message.setType("ERROR");
        message.setData(errorMessage);
        return message;
    }
}

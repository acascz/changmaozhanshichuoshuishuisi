package com.pdd.mall.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 聊天会话成员实体
 */
@Data
public class ChatSessionMember {
    
    /**
     * 记录 ID
     */
    private Long id;
    
    /**
     * 会话 ID
     */
    private String sessionId;
    
    /**
     * 用户 ID
     */
    private Long userId;
    
    /**
     * 角色：0-普通成员，1-管理员，2-群主（仅群聊）
     */
    private Integer role;
    
    /**
     * 会话密钥（群组加密时使用）
     */
    private String sessionKey;
    
    /**
     * 加入时间
     */
    private LocalDateTime joinTime;
    
    /**
     * 退出时间
     */
    private LocalDateTime leaveTime;
    
    /**
     * 创建时间
     */
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}

package com.pdd.mall.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 群聊实体
 */
@Data
public class ChatGroup {
    
    /**
     * 群聊 ID
     */
    private Long groupId;
    
    /**
     * 群号（唯一）
     */
    private String groupNo;
    
    /**
     * 群名称
     */
    private String groupName;
    
    /**
     * 群头像
     */
    private String groupAvatar;
    
    /**
     * 群公告
     */
    private String groupNotice;
    
    /**
     * 创建者 ID
     */
    private Long creatorId;
    
    /**
     * 最大成员数
     */
    private Integer maxMembers;
    
    /**
     * 当前成员数
     */
    private Integer memberCount;
    
    /**
     * 群状态：1-正常，2-禁言，3-解散
     */
    private Integer status;
    
    /**
     * 创建时间
     */
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}

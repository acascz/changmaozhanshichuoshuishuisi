package com.pdd.mall.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 用户好友关系实体
 */
@Data
public class UserFriend {
    
    /**
     * 主键 ID
     */
    private Long id;
    
    /**
     * 用户 ID
     */
    private Long userId;
    
    /**
     * 好友 ID
     */
    private Long friendId;
    
    /**
     * 好友分组 ID
     */
    private Long friendGroupId;
    
    /**
     * 好友备注名
     */
    private String friendRemark;
    
    /**
     * 好友状态：1-正常，2-已拉黑，3-已删除
     */
    private Integer friendStatus;
    
    /**
     * 是否星标：0-否，1-是
     */
    private Integer isStar;
    
    /**
     * 添加时间
     */
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}

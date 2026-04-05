package com.pdd.mall.entity;

import lombok.Data;

import java.util.Date;

/**
 * 好友申请实体类
 */
@Data
public class FriendRequest {
    
    /**
     * 申请 ID
     */
    private Long id;
    
    /**
     * 申请人 ID
     */
    private Long requesterId;
    
    /**
     * 被申请人 ID
     */
    private Long targetId;
    
    /**
     * 申请备注信息
     */
    private String remark;
    
    /**
     * 申请状态：0-待处理，1-已同意，2-已拒绝，3-已撤回
     */
    private Integer status;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    /**
     * 处理时间
     */
    private Date handleTime;
}

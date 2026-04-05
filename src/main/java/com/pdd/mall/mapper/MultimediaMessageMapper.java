package com.pdd.mall.mapper;

import com.pdd.mall.entity.MultimediaMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 多媒体消息 Mapper
 */
@Mapper
public interface MultimediaMessageMapper {
    
    /**
     * 插入多媒体消息
     */
    int insert(MultimediaMessage message);
    
    /**
     * 根据 ID 查询消息
     */
    MultimediaMessage selectById(@Param("id") Long id);
    
    /**
     * 根据消息 ID 查询消息
     */
    MultimediaMessage selectByMessageId(@Param("messageId") String messageId);
    
    /**
     * 查询会话消息列表（分页）
     */
    List<MultimediaMessage> selectBySessionId(@Param("sessionId") String sessionId,
                                               @Param("offset") int offset,
                                               @Param("limit") int limit);
    
    /**
     * 更新消息状态
     */
    int updateStatus(@Param("messageId") String messageId,
                     @Param("status") Integer status);
    
    /**
     * 更新消息已读状态
     */
    int updateReadStatus(@Param("messageId") String messageId,
                         @Param("isRead") Integer isRead);
}

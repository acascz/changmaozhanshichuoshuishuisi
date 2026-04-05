package com.pdd.mall.mapper;

import com.pdd.mall.entity.UserBrowseHistory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 用户浏览记录 Mapper
 */
@Mapper
public interface UserBrowseHistoryMapper {

    /**
     * 插入浏览记录
     */
    int insert(UserBrowseHistory history);

    /**
     * 查询用户的浏览记录（分页）
     */
    List<UserBrowseHistory> selectByUserId(@Param("userId") Long userId,
                                           @Param("startTime") LocalDateTime startTime,
                                           @Param("endTime") LocalDateTime endTime,
                                           @Param("offset") Integer offset,
                                           @Param("limit") Integer limit);

    /**
     * 查询用户最近的浏览记录
     */
    List<UserBrowseHistory> selectRecentByUserId(@Param("userId") Long userId,
                                                 @Param("limit") Integer limit);

    /**
     * 统计用户浏览记录数量
     */
    int countByUserId(@Param("userId") Long userId,
                      @Param("startTime") LocalDateTime startTime,
                      @Param("endTime") LocalDateTime endTime);

    /**
     * 删除用户的浏览记录
     */
    int deleteByUserId(@Param("userId") Long userId);

    /**
     * 删除指定时间的浏览记录
     */
    int deleteByTime(@Param("beforeTime") LocalDateTime beforeTime);
}

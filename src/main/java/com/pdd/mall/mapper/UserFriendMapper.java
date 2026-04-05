package com.pdd.mall.mapper;

import com.pdd.mall.entity.UserFriend;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 用户好友 Mapper
 */
@Mapper
public interface UserFriendMapper {
    
    /**
     * 查询用户的好友列表
     */
    List<Map<String, Object>> selectUserFriends(@Param("userId") Long userId);
    
    /**
     * 添加好友
     */
    int insert(UserFriend userFriend);
    
    /**
     * 删除好友
     */
    int delete(@Param("userId") Long userId, @Param("friendId") Long friendId);
    
    /**
     * 更新好友备注
     */
    int updateRemark(@Param("userId") Long userId, @Param("friendId") Long friendId, @Param("remark") String remark);
    
    /**
     * 设置星标好友
     */
    int updateStarStatus(@Param("userId") Long userId, @Param("friendId") Long friendId, @Param("isStar") Integer isStar);
    
    /**
     * 检查是否已是好友
     */
    UserFriend selectByUserIdAndFriendId(@Param("userId") Long userId, @Param("friendId") Long friendId);
}

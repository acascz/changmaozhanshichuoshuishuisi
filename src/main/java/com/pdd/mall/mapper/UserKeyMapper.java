package com.pdd.mall.mapper;

import com.pdd.mall.entity.UserKey;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 用户密钥 Mapper
 */
@Mapper
public interface UserKeyMapper {
    
    /**
     * 插入用户密钥
     */
    int insert(UserKey userKey);
    
    /**
     * 根据用户 ID 查询密钥
     */
    UserKey selectByUserId(@Param("userId") Long userId);
    
    /**
     * 根据用户 ID 删除密钥
     */
    int deleteByUserId(@Param("userId") Long userId);
    
    /**
     * 更新用户密钥
     */
    int update(UserKey userKey);
}

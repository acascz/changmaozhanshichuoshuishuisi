package com.pdd.mall.mapper;

import com.pdd.mall.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {
    User findByUsername(@Param("username") String username);
    User findById(@Param("id") Long id);
    int insert(User user);
    int update(User user);
    
    /**
     * 根据关键词搜索用户
     */
    List<User> searchByKeyword(@Param("keyword") String keyword);
}

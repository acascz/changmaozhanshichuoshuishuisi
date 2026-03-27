package com.pdd.mall.mapper;

import com.pdd.mall.entity.Favorite;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FavoriteMapper {
    List<Favorite> findByUserId(@Param("userId") Long userId);
    Favorite findByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);
    int insert(Favorite favorite);
    int deleteByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);
}

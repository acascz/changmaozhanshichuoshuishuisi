package com.pdd.mall.mapper;

import com.pdd.mall.entity.Banner;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BannerMapper {
    
    @Select("SELECT * FROM banner WHERE status = 1 ORDER BY sort_order ASC")
    List<Banner> findAllActiveBanners();
    
    @Select("SELECT * FROM banner WHERE id = #{id}")
    Banner findById(Long id);
    
    @Select("SELECT * FROM banner ORDER BY sort_order ASC")
    List<Banner> findAll();
    
    @Select("INSERT INTO banner (image_url, title, link_url, sort_order, status, create_time, update_time) " +
            "VALUES (#{imageUrl}, #{title}, #{linkUrl}, #{sortOrder}, #{status}, NOW(), NOW())")
    void insert(Banner banner);
    
    @Select("UPDATE banner SET image_url = #{imageUrl}, title = #{title}, link_url = #{linkUrl}, " +
            "sort_order = #{sortOrder}, status = #{status}, update_time = NOW() WHERE id = #{id}")
    void update(Banner banner);
    
    @Select("DELETE FROM banner WHERE id = #{id}")
    void delete(Long id);
}
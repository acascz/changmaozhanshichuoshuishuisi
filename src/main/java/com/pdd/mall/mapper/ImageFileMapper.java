package com.pdd.mall.mapper;

import com.pdd.mall.entity.ImageFile;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ImageFileMapper {
    
    @Select("SELECT id, original_name AS originalName, stored_name AS storedName, file_path AS filePath, file_type AS fileType, " +
            "file_size AS fileSize, description, category, related_id AS relatedId, sort_order AS sortOrder, status, " +
            "create_time AS createTime, update_time AS updateTime " +
            "FROM image_file WHERE id = #{id}")
    ImageFile findById(Long id);
    
    @Select("SELECT id, original_name AS originalName, stored_name AS storedName, file_path AS filePath, file_type AS fileType, " +
            "file_size AS fileSize, description, category, related_id AS relatedId, sort_order AS sortOrder, status, " +
            "create_time AS createTime, update_time AS updateTime " +
            "FROM image_file WHERE category = #{category} AND status = 1 ORDER BY sort_order ASC")
    List<ImageFile> findByCategory(String category);
    
    @Select("SELECT id, original_name AS originalName, stored_name AS storedName, file_path AS filePath, file_type AS fileType, " +
            "file_size AS fileSize, description, category, related_id AS relatedId, sort_order AS sortOrder, status, " +
            "create_time AS createTime, update_time AS updateTime " +
            "FROM image_file WHERE category = #{category} AND related_id = #{relatedId} AND status = 1 ORDER BY sort_order ASC")
    List<ImageFile> findByCategoryAndRelatedId(@Param("category") String category, @Param("relatedId") String relatedId);
    
    @Select("SELECT id, original_name AS originalName, stored_name AS storedName, file_path AS filePath, file_type AS fileType, " +
            "file_size AS fileSize, description, category, related_id AS relatedId, sort_order AS sortOrder, status, " +
            "create_time AS createTime, update_time AS updateTime " +
            "FROM image_file WHERE stored_name = #{storedName}")
    ImageFile findByStoredName(String storedName);
    
    @Insert("INSERT INTO image_file (original_name, stored_name, file_path, file_type, file_size, description, category, related_id, sort_order, status, create_time, update_time) " +
            "VALUES (#{originalName}, #{storedName}, #{filePath}, #{fileType}, #{fileSize}, #{description}, #{category}, #{relatedId}, #{sortOrder}, #{status}, NOW(), NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void insert(ImageFile imageFile);
    
    @Update("UPDATE image_file SET original_name = #{originalName}, file_path = #{filePath}, file_type = #{fileType}, file_size = #{fileSize}, " +
            "description = #{description}, category = #{category}, related_id = #{relatedId}, sort_order = #{sortOrder}, status = #{status}, update_time = NOW() WHERE id = #{id}")
    void update(ImageFile imageFile);
    
    @Delete("DELETE FROM image_file WHERE id = #{id}")
    void delete(Long id);
    
    @Update("UPDATE image_file SET status = #{status}, update_time = NOW() WHERE id = #{id}")
    void updateStatus(@Param("id") Long id, @Param("status") Integer status);
}
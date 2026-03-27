package com.pdd.mall.mapper;

import com.pdd.mall.entity.AiForm;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AiFormMapper {
    List<AiForm> findByUserId(@Param("userId") Long userId);
    AiForm findById(@Param("id") Long id);
    int insert(AiForm aiForm);
}

package com.pdd.mall.mapper;

import com.pdd.mall.entity.ChatMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ChatMessageMapper {
    List<ChatMessage> findByUserId(@Param("userId") Long userId);
    int insert(ChatMessage chatMessage);
}

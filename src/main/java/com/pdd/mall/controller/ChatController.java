package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chat")
@CrossOrigin
public class ChatController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/messages/{userId}")
    public Result<List<ChatMessage>> getMessages(@PathVariable Long userId) {
        return Result.success(chatService.getMessagesByUserId(userId));
    }

    @PostMapping("/send")
    public Result<ChatMessage> sendMessage(@RequestBody Map<String, Object> params) {
        Long userId = Long.valueOf(params.get("userId").toString());
        Integer fromType = Integer.valueOf(params.get("fromType").toString());
        String content = params.get("content").toString();
        return Result.success(chatService.sendMessage(userId, fromType, content));
    }
}

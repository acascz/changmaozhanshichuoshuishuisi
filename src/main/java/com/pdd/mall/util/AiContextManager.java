package com.pdd.mall.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

/**
 * AI 对话上下文管理器（支持 Redis 持久化）
 */
@Slf4j
@Component
public class AiContextManager {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    // 内存缓存（作为 Redis 的缓存层）
    private final Map<String, ConversationContext> contextMap = new ConcurrentHashMap<>();

    // Redis key 前缀
    private static final String REDIS_KEY_PREFIX = "ai:context:";

    // 上下文最大长度（内存）
    private static final int MAX_CONTEXT_SIZE = 10;

    // Redis 过期时间（7 天）
    private static final long REDIS_EXPIRE_SECONDS = 7 * 24 * 60 * 60;

    /**
     * 获取上下文
     */
    public ConversationContext getContext(Long userId, String sessionId) {
        String key = buildKey(userId, sessionId);
        
        // 1. 先从内存缓存获取
        ConversationContext context = contextMap.computeIfAbsent(key, k -> {
            // 2. 内存中没有，从 Redis 加载
            return loadContextFromRedis(key);
        });
        
        return context;
    }

    /**
     * 从 Redis 加载上下文
     */
    private ConversationContext loadContextFromRedis(String key) {
        try {
            String redisKey = REDIS_KEY_PREFIX + key;
            String contextJson = (String) redisTemplate.opsForValue().get(redisKey);
            
            if (contextJson != null) {
                ConversationContext context = objectMapper.readValue(contextJson, ConversationContext.class);
                log.debug("从 Redis 加载上下文：key={}, contextSize={}", key, context.getMessages().size());
                return context;
            }
        } catch (Exception e) {
            log.error("从 Redis 加载上下文失败：key={}", key, e);
        }
        
        // 创建新的上下文
        return new ConversationContext();
    }

    /**
     * 保存上下文到 Redis
     */
    private void saveContextToRedis(String key, ConversationContext context) {
        try {
            String redisKey = REDIS_KEY_PREFIX + key;
            String contextJson = objectMapper.writeValueAsString(context);
            redisTemplate.opsForValue().set(redisKey, contextJson, REDIS_EXPIRE_SECONDS, TimeUnit.SECONDS);
            log.debug("保存上下文到 Redis：key={}", key);
        } catch (Exception e) {
            log.error("保存上下文到 Redis 失败：key={}", key, e);
        }
    }

    /**
     * 添加对话到上下文
     */
    public void addMessage(Long userId, String sessionId, String question, String answer) {
        String key = buildKey(userId, sessionId);
        ConversationContext context = getContext(userId, sessionId);
        context.addMessage(question, answer);
        
        // 限制上下文大小
        if (context.getMessages().size() > MAX_CONTEXT_SIZE) {
            context.getMessages().remove(0);
        }
        
        // 保存到 Redis
        saveContextToRedis(key, context);
        
        log.debug("添加对话到上下文：userId={}, sessionId={}, contextSize={}", 
                  userId, sessionId, context.getMessages().size());
    }

    /**
     * 清除上下文
     */
    public void clearContext(Long userId, String sessionId) {
        String key = buildKey(userId, sessionId);
        
        // 清除内存缓存
        contextMap.remove(key);
        
        // 清除 Redis 缓存
        String redisKey = REDIS_KEY_PREFIX + key;
        redisTemplate.delete(redisKey);
        
        log.info("清除上下文：userId={}, sessionId={}", userId, sessionId);
    }

    /**
     * 获取对话历史
     */
    public List<Map<String, String>> getHistory(Long userId, String sessionId, Integer limit) {
        ConversationContext context = getContext(userId, sessionId);
        List<Map<String, String>> messages = context.getMessages();
        
        if (limit == null || limit <= 0) {
            limit = MAX_CONTEXT_SIZE;
        }
        
        // 返回最近的 limit 条对话
        int size = messages.size();
        if (size <= limit) {
            return messages;
        }
        
        return messages.subList(size - limit, size);
    }

    /**
     * 构建上下文 key
     */
    private String buildKey(Long userId, String sessionId) {
        return userId + "_" + sessionId;
    }

    /**
     * 对话上下文
     */
    public static class ConversationContext {
        private final List<Map<String, String>> messages = new ArrayList<>();
        private final Map<String, Object> metadata = new HashMap<>();
        private LocalDateTime lastAccessTime = LocalDateTime.now();

        public void addMessage(String question, String answer) {
            Map<String, String> message = new HashMap<>();
            message.put("role", "user");
            message.put("content", question);
            messages.add(message);

            Map<String, String> response = new HashMap<>();
            response.put("role", "assistant");
            response.put("content", answer);
            messages.add(response);

            lastAccessTime = LocalDateTime.now();
        }

        public List<Map<String, String>> getMessages() {
            return messages;
        }

        public Map<String, Object> getMetadata() {
            return metadata;
        }

        public LocalDateTime getLastAccessTime() {
            return lastAccessTime;
        }
    }
}

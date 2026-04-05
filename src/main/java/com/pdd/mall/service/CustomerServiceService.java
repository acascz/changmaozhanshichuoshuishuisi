package com.pdd.mall.service;

import com.pdd.mall.entity.ChatSession;
import com.pdd.mall.entity.ChatSessionMember;
import com.pdd.mall.mapper.ChatSessionMapper;
import com.pdd.mall.mapper.ChatSessionMemberMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 客服系统服务类
 */
@Slf4j
@Service
public class CustomerServiceService {
    
    @Autowired
    private ChatSessionMapper chatSessionMapper;
    
    @Autowired
    private ChatSessionMemberMapper chatSessionMemberMapper;
    
    // 客服排队队列
    private final LinkedBlockingQueue<Long> waitingQueue = new LinkedBlockingQueue<>();
    
    // 客服会话映射：<userId, sessionId>
    private final Map<Long, String> userSessions = new ConcurrentHashMap<>();
    
    // 客服分配映射：<sessionId, serviceId>
    private final Map<String, Long> sessionServices = new ConcurrentHashMap<>();
    
    // 在线客服列表
    private final Map<Long, Boolean> onlineServices = new ConcurrentHashMap<>();
    
    // 会话 ID 生成器
    private final AtomicLong sessionIdGenerator = new AtomicLong(10000);
    
    // 线程池处理排队
    private final ThreadPoolExecutor queueProcessor = new ThreadPoolExecutor(
        2, 10, 60L, TimeUnit.SECONDS,
        new LinkedBlockingQueue<>(100)
    );
    
    /**
     * 用户请求客服
     */
    @Transactional
    public String requestService(Long userId, String question) {
        try {
            log.info("用户请求客服：userId={}, question={}", userId, question);
            
            // 检查是否已有会话
            String existingSession = userSessions.get(userId);
            if (existingSession != null) {
                log.info("用户已有客服会话：userId={}, sessionId={}", userId, existingSession);
                return existingSession;
            }
            
            // 创建客服会话
            String sessionId = "service_" + sessionIdGenerator.incrementAndGet();
            
            ChatSession session = new ChatSession();
            session.setSessionId(sessionId);
            session.setSessionType(1); // 客服会话
            session.setSessionName("客服咨询");
            session.setCreatorId(userId);
            chatSessionMapper.insert(session);
            
            // 添加用户为成员
            ChatSessionMember userMember = new ChatSessionMember();
            userMember.setSessionId(sessionId);
            userMember.setUserId(userId);
            userMember.setRole(0); // 普通成员
            userMember.setJoinTime(LocalDateTime.now());
            chatSessionMemberMapper.insert(userMember);
            
            // 加入排队队列
            waitingQueue.offer(userId);
            userSessions.put(userId, sessionId);
            
            log.info("用户加入排队队列：userId={}, queueSize={}", userId, waitingQueue.size());
            
            // 异步处理排队
            queueProcessor.submit(() -> processQueue());
            
            return sessionId;
            
        } catch (Exception e) {
            log.error("请求客服失败", e);
            throw new RuntimeException("请求客服失败：" + e.getMessage());
        }
    }
    
    /**
     * 客服上线
     */
    public void serviceOnline(Long serviceId) {
        log.info("客服上线：serviceId={}", serviceId);
        onlineServices.put(serviceId, true);
        
        // 触发排队处理
        queueProcessor.submit(() -> processQueue());
    }
    
    /**
     * 客服下线
     */
    @Transactional
    public void serviceOffline(Long serviceId) {
        try {
            log.info("客服下线：serviceId={}", serviceId);
            onlineServices.remove(serviceId);
            
            // 找到该客服的所有会话
            for (Map.Entry<String, Long> entry : sessionServices.entrySet()) {
                if (entry.getValue().equals(serviceId)) {
                    String sessionId = entry.getKey();
                    // 移除客服会话成员
                    chatSessionMemberMapper.delete(sessionId, serviceId);
                    sessionServices.remove(sessionId);
                    log.info("客服下线，移除会话：sessionId={}, serviceId={}", sessionId, serviceId);
                }
            }
            
        } catch (Exception e) {
            log.error("客服下线失败", e);
        }
    }
    
    /**
     * 转接客服
     */
    @Transactional
    public void transferService(String sessionId, Long fromServiceId, Long toServiceId) {
        try {
            log.info("转接客服：sessionId={}, from={}, to={}", sessionId, fromServiceId, toServiceId);
            
            // 验证目标客服是否在线
            if (!onlineServices.containsKey(toServiceId)) {
                throw new RuntimeException("目标客服不在线");
            }
            
            // 移除原客服
            chatSessionMemberMapper.delete(sessionId, fromServiceId);
            
            // 添加新客服
            ChatSessionMember newService = new ChatSessionMember();
            newService.setSessionId(sessionId);
            newService.setUserId(toServiceId);
            newService.setRole(1); // 管理员
            newService.setJoinTime(LocalDateTime.now());
            chatSessionMemberMapper.insert(newService);
            
            // 更新会话映射
            sessionServices.put(sessionId, toServiceId);
            
            log.info("转接客服成功：sessionId={}, to={}", sessionId, toServiceId);
            
        } catch (Exception e) {
            log.error("转接客服失败", e);
            throw new RuntimeException("转接客服失败：" + e.getMessage());
        }
    }
    
    /**
     * 结束客服会话
     */
    @Transactional
    public void endService(String sessionId, Long userId) {
        try {
            log.info("结束客服会话：sessionId={}, userId={}", sessionId, userId);
            
            // 移除用户会话映射
            userSessions.remove(userId);
            
            // 移除客服会话映射
            sessionServices.remove(sessionId);
            
            // 更新会话状态为已结束
            ChatSession session = chatSessionMapper.findBySessionId(sessionId);
            if (session != null) {
                session.setStatus(2); // 已结束
                chatSessionMapper.update(session);
            }
            
            log.info("结束客服会话成功：sessionId={}", sessionId);
            
        } catch (Exception e) {
            log.error("结束客服会话失败", e);
        }
    }
    
    /**
     * 处理排队队列
     */
    private void processQueue() {
        try {
            while (!waitingQueue.isEmpty() && !onlineServices.isEmpty()) {
                Long userId = waitingQueue.poll();
                if (userId == null) {
                    break;
                }
                
                // 找一个空闲的客服
                Long serviceId = findAvailableService();
                if (serviceId == null) {
                    // 没有空闲客服，重新加入队列
                    waitingQueue.offer(userId);
                    break;
                }
                
                String sessionId = userSessions.get(userId);
                if (sessionId == null) {
                    continue;
                }
                
                // 添加客服到会话
                ChatSessionMember serviceMember = new ChatSessionMember();
                serviceMember.setSessionId(sessionId);
                serviceMember.setUserId(serviceId);
                serviceMember.setRole(1); // 管理员
                serviceMember.setJoinTime(LocalDateTime.now());
                chatSessionMemberMapper.insert(serviceMember);
                
                // 记录客服会话映射
                sessionServices.put(sessionId, serviceId);
                
                log.info("分配客服成功：userId={}, serviceId={}, sessionId={}", userId, serviceId, sessionId);
                
            }
        } catch (Exception e) {
            log.error("处理排队队列失败", e);
        }
    }
    
    /**
     * 查找空闲客服
     */
    private Long findAvailableService() {
        // 简单实现：返回第一个在线的客服
        // 实际应该实现更复杂的负载均衡算法
        for (Long serviceId : onlineServices.keySet()) {
            // 检查客服是否已有会话（这里简化处理，假设每个客服只能处理一个会话）
            if (!sessionServices.containsValue(serviceId)) {
                return serviceId;
            }
        }
        return null;
    }
    
    /**
     * 获取排队人数
     */
    public int getQueueSize() {
        return waitingQueue.size();
    }
    
    /**
     * 获取在线客服数
     */
    public int getOnlineServiceCount() {
        return onlineServices.size();
    }
    
    /**
     * 获取用户的客服会话
     */
    public String getUserServiceSession(Long userId) {
        return userSessions.get(userId);
    }
}

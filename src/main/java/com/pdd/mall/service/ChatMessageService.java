package com.pdd.mall.service;

import com.pdd.mall.entity.ChatMessage;
import com.pdd.mall.mapper.ChatMessageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 聊天消息服务
 */
@Service
@Slf4j
public class ChatMessageService {

    @Autowired
    private ChatMessageMapper chatMessageMapper;
    
    @Autowired
    private UserFriendService userFriendService;

    /**
     * 获取用户会话列表
     */
    public List<Map<String, Object>> getUserSessions(Long userId) {
        log.info("获取用户会话列表：userId={}", userId);
        
        // 获取用户的会话列表（从数据库查询）
        List<Map<String, Object>> sessions = chatMessageMapper.selectUserSessions(userId);
        
        // 获取用户的好友列表
        try {
            List<Map<String, Object>> friends = userFriendService.getUserFriends(userId);
            
            // 将好友转换为会话格式
            if (friends != null && !friends.isEmpty()) {
                for (Map<String, Object> friend : friends) {
                    Long friendId = (Long) friend.get("friendId");
                    String friendName = (String) friend.get("friendName");
                    String friendRemark = (String) friend.get("friendRemark");
                    String avatar = (String) friend.get("avatar");
                    Integer isStar = (Integer) friend.get("isStar");
                    
                    // 检查是否已存在该好友的会话
                    boolean exists = false;
                    for (Map<String, Object> session : sessions) {
                        // TODO: 需要根据 sessionId 判断是否是同一个会话
                        // 暂时简化处理
                    }
                    
                    // 添加好友到会话列表
                    Map<String, Object> session = new HashMap<>();
                    session.put("sessionId", "friend_" + friendId);
                    session.put("name", friendRemark != null ? friendRemark : friendName);
                    session.put("type", "好友");
                    session.put("avatar", avatar != null ? avatar : "友");
                    session.put("lastMessage", "点击开始聊天");
                    session.put("lastMessageTime", friend.get("createTime"));
                    session.put("time", "今天");
                    session.put("isStar", isStar);
                    
                    sessions.add(session);
                }
            }
        } catch (Exception e) {
            log.warn("获取好友列表失败，跳过好友会话添加", e);
        }
        
        // 为每个会话添加额外信息
        for (Map<String, Object> session : sessions) {
            // 根据会话类型设置显示名称和时间格式
            String type = (String) session.get("type");
            String name = (String) session.get("name");
            LocalDateTime createTime = (LocalDateTime) session.get("lastMessageTime");
            
            // 格式化时间
            if (createTime != null) {
                String timeStr = formatTime(createTime);
                session.put("time", timeStr);
            } else {
                session.put("time", "今天");
            }
            
            // 设置 lastMessage 字段
            String lastMessage = (String) session.get("lastMessage");
            if (lastMessage == null || lastMessage.isEmpty()) {
                session.put("lastMessage", "暂无消息");
            }
            
            // 设置 avatar 字段（用于前端显示）
            session.put("avatar", getAvatarText(name, type));
        }
        
        return sessions;
    }
    
    /**
     * 格式化时间
     */
    private String formatTime(LocalDateTime time) {
        LocalDateTime today = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0);
        LocalDateTime yesterday = today.minusDays(1);
        
        if (time.isAfter(today)) {
            return "今天";
        } else if (time.isAfter(yesterday)) {
            return "昨天";
        } else {
            return String.format("%d/%02d/%02d", 
                time.getYear() % 100, 
                time.getMonthValue(), 
                time.getDayOfMonth());
        }
    }
    
    /**
     * 获取头像显示文字
     */
    private String getAvatarText(String name, String type) {
        if ("官方".equals(type)) {
            return "官";
        } else if ("商家".equals(type)) {
            return "商";
        } else {
            return "友";
        }
    }

    /**
     * 发送消息
     */
    @Transactional
    public ChatMessage sendMessage(String sessionId, Long senderId, Long receiverId, 
                                   String content, Integer messageType) {
        log.info("发送消息：sessionId={}, senderId={}, receiverId={}", sessionId, senderId, receiverId);
        
        ChatMessage message = new ChatMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(messageType);
        message.setContent(content);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        chatMessageMapper.insert(message);
        return message;
    }

    /**
     * 获取会话消息列表
     */
    public List<ChatMessage> getSessionMessages(String sessionId, int page, int size) {
        log.info("获取会话消息：sessionId={}, page={}, size={}", sessionId, page, size);
        int offset = (page - 1) * size;
        return chatMessageMapper.selectBySessionId(sessionId, offset, size);
    }

    /**
     * 根据消息 ID 获取消息
     */
    public ChatMessage getMessageById(Long id) {
        log.info("获取消息：id={}", id);
        return chatMessageMapper.selectById(id);
    }

    /**
     * 根据消息 UUID 获取消息
     */
    public ChatMessage getMessageByMessageId(String messageId) {
        log.info("获取消息：messageId={}", messageId);
        return chatMessageMapper.selectByMessageId(messageId);
    }

    /**
     * 标记消息已读
     */
    @Transactional
    public boolean markMessageAsRead(String messageId) {
        log.info("标记消息已读：messageId={}", messageId);
        int rows = chatMessageMapper.updateReadStatus(messageId, 1, LocalDateTime.now());
        return rows > 0;
    }

    /**
     * 撤回消息
     */
    @Transactional
    public boolean recallMessage(String messageId) {
        log.info("撤回消息：messageId={}", messageId);
        int rows = chatMessageMapper.updateStatus(messageId, 2);
        return rows > 0;
    }
    
    /**
     * 撤回消息（Long 类型 ID）
     */
    @Transactional
    public void recallMessage(Long messageId) {
        log.info("撤回消息：messageId={}", messageId);
        ChatMessage message = chatMessageMapper.selectById(messageId);
        if (message != null) {
            chatMessageMapper.updateStatus(message.getMessageId(), 2);
        }
    }

    /**
     * 删除消息
     */
    @Transactional
    public boolean deleteMessage(String messageId) {
        log.info("删除消息：messageId={}", messageId);
        int rows = chatMessageMapper.updateStatus(messageId, 3);
        return rows > 0;
    }
    
    /**
     * 删除消息（Long 类型 ID）
     */
    @Transactional
    public void deleteMessage(Long messageId) {
        log.info("删除消息：messageId={}", messageId);
        ChatMessage message = chatMessageMapper.selectById(messageId);
        if (message != null) {
            chatMessageMapper.updateStatus(message.getMessageId(), 3);
        }
    }
    
    /**
     * 批量删除消息
     */
    @Transactional
    public void deleteBatchMessages(List<Long> messageIds) {
        log.info("批量删除消息：messageIds={}", messageIds);
        for (Long messageId : messageIds) {
            deleteMessage(messageId);
        }
    }
}

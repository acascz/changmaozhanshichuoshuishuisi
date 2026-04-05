package com.pdd.mall.service;

import com.pdd.mall.entity.ChatGroup;
import com.pdd.mall.entity.ChatSession;
import com.pdd.mall.entity.ChatSessionMember;
import com.pdd.mall.mapper.ChatGroupMapper;
import com.pdd.mall.mapper.ChatSessionMapper;
import com.pdd.mall.mapper.ChatSessionMemberMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 群聊服务类
 */
@Slf4j
@Service
public class ChatGroupService {
    
    @Autowired
    private ChatGroupMapper chatGroupMapper;
    
    @Autowired
    private ChatSessionMapper chatSessionMapper;
    
    @Autowired
    private ChatSessionMemberMapper chatSessionMemberMapper;
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    /**
     * 创建群聊
     */
    @Transactional
    public ChatGroup createGroup(Long creatorId, String groupName, String groupAvatar, List<Long> memberIds) {
        try {
            log.info("创建群聊：creatorId={}, groupName={}, memberCount={}", creatorId, groupName, memberIds.size());
            
            // 生成群号
            String groupNo = generateGroupNo();
            
            // 创建群聊记录
            ChatGroup group = new ChatGroup();
            group.setGroupNo(groupNo);
            group.setGroupName(groupName);
            group.setGroupAvatar(groupAvatar);
            group.setCreatorId(creatorId);
            group.setMaxMembers(500); // 默认 500 人
            group.setMemberCount(memberIds.size() + 1);
            group.setStatus(1);
            group.setCreateTime(LocalDateTime.now());
            
            chatGroupMapper.insert(group);
            
            // 创建会话
            ChatSession session = new ChatSession();
            session.setSessionId("group_" + group.getGroupId());
            session.setSessionType(2); // 群聊
            session.setSessionName(groupName);
            session.setSessionAvatar(groupAvatar);
            session.setCreatorId(creatorId);
            chatSessionMapper.insert(session);
            
            // 添加所有成员（包括创建者）
            List<ChatSessionMember> members = new ArrayList<>();
            
            // 创建者是群主
            ChatSessionMember creatorMember = new ChatSessionMember();
            creatorMember.setSessionId(session.getSessionId());
            creatorMember.setUserId(creatorId);
            creatorMember.setRole(2); // 群主
            creatorMember.setJoinTime(LocalDateTime.now());
            members.add(creatorMember);
            
            // 其他成员
            for (Long memberId : memberIds) {
                ChatSessionMember member = new ChatSessionMember();
                member.setSessionId(session.getSessionId());
                member.setUserId(memberId);
                member.setRole(1); // 普通成员
                member.setJoinTime(LocalDateTime.now());
                members.add(member);
            }
            
            chatSessionMemberMapper.batchInsert(members);
            
            // 清除群聊列表缓存
            redisTemplate.delete("chat:groups:user:" + creatorId);
            
            log.info("群聊创建成功：groupId={}, groupNo={}", group.getGroupId(), groupNo);
            return group;
            
        } catch (Exception e) {
            log.error("创建群聊失败", e);
            throw new RuntimeException("创建群聊失败：" + e.getMessage());
        }
    }
    
    /**
     * 加入群聊
     */
    @Transactional
    public void joinGroup(Long groupId, Long userId) {
        try {
            log.info("加入群聊：groupId={}, userId={}", groupId, userId);
            
            // 查询群聊
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 检查是否已在群聊中
            String sessionId = "group_" + groupId;
            if (chatSessionMemberMapper.exists(sessionId, userId)) {
                throw new RuntimeException("已在群聊中");
            }
            
            // 检查人数限制
            if (group.getMemberCount() >= group.getMaxMembers()) {
                throw new RuntimeException("群聊人数已满");
            }
            
            // 添加成员
            ChatSessionMember member = new ChatSessionMember();
            member.setSessionId(sessionId);
            member.setUserId(userId);
            member.setRole(1); // 普通成员
            member.setJoinTime(LocalDateTime.now());
            
            chatSessionMemberMapper.insert(member);
            
            // 更新群聊人数
            chatGroupMapper.updateMemberCount(groupId, group.getMemberCount() + 1);
            
            // 清除缓存
            clearGroupCache(groupId);
            redisTemplate.delete("chat:groups:user:" + userId);
            
            log.info("加入群聊成功：groupId={}, userId={}", groupId, userId);
            
        } catch (Exception e) {
            log.error("加入群聊失败", e);
            throw new RuntimeException("加入群聊失败：" + e.getMessage());
        }
    }
    
    /**
     * 退出群聊
     */
    @Transactional
    public void leaveGroup(Long groupId, Long userId) {
        try {
            log.info("退出群聊：groupId={}, userId={}", groupId, userId);
            
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 群主不能退出（只能转让或解散）
            if (group.getCreatorId().equals(userId)) {
                throw new RuntimeException("群主不能退出群聊，请先转让群主或解散群聊");
            }
            
            String sessionId = "group_" + groupId;
            
            // 删除成员
            chatSessionMemberMapper.delete(sessionId, userId);
            
            // 更新群聊人数
            chatGroupMapper.updateMemberCount(groupId, group.getMemberCount() - 1);
            
            // 清除缓存
            clearGroupCache(groupId);
            redisTemplate.delete("chat:groups:user:" + userId);
            
            log.info("退出群聊成功：groupId={}, userId={}", groupId, userId);
            
        } catch (Exception e) {
            log.error("退出群聊失败", e);
            throw new RuntimeException("退出群聊失败：" + e.getMessage());
        }
    }
    
    /**
     * 解散群聊
     */
    @Transactional
    public void dismissGroup(Long groupId, Long operatorId) {
        try {
            log.info("解散群聊：groupId={}, operatorId={}", groupId, operatorId);
            
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 只有群主可以解散
            if (!group.getCreatorId().equals(operatorId)) {
                throw new RuntimeException("只有群主可以解散群聊");
            }
            
            String sessionId = "group_" + groupId;
            
            // 删除所有成员
            chatSessionMemberMapper.deleteBySessionId(sessionId);
            
            // 删除会话
            chatSessionMapper.delete(sessionId);
            
            // 删除群聊
            chatGroupMapper.delete(groupId);
            
            // 清除缓存
            clearGroupCache(groupId);
            
            log.info("解散群聊成功：groupId={}", groupId);
            
        } catch (Exception e) {
            log.error("解散群聊失败", e);
            throw new RuntimeException("解散群聊失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取用户的群聊列表
     */
    public List<ChatGroup> getUserGroups(Long userId) {
        try {
            // 先从 Redis 缓存获取
            String cacheKey = "chat:groups:user:" + userId;
            List<ChatGroup> cachedGroups = (List<ChatGroup>) redisTemplate.opsForValue().get(cacheKey);
            if (cachedGroups != null) {
                log.info("从 Redis 缓存获取用户群聊列表：userId={}", userId);
                return cachedGroups;
            }
            
            // 从数据库获取
            List<ChatGroup> groups = chatGroupMapper.findUserGroups(userId);
            
            // 存入 Redis 缓存，过期时间 10 分钟
            if (groups != null && !groups.isEmpty()) {
                redisTemplate.opsForValue().set(cacheKey, groups, 10, TimeUnit.MINUTES);
                log.info("从数据库获取用户群聊列表并缓存：userId={}, count={}", userId, groups.size());
            }
            
            return groups;
        } catch (Exception e) {
            log.error("获取群聊列表失败", e);
            throw new RuntimeException("获取群聊列表失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取群聊详情
     */
    public ChatGroup getGroupDetail(Long groupId) {
        try {
            // 先从 Redis 缓存获取
            String cacheKey = "chat:group:" + groupId;
            ChatGroup cachedGroup = (ChatGroup) redisTemplate.opsForValue().get(cacheKey);
            if (cachedGroup != null) {
                log.info("从 Redis 缓存获取群聊：groupId={}", groupId);
                return cachedGroup;
            }
            
            // 从数据库获取
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 存入 Redis 缓存，过期时间 30 分钟
            redisTemplate.opsForValue().set(cacheKey, group, 30, TimeUnit.MINUTES);
            log.info("从数据库获取群聊并缓存：groupId={}", groupId);
            
            return group;
        } catch (Exception e) {
            log.error("获取群聊详情失败", e);
            throw new RuntimeException("获取群聊详情失败：" + e.getMessage());
        }
    }
    
    /**
     * 清除群聊缓存
     */
    private void clearGroupCache(Long groupId) {
        String cacheKey = "chat:group:" + groupId;
        redisTemplate.delete(cacheKey);
        log.info("清除群聊缓存：groupId={}", groupId);
    }
    
    /**
     * 更新群公告
     */
    @Transactional
    public void updateGroupNotice(Long groupId, Long userId, String notice) {
        try {
            log.info("更新群公告：groupId={}, userId={}, notice={}", groupId, userId, notice);
            
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 只有群主或管理员可以更新公告
            String sessionId = "group_" + groupId;
            ChatSessionMember member = chatSessionMemberMapper.findByUserAndSession(userId, sessionId);
            if (member == null || member.getRole() < 1) {
                throw new RuntimeException("没有权限更新群公告");
            }
            
            // 更新群公告
            group.setGroupNotice(notice);
            chatGroupMapper.update(group);
            
            // 清除缓存
            clearGroupCache(groupId);
            
            log.info("更新群公告成功：groupId={}", groupId);
            
        } catch (Exception e) {
            log.error("更新群公告失败", e);
            throw new RuntimeException("更新群公告失败：" + e.getMessage());
        }
    }
    
    /**
     * 转让群主
     */
    @Transactional
    public void transferOwnership(Long groupId, Long currentOwnerId, Long newOwnerId) {
        try {
            log.info("转让群主：groupId={}, from={}, to={}", groupId, currentOwnerId, newOwnerId);
            
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 验证当前用户是群主
            if (!group.getCreatorId().equals(currentOwnerId)) {
                throw new RuntimeException("只有现任群主可以转让");
            }
            
            // 验证新群主是群成员
            String sessionId = "group_" + groupId;
            if (!chatSessionMemberMapper.exists(sessionId, newOwnerId)) {
                throw new RuntimeException("新群主必须是群成员");
            }
            
            // 更新群主
            group.setCreatorId(newOwnerId);
            chatGroupMapper.update(group);
            
            // 更新成员角色
            chatSessionMemberMapper.updateRole(sessionId, currentOwnerId, 1); // 原群主变为管理员
            chatSessionMemberMapper.updateRole(sessionId, newOwnerId, 2); // 新群主设为群主
            
            // 清除缓存
            clearGroupCache(groupId);
            
            log.info("转让群主成功：groupId={}, to={}", groupId, newOwnerId);
            
        } catch (Exception e) {
            log.error("转让群主失败", e);
            throw new RuntimeException("转让群主失败：" + e.getMessage());
        }
    }
    
    /**
     * 移除群成员
     */
    @Transactional
    public void removeMember(Long groupId, Long operatorId, Long memberId) {
        try {
            log.info("移除群成员：groupId={}, operatorId={}, memberId={}", groupId, operatorId, memberId);
            
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 验证操作权限（群主或管理员）
            String sessionId = "group_" + groupId;
            ChatSessionMember operator = chatSessionMemberMapper.findByUserAndSession(operatorId, sessionId);
            if (operator == null || operator.getRole() < 1) {
                throw new RuntimeException("没有权限移除成员");
            }
            
            // 不能移除群主
            if (group.getCreatorId().equals(memberId)) {
                throw new RuntimeException("不能移除群主");
            }
            
            // 移除成员
            chatSessionMemberMapper.delete(sessionId, memberId);
            
            // 更新群聊人数
            chatGroupMapper.updateMemberCount(groupId, group.getMemberCount() - 1);
            
            // 清除缓存
            clearGroupCache(groupId);
            redisTemplate.delete("chat:groups:user:" + memberId);
            
            log.info("移除群成员成功：groupId={}, memberId={}", groupId, memberId);
            
        } catch (Exception e) {
            log.error("移除群成员失败", e);
            throw new RuntimeException("移除群成员失败：" + e.getMessage());
        }
    }
    
    /**
     * 设置管理员
     */
    @Transactional
    public void setAdmin(Long groupId, Long operatorId, Long memberId) {
        try {
            log.info("设置管理员：groupId={}, operatorId={}, memberId={}", groupId, operatorId, memberId);
            
            ChatGroup group = chatGroupMapper.findById(groupId);
            if (group == null) {
                throw new RuntimeException("群聊不存在");
            }
            
            // 只有群主可以设置管理员
            if (!group.getCreatorId().equals(operatorId)) {
                throw new RuntimeException("只有群主可以设置管理员");
            }
            
            String sessionId = "group_" + groupId;
            
            // 设置管理员
            chatSessionMemberMapper.updateRole(sessionId, memberId, 1);
            
            log.info("设置管理员成功：groupId={}, memberId={}", groupId, memberId);
            
        } catch (Exception e) {
            log.error("设置管理员失败", e);
            throw new RuntimeException("设置管理员失败：" + e.getMessage());
        }
    }
    
    /**
     * 生成群号
     */
    private String generateGroupNo() {
        return "G" + System.currentTimeMillis() + (int)(Math.random() * 1000);
    }
}

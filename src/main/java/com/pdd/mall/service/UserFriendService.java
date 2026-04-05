package com.pdd.mall.service;

import com.pdd.mall.entity.UserFriend;
import com.pdd.mall.mapper.UserFriendMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 好友服务类
 */
@Slf4j
@Service
public class UserFriendService {
    
    @Autowired
    private UserFriendMapper userFriendMapper;
    
    /**
     * 获取用户好友列表
     */
    public List<Map<String, Object>> getUserFriends(Long userId) {
        log.info("获取用户好友列表：userId={}", userId);
        return userFriendMapper.selectUserFriends(userId);
    }
    
    /**
     * 添加好友
     */
    @Transactional
    public boolean addFriend(Long userId, Long friendId, String remark) {
        try {
            log.info("添加好友：userId={}, friendId={}, remark={}", userId, friendId, remark);
            
            // 检查是否已是好友
            UserFriend existing = userFriendMapper.selectByUserIdAndFriendId(userId, friendId);
            if (existing != null && existing.getFriendStatus() == 1) {
                throw new RuntimeException("已是好友");
            }
            
            // 创建好友关系
            UserFriend userFriend = new UserFriend();
            userFriend.setUserId(userId);
            userFriend.setFriendId(friendId);
            userFriend.setFriendRemark(remark);
            userFriend.setFriendStatus(1);
            userFriend.setIsStar(0);
            
            userFriendMapper.insert(userFriend);
            
            // 创建反向好友关系（双向好友）
            UserFriend reverseFriend = new UserFriend();
            reverseFriend.setUserId(friendId);
            reverseFriend.setFriendId(userId);
            reverseFriend.setFriendRemark(null);
            reverseFriend.setFriendStatus(1);
            reverseFriend.setIsStar(0);
            
            userFriendMapper.insert(reverseFriend);
            
            log.info("添加好友成功");
            return true;
            
        } catch (Exception e) {
            log.error("添加好友失败", e);
            throw new RuntimeException("添加好友失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除好友
     */
    @Transactional
    public boolean deleteFriend(Long userId, Long friendId) {
        try {
            log.info("删除好友：userId={}, friendId={}", userId, friendId);
            
            // 删除自己的好友记录
            userFriendMapper.delete(userId, friendId);
            
            // 删除反向好友记录
            userFriendMapper.delete(friendId, userId);
            
            log.info("删除好友成功");
            return true;
            
        } catch (Exception e) {
            log.error("删除好友失败", e);
            throw new RuntimeException("删除好友失败：" + e.getMessage());
        }
    }
    
    /**
     * 更新好友备注
     */
    @Transactional
    public boolean updateRemark(Long userId, Long friendId, String remark) {
        try {
            log.info("更新好友备注：userId={}, friendId={}, remark={}", userId, friendId, remark);
            
            int rows = userFriendMapper.updateRemark(userId, friendId, remark);
            
            log.info("更新好友备注成功");
            return rows > 0;
            
        } catch (Exception e) {
            log.error("更新好友备注失败", e);
            throw new RuntimeException("更新好友备注失败：" + e.getMessage());
        }
    }
    
    /**
     * 设置星标好友
     */
    @Transactional
    public boolean setStarStatus(Long userId, Long friendId, boolean isStar) {
        try {
            log.info("设置星标好友：userId={}, friendId={}, isStar={}", userId, friendId, isStar);
            
            int rows = userFriendMapper.updateStarStatus(userId, friendId, isStar ? 1 : 0);
            
            log.info("设置星标好友成功");
            return rows > 0;
            
        } catch (Exception e) {
            log.error("设置星标好友失败", e);
            throw new RuntimeException("设置星标好友失败：" + e.getMessage());
        }
    }
}

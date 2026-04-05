package com.pdd.mall.service;

import com.pdd.mall.entity.User;
import com.pdd.mall.entity.UserFriend;
import com.pdd.mall.mapper.UserFriendMapper;
import com.pdd.mall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private UserFriendMapper userFriendMapper;

    public User findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    public User save(User user) {
        if (user.getId() == null) {
            userMapper.insert(user);
        } else {
            userMapper.update(user);
        }
        return user;
    }

    public User login(String username, String password) {
        User user = userMapper.findByUsername(username);
        String encryptedPassword = DigestUtils.md5DigestAsHex(password.getBytes());
        if (user != null && user.getPassword().equals(encryptedPassword)) {
            user.setPassword(null);
            return user;
        }
        return null;
    }

    public User register(String username, String password, String nickname) {
        User existUser = userMapper.findByUsername(username);
        if (existUser != null) {
            return null;
        }
        User user = new User();
        user.setUsername(username);
        // 如果密码为空，生成随机密码（用于验证码登录用户后续设置密码）
        if (password == null || password.isEmpty()) {
            user.setPassword(DigestUtils.md5DigestAsHex(("temp_" + System.currentTimeMillis()).getBytes()));
        } else {
            user.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        }
        user.setNickname(nickname != null ? nickname : username);
        user.setAvatar("/images/mine/avatar-default.jpg");
        userMapper.insert(user);
        user.setPassword(null);
        return user;
    }

    public User getUserById(Long id) {
        User user = userMapper.findById(id);
        if (user != null) {
            user.setPassword(null);
        }
        return user;
    }

    public User updateUser(User user) {
        userMapper.update(user);
        return getUserById(user.getId());
    }

    /**
     * 搜索用户
     */
    public List<Map<String, Object>> searchUsers(String keyword, Long currentUserId) {
        List<User> users = userMapper.searchByKeyword(keyword);
        List<Map<String, Object>> result = new ArrayList<>();
        
        for (User user : users) {
            // 排除自己
            if (currentUserId != null && user.getId().equals(currentUserId)) {
                continue;
            }
            
            Map<String, Object> userInfo = new HashMap<>();
            userInfo.put("id", user.getId());
            userInfo.put("username", user.getUsername());
            userInfo.put("nickname", user.getNickname());
            userInfo.put("avatar", user.getAvatar());
            
            // 检查是否已经是好友
            if (currentUserId != null) {
                UserFriend friend = userFriendMapper.selectByUserIdAndFriendId(currentUserId, user.getId());
                userInfo.put("isFriend", friend != null);
            }
            
            result.add(userInfo);
        }
        
        return result;
    }

    /**
     * 获取用户详情
     */
    public Map<String, Object> getUserDetail(Long userId) {
        User user = userMapper.findById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("id", user.getId());
        result.put("username", user.getUsername());
        result.put("nickname", user.getNickname());
        result.put("avatar", user.getAvatar());
        
        return result;
    }
}

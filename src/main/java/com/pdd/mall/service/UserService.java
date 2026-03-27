package com.pdd.mall.service;

import com.pdd.mall.entity.User;
import com.pdd.mall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public User login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
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
        user.setPassword(password);
        user.setNickname(nickname != null ? nickname : username);
        user.setAvatar("https://api.dicebear.com/7.x/avataaars/svg?seed=" + username);
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
}

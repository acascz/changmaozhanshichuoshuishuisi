package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.User;
import com.pdd.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result<User> login(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String password = params.get("password");
        User user = userService.login(username, password);
        if (user != null) {
            return Result.success(user);
        }
        return Result.error("用户名或密码错误");
    }

    @PostMapping("/register")
    public Result<User> register(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String password = params.get("password");
        String nickname = params.get("nickname");
        User user = userService.register(username, password, nickname);
        if (user != null) {
            return Result.success(user);
        }
        return Result.error("用户名已存在");
    }

    @GetMapping("/info/{id}")
    public Result<User> getUserInfo(@PathVariable Long id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return Result.success(user);
        }
        return Result.error("用户不存在");
    }

    @PutMapping("/update")
    public Result<User> updateUser(@RequestBody User user) {
        return Result.success(userService.updateUser(user));
    }

    @PutMapping("/updateProfile")
    public Result<User> updateProfile(@RequestBody Map<String, String> params) {
        Long userId = Long.valueOf(params.get("userId"));
        String nickname = params.get("nickname");
        String avatar = params.get("avatar");
        String headerBackground = params.get("headerBackground");
        
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }
        
        if (nickname != null) user.setNickname(nickname);
        if (avatar != null) user.setAvatar(avatar);
        if (headerBackground != null) user.setHeaderBackground(headerBackground);
        
        return Result.success(userService.updateUser(user));
    }
    
    /**
     * 上传用户头像或背景图片
     */
    @PostMapping("/uploadImage")
    public Result<Map<String, String>> uploadUserImage(
            @RequestParam("file") MultipartFile file,
            @RequestParam("userId") Long userId,
            @RequestParam("type") String type) {
        
        try {
            if (file.isEmpty()) {
                return Result.error("文件不能为空");
            }
            
            // 验证文件类型
            String contentType = file.getContentType();
            if (!contentType.startsWith("image/")) {
                return Result.error("只能上传图片文件");
            }
            
            // 使用绝对路径创建用户图片目录
            String baseDir = System.getProperty("user.dir");
            String userDir = baseDir + "\\src\\main\\resources\\static\\images\\user\\" + userId + "\\" + type + "\\";
            File dir = new File(userDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 生成文件名
            String originalFilename = file.getOriginalFilename();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = System.currentTimeMillis() + fileExtension;
            
            // 保存文件
            File destFile = new File(dir, fileName);
            file.transferTo(destFile);
            
            // 返回相对路径（用于前端访问）
            String filePath = "/images/user/" + userId + "/" + type + "/" + fileName;
            
            Map<String, String> result = new HashMap<>();
            result.put("filePath", filePath);
            result.put("fileName", fileName);
            
            return Result.success(result);
            
        } catch (IOException e) {
            return Result.error("文件上传失败：" + e.getMessage());
        }
    }
}
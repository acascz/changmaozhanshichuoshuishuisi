package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.User;
import com.pdd.mall.entity.UserBrowseHistory;
import com.pdd.mall.service.UserService;
import com.pdd.mall.service.UserBrowseHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserBrowseHistoryService userBrowseHistoryService;

    @PostMapping("/login")
    public Result<User> login(@RequestBody Map<String, String> params, HttpServletRequest request) {
        String loginType = params.get("loginType");
        System.out.println("登录类型：" + loginType + ", 参数：" + params);
        
        // 验证码登录
        if ("code".equals(loginType)) {
            String phone = params.get("phone");
            String code = params.get("code");
            
            if (phone == null || code == null) {
                return Result.error("参数错误");
            }
            
            // 先验证验证码
            Result<Boolean> verifyResult = verifyCode(phone, code);
            if (verifyResult.getCode() != 200) {
                return Result.error(verifyResult.getMessage());
            }
            
            // 验证码正确，查找用户
            User user = userService.findByUsername(phone);
            if (user == null) {
                // 新用户，自动注册
                user = userService.register(phone, null, "用户" + phone.substring(phone.length() - 4));
            }
            
            if (user != null) {
                // 设置 Session
                request.getSession().setAttribute("user", user);
                return Result.success(user);
            }
            return Result.error("登录失败");
        } 
        // 密码登录
        else {
            String username = params.get("username");
            String password = params.get("password");
            
            if (username == null || username.isEmpty()) {
                username = params.get("account");
            }
            
            if (password == null || password.isEmpty()) {
                return Result.error("密码不能为空");
            }
            
            User user = userService.login(username, password);
            if (user != null) {
                // 设置 Session
                request.getSession().setAttribute("user", user);
                return Result.success(user);
            }
            return Result.error("用户名或密码错误");
        }
    }
    
    /**
     * 验证验证码（调用 AuthController）
     */
    private Result<Boolean> verifyCode(String phone, String code) {
        try {
            Map<String, String> params = new HashMap<>();
            params.put("phone", phone);
            params.put("code", code);
            
            // 直接调用 AuthController 的验证逻辑
            String storedCode = com.pdd.mall.controller.AuthController.getVerificationCode(phone);
            if (storedCode == null) {
                return Result.error("验证码已过期");
            }
            if (!storedCode.equals(code)) {
                return Result.error("验证码错误");
            }
            // 验证成功后删除验证码
            com.pdd.mall.controller.AuthController.removeVerificationCode(phone);
            return Result.success(true);
        } catch (Exception e) {
            return Result.error("验证码验证失败");
        }
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
    
    @GetMapping("/userinfo")
    public Result<User> getUserInfoByParam(@RequestParam Long userId) {
        User user = userService.getUserById(userId);
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
        if (avatar != null) {
            deleteOldImage(user.getAvatar());
            user.setAvatar(avatar);
        }
        if (headerBackground != null) {
            deleteOldImage(user.getHeaderBackground());
            user.setHeaderBackground(headerBackground);
        }
        
        return Result.success(userService.updateUser(user));
    }
    
    private void deleteOldImage(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return;
        }
        
        if (imagePath.startsWith("/images/user/")) {
            String baseDir = System.getProperty("user.dir");
            String fullPath = baseDir + "\\src\\main\\resources" + imagePath.replace("/", "\\");
            File file = new File(fullPath);
            if (file.exists()) {
                file.delete();
            }
        }
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
            
            User user = userService.getUserById(userId);
            if (user == null) {
                return Result.error("用户不存在");
            }
            
            String oldImagePath = null;
            if ("avatar".equals(type)) {
                oldImagePath = user.getAvatar();
            } else if ("header".equals(type)) {
                oldImagePath = user.getHeaderBackground();
            }
            
            if (oldImagePath != null && !oldImagePath.isEmpty()) {
                deleteOldImage(oldImagePath);
            }
            
            // 验证文件类型
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
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
            String fileExtension = originalFilename != null && originalFilename.contains(".") 
                    ? originalFilename.substring(originalFilename.lastIndexOf(".")) 
                    : ".jpg";
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

    /**
     * 记录用户浏览历史（商品详情页调用）
     */
    @PostMapping("/recordBrowseHistory")
    public Result<Void> recordBrowseHistory(
            @RequestParam Long userId,
            @RequestParam Long productId) {
        try {
            userBrowseHistoryService.recordBrowseHistory(userId, productId);
            return Result.success(null);
        } catch (Exception e) {
            return Result.error("记录浏览历史失败：" + e.getMessage());
        }
    }

    /**
     * 获取用户的浏览记录（个人中心）
     */
    @GetMapping("/browseHistory")
    public Result<Map<String, Object>> getBrowseHistory(
            @RequestParam Long userId,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer size) {
        try {
            Map<String, Object> result = userBrowseHistoryService.getBrowseHistory(userId, page, size);
            return Result.success(result);
        } catch (Exception e) {
            return Result.error("获取浏览记录失败：" + e.getMessage());
        }
    }

    /**
     * 获取用户最近的浏览记录（简化版）
     */
    @GetMapping("/recentBrowseHistory")
    public Result<List<UserBrowseHistory>> getRecentBrowseHistory(
            @RequestParam Long userId,
            @RequestParam(defaultValue = "10") Integer limit) {
        try {
            List<UserBrowseHistory> historyList = userBrowseHistoryService.getRecentHistory(userId, limit);
            return Result.success(historyList);
        } catch (Exception e) {
            return Result.error("获取浏览记录失败：" + e.getMessage());
        }
    }

    /**
     * 搜索用户
     */
    @GetMapping("/search")
    public Result<List<Map<String, Object>>> searchUser(
            @RequestParam String keyword,
            @RequestParam(required = false) Long currentUserId) {
        try {
            List<Map<String, Object>> users = userService.searchUsers(keyword, currentUserId);
            return Result.success(users);
        } catch (Exception e) {
            return Result.error("搜索失败：" + e.getMessage());
        }
    }

    /**
     * 获取用户详情
     */
    @GetMapping("/detail/{userId}")
    public Result<Map<String, Object>> getUserDetail(@PathVariable Long userId) {
        try {
            Map<String, Object> userInfo = userService.getUserDetail(userId);
            return Result.success(userInfo);
        } catch (Exception e) {
            return Result.error("获取用户详情失败：" + e.getMessage());
        }
    }

    /**
     * 清空用户的浏览记录
     */
    @PostMapping("/clearBrowseHistory")
    public Result<Void> clearBrowseHistory(@RequestParam Long userId) {
        try {
            userBrowseHistoryService.clearHistory(userId);
            return Result.success(null);
        } catch (Exception e) {
            return Result.error("清空浏览记录失败：" + e.getMessage());
        }
    }
}
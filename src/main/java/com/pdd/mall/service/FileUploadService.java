package com.pdd.mall.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * 文件上传服务
 * 支持图片、语音、视频等文件上传
 */
@Service
public class FileUploadService {
    
    private static final Logger log = LoggerFactory.getLogger(FileUploadService.class);
    
    @Value("${file.upload.path:./uploads}")
    private String uploadPath;
    
    @Value("${file.server.url:http://localhost:8080}")
    private String serverUrl;
    
    // 允许的文件类型
    private static final String[] ALLOWED_IMAGE_TYPES = {"image/jpeg", "image/png", "image/gif", "image/webp"};
    private static final String[] ALLOWED_AUDIO_TYPES = {"audio/mp3", "audio/wav", "audio/amr", "audio/m4a"};
    private static final String[] ALLOWED_VIDEO_TYPES = {"video/mp4", "video/mov", "video/avi", "video/webm"};
    
    // 文件大小限制（字节）
    private static final long MAX_IMAGE_SIZE = 10 * 1024 * 1024; // 10MB
    private static final long MAX_AUDIO_SIZE = 30 * 1024 * 1024; // 30MB
    private static final long MAX_VIDEO_SIZE = 100 * 1024 * 1024; // 100MB
    
    /**
     * 上传图片文件
     */
    public UploadResult uploadImage(MultipartFile file) {
        try {
            log.info("开始上传图片：filename={}, size={}", file.getOriginalFilename(), file.getSize());
            
            // 验证文件类型
            if (!isAllowedType(file.getContentType(), ALLOWED_IMAGE_TYPES)) {
                return UploadResult.error("不支持的图片格式");
            }
            
            // 验证文件大小
            if (file.getSize() > MAX_IMAGE_SIZE) {
                return UploadResult.error("图片大小不能超过 10MB");
            }
            
            // 生成文件名
            String fileName = generateFileName(file.getOriginalFilename());
            String relativePath = generateRelativePath("images");
            String fullPath = uploadPath + "/" + relativePath;
            
            // 创建目录
            File dir = new File(fullPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 保存文件
            Path filePath = Paths.get(fullPath + "/" + fileName);
            Files.write(filePath, file.getBytes());
            
            // 生成访问 URL
            String fileUrl = serverUrl + "/uploads/" + relativePath + "/" + fileName;
            
            log.info("图片上传成功：url={}", fileUrl);
            
            return UploadResult.success(fileUrl, fileName, file.getSize());
        } catch (Exception e) {
            log.error("图片上传失败", e);
            return UploadResult.error("上传失败：" + e.getMessage());
        }
    }
    
    /**
     * 上传语音文件
     */
    public UploadResult uploadAudio(MultipartFile file) {
        try {
            log.info("开始上传语音：filename={}, size={}", file.getOriginalFilename(), file.getSize());
            
            // 验证文件类型
            if (!isAllowedType(file.getContentType(), ALLOWED_AUDIO_TYPES)) {
                return UploadResult.error("不支持的语音格式");
            }
            
            // 验证文件大小
            if (file.getSize() > MAX_AUDIO_SIZE) {
                return UploadResult.error("语音大小不能超过 30MB");
            }
            
            // 生成文件名和路径
            String fileName = generateFileName(file.getOriginalFilename());
            String relativePath = generateRelativePath("audio");
            String fullPath = uploadPath + "/" + relativePath;
            
            // 创建目录
            File dir = new File(fullPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 保存文件
            Path filePath = Paths.get(fullPath + "/" + fileName);
            Files.write(filePath, file.getBytes());
            
            // 生成访问 URL
            String fileUrl = serverUrl + "/uploads/" + relativePath + "/" + fileName;
            
            log.info("语音上传成功：url={}", fileUrl);
            
            return UploadResult.success(fileUrl, fileName, file.getSize());
        } catch (Exception e) {
            log.error("语音上传失败", e);
            return UploadResult.error("上传失败：" + e.getMessage());
        }
    }
    
    /**
     * 上传视频文件
     */
    public UploadResult uploadVideo(MultipartFile file) {
        try {
            log.info("开始上传视频：filename={}, size={}", file.getOriginalFilename(), file.getSize());
            
            // 验证文件类型
            if (!isAllowedType(file.getContentType(), ALLOWED_VIDEO_TYPES)) {
                return UploadResult.error("不支持的视频格式");
            }
            
            // 验证文件大小
            if (file.getSize() > MAX_VIDEO_SIZE) {
                return UploadResult.error("视频大小不能超过 100MB");
            }
            
            // 生成文件名和路径
            String fileName = generateFileName(file.getOriginalFilename());
            String relativePath = generateRelativePath("video");
            String fullPath = uploadPath + "/" + relativePath;
            
            // 创建目录
            File dir = new File(fullPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 保存文件
            Path filePath = Paths.get(fullPath + "/" + fileName);
            Files.write(filePath, file.getBytes());
            
            // 生成访问 URL
            String fileUrl = serverUrl + "/uploads/" + relativePath + "/" + fileName;
            
            log.info("视频上传成功：url={}", fileUrl);
            
            return UploadResult.success(fileUrl, fileName, file.getSize());
        } catch (Exception e) {
            log.error("视频上传失败", e);
            return UploadResult.error("上传失败：" + e.getMessage());
        }
    }
    
    /**
     * 验证文件类型
     */
    private boolean isAllowedType(String contentType, String[] allowedTypes) {
        if (contentType == null || contentType.isEmpty()) {
            return false;
        }
        for (String allowedType : allowedTypes) {
            if (allowedType.equals(contentType)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * 生成唯一文件名
     */
    private String generateFileName(String originalFilename) {
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        return UUID.randomUUID().toString().replace("-", "") + extension;
    }
    
    /**
     * 生成相对路径（按日期分类）
     */
    private String generateRelativePath(String type) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        String datePath = sdf.format(new Date());
        return type + "/" + datePath;
    }
    
    /**
     * 上传结果
     */
    public static class UploadResult {
        private boolean success;
        private String url;
        private String filename;
        private Long size;
        private String error;
        
        public static UploadResult success(String url, String filename, Long size) {
            UploadResult result = new UploadResult();
            result.success = true;
            result.url = url;
            result.filename = filename;
            result.size = size;
            return result;
        }
        
        public static UploadResult error(String error) {
            UploadResult result = new UploadResult();
            result.success = false;
            result.error = error;
            return result;
        }
        
        // Getters and Setters
        public boolean isSuccess() {
            return success;
        }
        
        public void setSuccess(boolean success) {
            this.success = success;
        }
        
        public String getUrl() {
            return url;
        }
        
        public void setUrl(String url) {
            this.url = url;
        }
        
        public String getFilename() {
            return filename;
        }
        
        public void setFilename(String filename) {
            this.filename = filename;
        }
        
        public Long getSize() {
            return size;
        }
        
        public void setSize(Long size) {
            this.size = size;
        }
        
        public String getError() {
            return error;
        }
        
        public void setError(String error) {
            this.error = error;
        }
    }
}

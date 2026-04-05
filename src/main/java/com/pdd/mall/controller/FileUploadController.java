package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.service.FileUploadService;
import com.pdd.mall.service.FileUploadService.UploadResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

/**
 * 文件上传控制器
 */
@RestController
@RequestMapping("/api/file")
@CrossOrigin(origins = "*")
public class FileUploadController {
    
    private static final Logger log = LoggerFactory.getLogger(FileUploadController.class);
    
    @Autowired
    private FileUploadService fileUploadService;
    
    /**
     * 上传图片
     */
    @PostMapping("/upload/image")
    public Result<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file) {
        try {
            log.info("接收到图片上传请求：filename={}, size={}", file.getOriginalFilename(), file.getSize());
            
            UploadResult result = fileUploadService.uploadImage(file);
            
            if (result.isSuccess()) {
                Map<String, Object> data = new HashMap<>();
                data.put("url", result.getUrl());
                data.put("filename", result.getFilename());
                data.put("size", result.getSize());
                
                log.info("图片上传成功：url={}", result.getUrl());
                return Result.success(data);
            } else {
                log.warn("图片上传失败：error={}", result.getError());
                return Result.error(result.getError());
            }
        } catch (Exception e) {
            log.error("图片上传异常", e);
            return Result.error("上传失败：" + e.getMessage());
        }
    }
    
    /**
     * 上传语音
     */
    @PostMapping("/upload/audio")
    public Result<Map<String, Object>> uploadAudio(@RequestParam("file") MultipartFile file) {
        try {
            log.info("接收到语音上传请求：filename={}, size={}", file.getOriginalFilename(), file.getSize());
            
            UploadResult result = fileUploadService.uploadAudio(file);
            
            if (result.isSuccess()) {
                Map<String, Object> data = new HashMap<>();
                data.put("url", result.getUrl());
                data.put("filename", result.getFilename());
                data.put("size", result.getSize());
                
                log.info("语音上传成功：url={}", result.getUrl());
                return Result.success(data);
            } else {
                log.warn("语音上传失败：error={}", result.getError());
                return Result.error(result.getError());
            }
        } catch (Exception e) {
            log.error("语音上传异常", e);
            return Result.error("上传失败：" + e.getMessage());
        }
    }
    
    /**
     * 上传视频
     */
    @PostMapping("/upload/video")
    public Result<Map<String, Object>> uploadVideo(@RequestParam("file") MultipartFile file) {
        try {
            log.info("接收到视频上传请求：filename={}, size={}", file.getOriginalFilename(), file.getSize());
            
            UploadResult result = fileUploadService.uploadVideo(file);
            
            if (result.isSuccess()) {
                Map<String, Object> data = new HashMap<>();
                data.put("url", result.getUrl());
                data.put("filename", result.getFilename());
                data.put("size", result.getSize());
                
                log.info("视频上传成功：url={}", result.getUrl());
                return Result.success(data);
            } else {
                log.warn("视频上传失败：error={}", result.getError());
                return Result.error(result.getError());
            }
        } catch (Exception e) {
            log.error("视频上传异常", e);
            return Result.error("上传失败：" + e.getMessage());
        }
    }
}

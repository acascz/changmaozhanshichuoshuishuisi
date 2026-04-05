package com.pdd.mall.controller;

import com.pdd.mall.entity.ImageFile;
import com.pdd.mall.service.ImageFileService;
import com.pdd.mall.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/image")
@CrossOrigin(origins = "*")
public class ImageFileController {
    
    @Autowired
    private ImageFileService imageFileService;
    
    /**
     * 上传图片
     */
    @PostMapping("/upload")
    public Result<ImageFile> uploadImage(
            @RequestParam("file") MultipartFile file,
            @RequestParam("category") String category,
            @RequestParam(value = "relatedId", required = false) String relatedId,
            @RequestParam(value = "sortOrder", defaultValue = "0") Integer sortOrder) {
        
        try {
            if (file.isEmpty()) {
                return Result.error("文件不能为空");
            }
            
            // 验证文件类型
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                return Result.error("只能上传图片文件");
            }
            
            ImageFile imageFile = imageFileService.uploadImage(file, category, relatedId, sortOrder);
            return Result.success(imageFile);
            
        } catch (IOException e) {
            return Result.error("文件上传失败: " + e.getMessage());
        }
    }
    
    /**
     * 根据ID获取图片信息
     */
    @GetMapping("/{id}")
    public Result<ImageFile> getImageInfo(@PathVariable Long id) {
        try {
            ImageFile imageFile = imageFileService.getImageById(id);
            if (imageFile != null) {
                return Result.success(imageFile);
            } else {
                return Result.error("图片不存在");
            }
        } catch (Exception e) {
            return Result.error("获取图片信息失败");
        }
    }
    
    /**
     * 根据 ID 获取图片文件（直接返回图片数据）
     */
    @GetMapping("/file/{id}")
    public ResponseEntity<Resource> getImageFile(@PathVariable Long id) {
        try {
            ImageFile imageFile = imageFileService.getImageById(id);
            if (imageFile == null) {
                return ResponseEntity.notFound().build();
            }
            
            File file = imageFileService.getImageFile(imageFile);
            if (!file.exists()) {
                return ResponseEntity.notFound().build();
            }
            
            Resource resource = new FileSystemResource(file);
            
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(imageFile.getFileType()))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + imageFile.getOriginalName() + "\"")
                    .body(resource);
                    
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    
    /**
     * 根据分类获取图片列表
     */
    @GetMapping("/category/{category}")
    public Result<List<ImageFile>> getImagesByCategory(@PathVariable String category) {
        try {
            List<ImageFile> images = imageFileService.getImagesByCategory(category);
            return Result.success(images);
        } catch (Exception e) {
            return Result.error("获取图片列表失败");
        }
    }
    
    /**
     * 根据分类和关联ID获取图片列表
     */
    @GetMapping("/category/{category}/related/{relatedId}")
    public Result<List<ImageFile>> getImagesByCategoryAndRelatedId(
            @PathVariable String category,
            @PathVariable String relatedId) {
        try {
            List<ImageFile> images = imageFileService.getImagesByCategoryAndRelatedId(category, relatedId);
            return Result.success(images);
        } catch (Exception e) {
            return Result.error("获取图片列表失败");
        }
    }
    
    /**
     * 删除图片
     */
    @DeleteMapping("/{id}")
    public Result<String> deleteImage(@PathVariable Long id) {
        try {
            imageFileService.deleteImage(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            return Result.error("删除失败");
        }
    }
}
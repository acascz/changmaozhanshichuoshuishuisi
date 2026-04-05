package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.ImageFile;
import com.pdd.mall.service.ImageFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 轮播图控制器
 */
@RestController
@RequestMapping("/api/carousel")
@CrossOrigin
public class CarouselController {
    
    @Autowired
    private ImageFileService imageFileService;
    
    /**
     * 获取轮播图列表
     */
    @GetMapping("/list")
    public Result<List<Map<String, Object>>> list() {
        try {
            List<ImageFile> images = imageFileService.getImagesByCategory("banner");
            
            List<Map<String, Object>> result = images.stream().map(img -> {
                Map<String, Object> map = new HashMap<>();
                map.put("id", img.getId());
                map.put("imageUrl", img.getFilePath());
                map.put("title", img.getOriginalName());
                map.put("link", "");
                map.put("sortOrder", img.getSortOrder());
                return map;
            }).toList();
            
            return Result.success(result);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取轮播图失败：" + e.getMessage());
        }
    }
}

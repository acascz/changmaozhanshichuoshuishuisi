package com.pdd.mall.controller;

import com.pdd.mall.entity.Banner;
import com.pdd.mall.service.BannerService;
import com.pdd.mall.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/banner")
@CrossOrigin(origins = "*")
public class BannerController {
    
    @Autowired
    private BannerService bannerService;
    
    @GetMapping("/active")
    public Result<List<Banner>> getActiveBanners() {
        try {
            List<Banner> banners = bannerService.getActiveBanners();
            return Result.success(banners);
        } catch (Exception e) {
            return Result.error("获取轮播图失败");
        }
    }
    
    @GetMapping
    public Result<List<Banner>> getAllBanners() {
        try {
            List<Banner> banners = bannerService.getAllBanners();
            return Result.success(banners);
        } catch (Exception e) {
            return Result.error("获取轮播图列表失败");
        }
    }
    
    @GetMapping("/{id}")
    public Result<Banner> getBannerById(@PathVariable Long id) {
        try {
            Banner banner = bannerService.getBannerById(id);
            if (banner != null) {
                return Result.success(banner);
            } else {
                return Result.error("轮播图不存在");
            }
        } catch (Exception e) {
            return Result.error("获取轮播图失败");
        }
    }
    
    @PostMapping
    public Result<String> addBanner(@RequestBody Banner banner) {
        try {
            bannerService.addBanner(banner);
            return Result.success("添加轮播图成功");
        } catch (Exception e) {
            return Result.error("添加轮播图失败");
        }
    }
    
    @PutMapping
    public Result<String> updateBanner(@RequestBody Banner banner) {
        try {
            bannerService.updateBanner(banner);
            return Result.success("更新轮播图成功");
        } catch (Exception e) {
            return Result.error("更新轮播图失败");
        }
    }
    
    @DeleteMapping("/{id}")
    public Result<String> deleteBanner(@PathVariable Long id) {
        try {
            bannerService.deleteBanner(id);
            return Result.success("删除轮播图成功");
        } catch (Exception e) {
            return Result.error("删除轮播图失败");
        }
    }
}
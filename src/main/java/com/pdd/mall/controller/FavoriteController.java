package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.Product;
import com.pdd.mall.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/favorite")
@CrossOrigin
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    @GetMapping("/list/{userId}")
    public Result<List<Product>> getFavorites(@PathVariable Long userId) {
        return Result.success(favoriteService.getFavoriteProducts(userId));
    }

    @GetMapping("/check")
    public Result<Boolean> checkFavorite(@RequestParam Long userId, @RequestParam Long productId) {
        return Result.success(favoriteService.isFavorited(userId, productId));
    }

    @PostMapping("/add")
    public Result<String> addFavorite(@RequestBody Map<String, Long> params) {
        Long userId = params.get("userId");
        Long productId = params.get("productId");
        if (favoriteService.addFavorite(userId, productId)) {
            return Result.success("收藏成功");
        }
        return Result.error("已收藏");
    }

    @PostMapping("/remove")
    public Result<String> removeFavorite(@RequestBody Map<String, Long> params) {
        Long userId = params.get("userId");
        Long productId = params.get("productId");
        if (favoriteService.removeFavorite(userId, productId)) {
            return Result.success("取消收藏成功");
        }
        return Result.error("取消收藏失败");
    }
}

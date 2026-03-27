package com.pdd.mall.service;

import com.pdd.mall.entity.Favorite;
import com.pdd.mall.entity.Product;
import com.pdd.mall.mapper.FavoriteMapper;
import com.pdd.mall.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;

    @Autowired
    private ProductMapper productMapper;

    public List<Product> getFavoriteProducts(Long userId) {
        List<Favorite> favorites = favoriteMapper.findByUserId(userId);
        List<Product> products = new ArrayList<>();
        for (Favorite favorite : favorites) {
            Product product = productMapper.findById(favorite.getProductId());
            if (product != null) {
                products.add(product);
            }
        }
        return products;
    }

    public boolean addFavorite(Long userId, Long productId) {
        Favorite exist = favoriteMapper.findByUserIdAndProductId(userId, productId);
        if (exist != null) {
            return false;
        }
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setProductId(productId);
        return favoriteMapper.insert(favorite) > 0;
    }

    public boolean removeFavorite(Long userId, Long productId) {
        return favoriteMapper.deleteByUserIdAndProductId(userId, productId) > 0;
    }

    public boolean isFavorited(Long userId, Long productId) {
        return favoriteMapper.findByUserIdAndProductId(userId, productId) != null;
    }
}

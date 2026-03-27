package com.pdd.mall.service;

import com.pdd.mall.entity.Banner;
import com.pdd.mall.mapper.BannerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BannerService {
    
    @Autowired
    private BannerMapper bannerMapper;
    
    public List<Banner> getActiveBanners() {
        return bannerMapper.findAllActiveBanners();
    }
    
    public List<Banner> getAllBanners() {
        return bannerMapper.findAll();
    }
    
    public Banner getBannerById(Long id) {
        return bannerMapper.findById(id);
    }
    
    public void addBanner(Banner banner) {
        bannerMapper.insert(banner);
    }
    
    public void updateBanner(Banner banner) {
        bannerMapper.update(banner);
    }
    
    public void deleteBanner(Long id) {
        bannerMapper.delete(id);
    }
}
package com.pdd.mall.service;

import com.pdd.mall.entity.ImageFile;
import com.pdd.mall.mapper.ImageFileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service
public class ImageFileService {
    
    @Autowired
    private ImageFileMapper imageFileMapper;
    
    // 图片存储根路径（从配置文件中读取）
    @Value("${app.image.upload-dir:uploads}")
    private String uploadDir;
    
    /**
     * 上传图片并保存到数据库
     */
    public ImageFile uploadImage(MultipartFile file, String category, String relatedId, Integer sortOrder) throws IOException {
        // 生成唯一文件名
        String originalFilename = file.getOriginalFilename();
        String fileExtension = getFileExtension(originalFilename);
        String storedName = generateUniqueFileName(fileExtension);
        
        // 创建存储目录
        String categoryDir = uploadDir + File.separator + category;
        Path uploadPath = Paths.get(categoryDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        // 保存文件到服务器
        Path filePath = uploadPath.resolve(storedName);
        Files.copy(file.getInputStream(), filePath);
        
        // 保存到数据库
        ImageFile imageFile = new ImageFile(
            originalFilename,
            storedName,
            category + "/" + storedName,  // 相对路径
            file.getContentType(),
            file.getSize(),
            category,
            relatedId
        );
        imageFile.setSortOrder(sortOrder);
        
        imageFileMapper.insert(imageFile);
        return imageFile;
    }
    
    /**
     * 根据ID获取图片
     */
    public ImageFile getImageById(Long id) {
        return imageFileMapper.findById(id);
    }
    
    /**
     * 根据分类获取图片列表
     */
    public List<ImageFile> getImagesByCategory(String category) {
        return imageFileMapper.findByCategory(category);
    }
    
    /**
     * 根据分类和关联ID获取图片列表
     */
    public List<ImageFile> getImagesByCategoryAndRelatedId(String category, String relatedId) {
        return imageFileMapper.findByCategoryAndRelatedId(category, relatedId);
    }
    
    /**
     * 获取图片的物理文件路径
     */
    public File getImageFile(ImageFile imageFile) {
        // 如果 filePath 以 /images/ 开头，说明是静态资源，直接从 static 目录读取
        if (imageFile.getFilePath().startsWith("/images/")) {
            String fullPath = "src/main/resources/static" + imageFile.getFilePath();
            return new File(fullPath);
        } else {
            // 否则从 uploads 目录读取
            String fullPath = uploadDir + File.separator + imageFile.getFilePath();
            return new File(fullPath);
        }
    }
    
    /**
     * 删除图片（软删除）
     */
    public void deleteImage(Long id) {
        imageFileMapper.updateStatus(id, 0);
    }
    
    /**
     * 生成唯一文件名
     */
    private String generateUniqueFileName(String extension) {
        return UUID.randomUUID().toString() + extension;
    }
    
    /**
     * 获取文件扩展名
     */
    private String getFileExtension(String filename) {
        if (filename != null && filename.contains(".")) {
            return filename.substring(filename.lastIndexOf("."));
        }
        return ".jpg";
    }
}
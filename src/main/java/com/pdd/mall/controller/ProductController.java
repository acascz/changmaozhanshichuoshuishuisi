package com.pdd.mall.controller;

import com.pdd.mall.entity.Product;
import com.pdd.mall.entity.ProductSpec;
import com.pdd.mall.service.ProductService;
import com.pdd.mall.service.ProductSpecService;
import com.pdd.mall.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 商品控制器
 */
@RestController
@RequestMapping("/api/product")
@CrossOrigin(origins = "*")
public class ProductController {
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private ProductSpecService productSpecService;
    
    /**
     * 获取首页商品列表
     */
    @GetMapping("/home")
    public Result<List<Product>> getHomeProducts() {
        try {
            List<Product> products = productService.getHomeProducts();
            return Result.success(products);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取商品列表失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取批发商品列表
     */
    @GetMapping("/wholesale")
    public Result<List<Product>> getWholesaleProducts() {
        try {
            List<Product> products = productService.getHomeProducts();
            return Result.success(products);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取批发商品列表失败：" + e.getMessage());
        }
    }
    
    /**
     * 根据分类获取商品
     */
    @GetMapping("/category/{category}")
    public Result<List<Product>> getProductsByCategory(@PathVariable String category) {
        try {
            List<Product> products = productService.getProductsByCategory(category);
            return Result.success(products);
        } catch (Exception e) {
            return Result.error("获取分类商品失败");
        }
    }
    
    /**
     * 根据ID获取商品详情
     */
    @GetMapping("/{id}")
    public Result<Product> getProductById(@PathVariable Long id) {
        try {
            Product product = productService.getProductById(id);
            if (product != null) {
                return Result.success(product);
            } else {
                return Result.error("商品不存在");
            }
        } catch (Exception e) {
            return Result.error("获取商品详情失败");
        }
    }
    
    /**
     * 根据规格参数查询商品规格价格
     */
    @GetMapping("/{id}/spec")
    public Result<ProductSpec> getProductSpecByParams(@PathVariable Long id,
                                                     @RequestParam String weight,
                                                     @RequestParam String sugarType,
                                                     @RequestParam String coldChain) {
        try {
            ProductSpec productSpec = productSpecService.getProductSpecByParams(id, weight, sugarType, coldChain);
            if (productSpec != null) {
                // 转换显示格式
                productSpec.setSugarType(productSpecService.convertSugarTypeToDisplay(productSpec.getSugarType()));
                productSpec.setColdChain(productSpecService.convertColdChainToDisplay(productSpec.getColdChain()));
                return Result.success(productSpec);
            } else {
                return Result.error("未找到对应规格的价格");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取规格价格失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取商品的所有规格选项（用于动态生成规格选择器）
     */
    @GetMapping("/{id}/spec-options")
    public Result<Map<String, Object>> getProductSpecOptions(@PathVariable Long id) {
        try {
            // 查询该商品的所有规格
            List<ProductSpec> specs = productSpecService.getProductSpecsByProductId(id);
            
            if (specs == null || specs.isEmpty()) {
                return Result.error("该商品暂无规格数据");
            }
            
            // 提取所有唯一的规格选项
            java.util.Set<String> tastes = new java.util.HashSet<>();
            java.util.Set<String> weights = new java.util.HashSet<>();
            java.util.Set<String> sugarTypes = new java.util.HashSet<>();
            java.util.Set<String> coldChains = new java.util.HashSet<>();
            
            for (ProductSpec spec : specs) {
                // 根据商品 ID 推断口味
                if (id == 14 || id == 15) {
                    tastes.add("原味");
                } else if (id == 16) {
                    tastes.add("原味");
                    tastes.add("豆沙味");
                    tastes.add("蛋黄味");
                } else if (id == 17) {
                    tastes.add("桂花味");
                }
                
                weights.add(spec.getWeight());
                sugarTypes.add(productSpecService.convertSugarTypeToDisplay(spec.getSugarType()));
                coldChains.add(productSpecService.convertColdChainToDisplay(spec.getColdChain()));
            }
            
            // 构建返回数据
            Map<String, Object> result = new java.util.HashMap<>();
            result.put("tastes", new java.util.ArrayList<>(tastes));
            result.put("weights", new java.util.ArrayList<>(weights));
            result.put("sugarTypes", new java.util.ArrayList<>(sugarTypes));
            result.put("coldChains", new java.util.ArrayList<>(coldChains));
            
            return Result.success(result);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取规格选项失败: " + e.getMessage());
        }
    }
    
    /**
     * 添加商品
     */
    @PostMapping("/add")
    public Result<String> addProduct(@RequestBody Product product) {
        try {
            productService.addProduct(product);
            return Result.success("添加商品成功");
        } catch (Exception e) {
            return Result.error("添加商品失败");
        }
    }
    
    /**
     * 更新商品
     */
    @PutMapping("/update")
    public Result<String> updateProduct(@RequestBody Product product) {
        try {
            productService.updateProduct(product);
            return Result.success("更新商品成功");
        } catch (Exception e) {
            return Result.error("更新商品失败");
        }
    }
    
    /**
     * 删除商品
     */
    @DeleteMapping("/{id}")
    public Result<String> deleteProduct(@PathVariable Long id) {
        try {
            productService.deleteProduct(id);
            return Result.success("删除商品成功");
        } catch (Exception e) {
            return Result.error("删除商品失败");
        }
    }
    
    /**
     * 搜索商品
     */
    @GetMapping("/search")
    public Result<List<Product>> searchProducts(@RequestParam String keyword) {
        try {
            List<Product> products = productService.searchProducts(keyword);
            return Result.success(products);
        } catch (Exception e) {
            return Result.error("搜索商品失败");
        }
    }
}
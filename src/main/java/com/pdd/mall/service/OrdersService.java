package com.pdd.mall.service;

import com.pdd.mall.entity.*;
import com.pdd.mall.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class OrdersService {

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Autowired
    private ProductMapper productMapper;
    
    @Autowired
    private ProductSpecMapper productSpecMapper;
    
    @Autowired
    private PriceVerificationService priceVerificationService;

    public List<Orders> getOrdersByUserId(Long userId) {
        return ordersMapper.findByUserId(userId);
    }

    public List<Orders> getOrdersByUserIdAndStatus(Long userId, Integer status) {
        return ordersMapper.findByUserIdAndStatus(userId, status);
    }

    public Orders getOrderById(Long id) {
        return ordersMapper.findById(id);
    }

    public List<OrderItem> getOrderItems(Long orderId) {
        return orderItemMapper.findByOrderId(orderId);
    }

    @Transactional
    public Orders createOrder(Long userId, Long addressId, List<Map<String, Object>> items) {
        String orderNo = generateOrderNo();
        BigDecimal totalAmount = BigDecimal.ZERO;
        
        // 【价格双向验证】验证每个商品的价格
        for (Map<String, Object> item : items) {
            Long productId = Long.valueOf(item.get("productId").toString());
            Integer quantity = Integer.valueOf(item.get("quantity").toString());
            
            // 获取前端传来的验证价格
            BigDecimal verifiedPrice = null;
            if (item.get("verifiedPrice") != null) {
                verifiedPrice = new BigDecimal(item.get("verifiedPrice").toString());
            }
            
            // 获取规格参数
            String weight = item.get("weight") != null ? item.get("weight").toString() : null;
            String sugarType = item.get("sugarType") != null ? item.get("sugarType").toString() : null;
            String coldChain = item.get("coldChain") != null ? item.get("coldChain").toString() : null;
            
            Product product = productMapper.findById(productId);
            if (product != null) {
                BigDecimal productPrice;
                
                // 如果有规格参数，查询规格价格并使用 Redis 缓存验证
                if (weight != null && sugarType != null && coldChain != null) {
                    // 使用 Redis 缓存验证价格（提升并发性能）
                    boolean isValid = priceVerificationService.verifyPrice(
                        productId, weight, sugarType, coldChain, verifiedPrice
                    );
                    
                    if (!isValid) {
                        // 验证失败，直接查询数据库确认
                        ProductSpec spec = productSpecMapper.findBySpecParams(productId, weight, sugarType, coldChain);
                        if (spec != null) {
                            productPrice = spec.getPrice();
                            // 再次验证价格
                            if (verifiedPrice != null && productPrice.compareTo(verifiedPrice) != 0) {
                                throw new RuntimeException("价格验证失败：商品 " + productId + " 价格不一致");
                            }
                        } else {
                            throw new RuntimeException("未找到商品规格价格");
                        }
                    } else {
                        // 验证通过，使用缓存的价格
                        productPrice = verifiedPrice;
                    }
                } else {
                    // 无规格参数，使用商品默认价格
                    productPrice = product.getPrice();
                }
                
                totalAmount = totalAmount.add(productPrice.multiply(new BigDecimal(quantity)));
            }
        }

        Orders orders = new Orders();
        orders.setOrderNo(orderNo);
        orders.setUserId(userId);
        orders.setAddressId(addressId);
        orders.setTotalAmount(totalAmount);
        orders.setStatus(0);
        ordersMapper.insert(orders);

        for (Map<String, Object> item : items) {
            Long productId = Long.valueOf(item.get("productId").toString());
            Integer quantity = Integer.valueOf(item.get("quantity").toString());
            Product product = productMapper.findById(productId);
            if (product != null) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orders.getId());
                orderItem.setProductId(productId);
                orderItem.setProductName(product.getName());
                orderItem.setProductImage(getProductImageUrl(product));
                
                // 设置价格（使用验证后的价格）
                String weight = item.get("weight") != null ? item.get("weight").toString() : null;
                String sugarType = item.get("sugarType") != null ? item.get("sugarType").toString() : null;
                String coldChain = item.get("coldChain") != null ? item.get("coldChain").toString() : null;
                
                if (weight != null && sugarType != null && coldChain != null) {
                    ProductSpec spec = productSpecMapper.findBySpecParams(productId, weight, sugarType, coldChain);
                    if (spec != null) {
                        orderItem.setPrice(spec.getPrice());
                    } else {
                        orderItem.setPrice(product.getPrice());
                    }
                } else {
                    orderItem.setPrice(product.getPrice());
                }
                
                orderItem.setQuantity(quantity);
                orderItemMapper.insert(orderItem);
            }
        }

        return orders;
    }

    @Transactional
    public boolean updateOrderStatus(Long id, Integer status) {
        Orders orders = ordersMapper.findById(id);
        if (orders != null && orders.getStatus() == 0 && status == 1) {
            List<OrderItem> items = orderItemMapper.findByOrderId(orders.getId());
            for (OrderItem item : items) {
                updateProductSales(item.getProductId(), item.getQuantity());
            }
        }
        return ordersMapper.updateStatus(id, status) > 0;
    }
    
    /**
     * 更新商品销量
     */
    private void updateProductSales(Long productId, Integer quantity) {
        Product product = productMapper.findById(productId);
        if (product != null) {
            product.setSalesCount(product.getSalesCount() + quantity);
            productMapper.update(product);
        }
    }
    
    /**
     * 获取商品图片URL
     */
    private String getProductImageUrl(Product product) {
        // 这里可以返回默认图片URL或者根据商品ID生成图片路径
        // 由于现在使用新的图片管理系统，这里返回一个默认路径
        return "/images/product/default.jpg";
    }

    private String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        return "ORD" + sdf.format(new Date()) + UUID.randomUUID().toString().substring(0, 4).toUpperCase();
    }
}

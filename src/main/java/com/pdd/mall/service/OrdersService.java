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
    private AddressMapper addressMapper;

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

        for (Map<String, Object> item : items) {
            Long productId = Long.valueOf(item.get("productId").toString());
            Integer quantity = Integer.valueOf(item.get("quantity").toString());
            Product product = productMapper.findById(productId);
            if (product != null) {
                totalAmount = totalAmount.add(product.getPrice().multiply(new BigDecimal(quantity)));
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
                orderItem.setPrice(product.getPrice());
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

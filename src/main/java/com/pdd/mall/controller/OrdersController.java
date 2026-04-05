package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.OrderItem;
import com.pdd.mall.entity.Orders;
import com.pdd.mall.service.OrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
@CrossOrigin
public class OrdersController {

    @Autowired
    private OrdersService ordersService;

    @GetMapping("/list/{userId}")
    public Result<List<Orders>> getOrders(@PathVariable Long userId) {
        return Result.success(ordersService.getOrdersByUserId(userId));
    }

    @GetMapping("/list/{userId}/status/{status}")
    public Result<List<Orders>> getOrdersByStatus(@PathVariable Long userId, @PathVariable Integer status) {
        return Result.success(ordersService.getOrdersByUserIdAndStatus(userId, status));
    }

    @GetMapping("/detail/{id}")
    public Result<Orders> getOrderDetail(@PathVariable Long id) {
        Orders order = ordersService.getOrderById(id);
        if (order != null) {
            return Result.success(order);
        }
        return Result.error("订单不存在");
    }

    @GetMapping("/items/{orderId}")
    public Result<List<OrderItem>> getOrderItems(@PathVariable Long orderId) {
        return Result.success(ordersService.getOrderItems(orderId));
    }

    @PostMapping("/create")
    @SuppressWarnings("unchecked")
    public Result<Orders> createOrder(@RequestBody Map<String, Object> params) {
        Long userId = Long.valueOf(params.get("userId").toString());
        Long addressId = Long.valueOf(params.get("addressId").toString());
        List<Map<String, Object>> items = (List<Map<String, Object>>) params.get("items");
        Orders order = ordersService.createOrder(userId, addressId, items);
        return Result.success(order);
    }

    @PutMapping("/status/{id}")
    public Result<String> updateOrderStatus(@PathVariable Long id, @RequestParam Integer status) {
        if (ordersService.updateOrderStatus(id, status)) {
            return Result.success("状态更新成功");
        }
        return Result.error("状态更新失败");
    }
}

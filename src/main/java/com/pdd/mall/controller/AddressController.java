package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.Address;
import com.pdd.mall.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/address")
@CrossOrigin
public class AddressController {

    @Autowired
    private AddressService addressService;

    @GetMapping("/list/{userId}")
    public Result<List<Address>> getAddresses(@PathVariable Long userId) {
        return Result.success(addressService.getAddressesByUserId(userId));
    }

    @GetMapping("/detail/{id}")
    public Result<Address> getAddress(@PathVariable Long id) {
        Address address = addressService.getAddressById(id);
        if (address != null) {
            return Result.success(address);
        }
        return Result.error("地址不存在");
    }

    @GetMapping("/default/{userId}")
    public Result<Address> getDefaultAddress(@PathVariable Long userId) {
        return Result.success(addressService.getDefaultAddress(userId));
    }

    @PostMapping("/add")
    public Result<Address> addAddress(@RequestBody Address address) {
        return Result.success(addressService.addAddress(address));
    }

    @PutMapping("/update")
    public Result<Address> updateAddress(@RequestBody Address address) {
        return Result.success(addressService.updateAddress(address));
    }

    @DeleteMapping("/delete/{id}")
    public Result<String> deleteAddress(@PathVariable Long id) {
        if (addressService.deleteAddress(id)) {
            return Result.success("删除成功");
        }
        return Result.error("删除失败");
    }
}

package com.pdd.mall.service;

import com.pdd.mall.entity.Address;
import com.pdd.mall.mapper.AddressMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AddressService {

    @Autowired
    private AddressMapper addressMapper;

    public List<Address> getAddressesByUserId(Long userId) {
        return addressMapper.findByUserId(userId);
    }

    public Address getAddressById(Long id) {
        return addressMapper.findById(id);
    }

    public Address getDefaultAddress(Long userId) {
        return addressMapper.findDefaultByUserId(userId);
    }

    @Transactional
    public Address addAddress(Address address) {
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            addressMapper.updateDefault(address.getUserId(), 0);
        }
        addressMapper.insert(address);
        return address;
    }

    @Transactional
    public Address updateAddress(Address address) {
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            addressMapper.updateDefault(address.getUserId(), 0);
        }
        addressMapper.update(address);
        return address;
    }

    public boolean deleteAddress(Long id) {
        return addressMapper.deleteById(id) > 0;
    }
}

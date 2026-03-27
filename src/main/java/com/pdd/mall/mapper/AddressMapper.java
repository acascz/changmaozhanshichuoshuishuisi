package com.pdd.mall.mapper;

import com.pdd.mall.entity.Address;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AddressMapper {
    List<Address> findByUserId(@Param("userId") Long userId);
    Address findById(@Param("id") Long id);
    Address findDefaultByUserId(@Param("userId") Long userId);
    int insert(Address address);
    int update(Address address);
    int updateDefault(@Param("userId") Long userId, @Param("isDefault") Integer isDefault);
    int deleteById(@Param("id") Long id);
}

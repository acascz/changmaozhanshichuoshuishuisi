package com.pdd.mall.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 库存 Mapper
 */
@Mapper
public interface InventoryMapper {

    /**
     * 查询所有商品 ID
     * @return 商品 ID 列表
     */
    @Select("SELECT DISTINCT id FROM goods WHERE deleted = 0 OR deleted IS NULL")
    List<Integer> selectAllGoodsIds();

    /**
     * 根据商品 ID 查询库存
     * @param goodsId 商品 ID
     * @return 库存数量
     */
    @Select("SELECT stock FROM goods WHERE id = #{goodsId} AND (deleted = 0 OR deleted IS NULL) LIMIT 1")
    Integer selectStockByGoodsId(Integer goodsId);
}

-- 更新商品价格为真实定价（0.5kg/不加糖醇/不冷链 = ¥17.9）
USE mung_bean_cake_mall;

-- 更新商品1：绿豆糕 经典原味 传统糕点
UPDATE product SET 
    price = 17.90,
    original_price = 19.90,
    update_time = NOW()
WHERE id = 1;

-- 更新商品2：绿豆糕(原味) 纯手工无添加
UPDATE product SET 
    price = 17.90,
    original_price = 19.90,
    update_time = NOW()
WHERE id = 2;

-- 更新商品3：桃山月饼 中秋佳节 精美礼盒
UPDATE product SET 
    price = 17.90,
    original_price = 19.90,
    update_time = NOW()
WHERE id = 3;

-- 更新商品4：绿豆糕(桂花味) 桂花香浓 独立包装
UPDATE product SET 
    price = 17.90,
    original_price = 19.90,
    update_time = NOW()
WHERE id = 4;

-- 验证更新结果
SELECT id, name, price, original_price FROM product WHERE status = 1;
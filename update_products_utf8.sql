-- 更新商品数据（使用 UTF-8 编码）
USE mung_bean_cake_mall;

-- 更新商品 1
UPDATE product SET 
    name = '绿豆糕 经典原味 传统糕点',
    description = '精选优质绿豆，传统工艺制作，口感细腻，甜而不腻。独立小包装，方便携带，是下午茶和休闲时刻的理想选择。',
    category = '糕点'
WHERE id = 1;

-- 更新商品 2
UPDATE product SET 
    name = '桂花绿豆糕 清香怡人',
    description = '在绿豆糕的基础上添加天然桂花，清香怡人，口感丰富。采用传统配方，手工制作，每一口都是儿时的味道。',
    category = '糕点'
WHERE id = 2;

-- 更新商品 3
UPDATE product SET 
    name = '桃山月饼 中秋礼盒装',
    description = '精选桃山皮，馅料饱满，口感绵密。精美礼盒包装，适合中秋佳节送礼或家庭分享。传统工艺与现代口味的完美结合。',
    category = '月饼'
WHERE id = 3;

-- 更新商品 4
UPDATE product SET 
    name = '红豆糕 传统手工制作',
    description = '选用优质红豆，经过多道工序精心制作，口感软糯，甜度适中。不含添加剂，健康美味，老少皆宜。',
    category = '糕点'
WHERE id = 4;

-- 更新商品 5
UPDATE product SET 
    name = '芝麻糕 香浓营养',
    description = '采用黑芝麻和白芝麻混合制作，香气浓郁，营养丰富。口感细腻，入口即化，是养生保健的传统美食。',
    category = '糕点'
WHERE id = 5;

-- 更新商品 6
UPDATE product SET 
    name = '绿豆冰糕 清凉解暑',
    description = '夏日必备清凉糕点，绿豆清香，口感冰爽。采用现代冷冻技术，保留传统风味的同时更加爽口宜人。',
    category = '糕点'
WHERE id = 6;

-- 验证更新结果
SELECT id, name, description, price, category FROM product;

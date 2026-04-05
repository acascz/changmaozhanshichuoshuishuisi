-- 用户表和商品表数据恢复脚本
-- 从 binlog 000046 恢复

USE mung_bean_cake_mall;
SET FOREIGN_KEY_CHECKS = 0;


SET FOREIGN_KEY_CHECKS = 1;# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#260318  0:53:00 server id 1  end_log_pos 126 CRC32 0x6454192f 	Start: binlog v 4, server v 8.0.44 created 260318  0:53:00 at startup
ROLLBACK/*!*/;
/*!50616 SET @@SESSION.GTID_NEXT='AUTOMATIC'*//*!*/;
# at 126
# at 157
# at 234
#260318 18:01:40 server id 1  end_log_pos 401 CRC32 0x050ef342 	Query	thread_id=29	exec_time=0	error_code=0	Xid = 50
SET TIMESTAMP=1773828100/*!*/;
SET @@session.pseudo_thread_id=29/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1168113696/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
/*!80016 SET @@session.default_table_encryption=0*//*!*/;
CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall
/*!*/;
# at 401
# at 478
#260318 18:03:30 server id 1  end_log_pos 636 CRC32 0xcde4b6d0 	Query	thread_id=32	exec_time=0	error_code=0
SET TIMESTAMP=1773828210/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80016 SET @@session.default_table_encryption=0*//*!*/;
CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall
/*!*/;
# at 636
# at 715
#260318 18:03:30 server id 1  end_log_pos 2050 CRC32 0xdf28dcd5 	Query	thread_id=32	exec_time=0	error_code=0	Xid = 92
use `mung_bean_cake_mall`/*!*/;
SET TIMESTAMP=1773828210/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS image_file (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    original_name VARCHAR(500) NOT NULL COMMENT '鍘熷鏂囦欢鍚?,
    stored_name VARCHAR(500) NOT NULL UNIQUE COMMENT '瀛樺偍鏂囦欢鍚嶏紙鍞竴锛?,
    file_path VARCHAR(1000) NOT NULL COMMENT '鐩稿璺緞',
    file_type VARCHAR(100) NOT NULL COMMENT '鏂囦欢绫诲瀷',
    file_size BIGINT NOT NULL COMMENT '鏂囦欢澶у皬锛堝瓧鑺傦級',
    description VARCHAR(1000) COMMENT '鎻忚堪',
    category VARCHAR(50) NOT NULL COMMENT '鍥剧墖鍒嗙被锛歱roduct-鍟嗗搧鍥? banner-杞挱鍥? avatar-鐢ㄦ埛澶村儚, other-鍏朵粬',
    related_id VARCHAR(100) COMMENT '鍏宠仈鐨勪笟鍔D锛堝鍟嗗搧ID銆佺敤鎴稩D绛夛級',
    sort_order INT DEFAULT 0 COMMENT '鎺掑簭搴忓彿',
    status TINYINT DEFAULT 1 COMMENT '鐘舵€侊細0-绂佺敤锛?-鍚敤',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
    INDEX idx_category (category),
    INDEX idx_related_id (related_id),
    INDEX idx_category_related (category, related_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='缁熶竴鍥剧墖绠＄悊琛?
/*!*/;
# at 2050
# at 2129
#260318 18:03:30 server id 1  end_log_pos 2227 CRC32 0x31ce8c36 	Query	thread_id=32	exec_time=0	error_code=0
SET TIMESTAMP=1773828210/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
BEGIN
/*!*/;
# at 2227
#260318 18:03:30 server id 1  end_log_pos 2332 CRC32 0xe184720c 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 2332
#260318 18:03:30 server id 1  end_log_pos 2564 CRC32 0x5c2cb9ba 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=1
###   @2='banner1.jpg'
###   @3='banner1.jpg'
###   @4='banner/banner1.jpg'
###   @5='image/jpeg'
###   @6=102400
###   @7=NULL
###   @8='banner'
###   @9=NULL
###   @10=1
###   @11=1
###   @12='2026-03-18 18:03:30'
###   @13='2026-03-18 18:03:30'
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=2
###   @2='banner2.jpg'
###   @3='banner2.jpg'
###   @4='banner/banner2.jpg'
###   @5='image/jpeg'
###   @6=105600
###   @7=NULL
###   @8='banner'
###   @9=NULL
###   @10=2
###   @11=1
###   @12='2026-03-18 18:03:30'
###   @13='2026-03-18 18:03:30'
# at 2564
#260318 18:03:30 server id 1  end_log_pos 2595 CRC32 0x18e9a2cc 	Xid = 97
COMMIT/*!*/;
# at 2595
# at 2674
#260318 18:26:46 server id 1  end_log_pos 2772 CRC32 0xc16110a7 	Query	thread_id=32	exec_time=0	error_code=0
SET TIMESTAMP=1773829606/*!*/;
BEGIN
/*!*/;
# at 2772
#260318 18:26:46 server id 1  end_log_pos 2877 CRC32 0xb61f3e56 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 2877
#260318 18:26:46 server id 1  end_log_pos 3011 CRC32 0xbac0263c 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=3
###   @2='banner3.jpg'
###   @3='banner3.jpg'
###   @4='banner/banner3.jpg'
###   @5='image/jpeg'
###   @6=98000
###   @7=NULL
###   @8='banner'
###   @9=NULL
###   @10=3
###   @11=1
###   @12='2026-03-18 18:26:46'
###   @13='2026-03-18 18:26:46'
# at 3011
#260318 18:26:46 server id 1  end_log_pos 3042 CRC32 0x0ec11dcf 	Xid = 117
COMMIT/*!*/;
# at 3042
# at 3121
#260318 19:13:51 server id 1  end_log_pos 4174 CRC32 0x32b0d86a 	Query	thread_id=32	exec_time=0	error_code=0	Xid = 136
SET TIMESTAMP=1773832431/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL COMMENT '鍟嗗搧鍚嶇О',
    description TEXT COMMENT '鍟嗗搧鎻忚堪',
    price DECIMAL(10,2) NOT NULL COMMENT '鍟嗗搧浠锋牸',
    original_price DECIMAL(10,2) COMMENT '鍘熶环',
    sales_count INT DEFAULT 0 COMMENT '閿€閲?,
    stock_count INT DEFAULT 0 COMMENT '搴撳瓨',
    category VARCHAR(50) COMMENT '鍟嗗搧鍒嗙被',
    tags VARCHAR(200) COMMENT '鍟嗗搧鏍囩',
    status TINYINT DEFAULT 1 COMMENT '鐘舵€侊細0-涓嬫灦锛?-涓婃灦',
    sort_order INT DEFAULT 0 COMMENT '鎺掑簭搴忓彿',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='鍟嗗搧琛?
/*!*/;
# at 4174
# at 4253
#260318 19:18:00 server id 1  end_log_pos 5297 CRC32 0x858a81da 	Query	thread_id=32	exec_time=0	error_code=0
SET TIMESTAMP=1773832680/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL COMMENT '鍟嗗搧鍚嶇О',
    description TEXT COMMENT '鍟嗗搧鎻忚堪',
    price DECIMAL(10,2) NOT NULL COMMENT '鍟嗗搧浠锋牸',
    original_price DECIMAL(10,2) COMMENT '鍘熶环',
    sales_count INT DEFAULT 0 COMMENT '閿€閲?,
    stock_count INT DEFAULT 0 COMMENT '搴撳瓨',
    category VARCHAR(50) COMMENT '鍟嗗搧鍒嗙被',
    tags VARCHAR(200) COMMENT '鍟嗗搧鏍囩',
    status TINYINT DEFAULT 1 COMMENT '鐘舵€侊細0-涓嬫灦锛?-涓婃灦',
    sort_order INT DEFAULT 0 COMMENT '鎺掑簭搴忓彿',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='鍟嗗搧琛?
/*!*/;
# at 5297
# at 5376
#260318 19:18:04 server id 1  end_log_pos 6420 CRC32 0x599bbee7 	Query	thread_id=32	exec_time=0	error_code=0
SET TIMESTAMP=1773832684/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL COMMENT '鍟嗗搧鍚嶇О',
    description TEXT COMMENT '鍟嗗搧鎻忚堪',
    price DECIMAL(10,2) NOT NULL COMMENT '鍟嗗搧浠锋牸',
    original_price DECIMAL(10,2) COMMENT '鍘熶环',
    sales_count INT DEFAULT 0 COMMENT '閿€閲?,
    stock_count INT DEFAULT 0 COMMENT '搴撳瓨',
    category VARCHAR(50) COMMENT '鍟嗗搧鍒嗙被',
    tags VARCHAR(200) COMMENT '鍟嗗搧鏍囩',
    status TINYINT DEFAULT 1 COMMENT '鐘舵€侊細0-涓嬫灦锛?-涓婃灦',
    sort_order INT DEFAULT 0 COMMENT '鎺掑簭搴忓彿',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '鏇存柊鏃堕棿',
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='鍟嗗搧琛?
/*!*/;
# at 6420
# at 6499
#260318 19:19:25 server id 1  end_log_pos 6597 CRC32 0x4e5ab37f 	Query	thread_id=32	exec_time=0	error_code=0
SET TIMESTAMP=1773832765/*!*/;
BEGIN
/*!*/;
# at 6597
#260318 19:19:25 server id 1  end_log_pos 6696 CRC32 0xbba6fe3a 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 98
# at 6696
#260318 19:19:25 server id 1  end_log_pos 7521 CRC32 0x583e5e5b 	Write_rows: table id 98 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=1
###   @2='缁胯眴楗?浼犵粺绯曠偣 鎵嬪伐鍒朵綔'
###   @3='浼犵粺鎵嬪伐缁胯眴楗硷紝澶栫毊閰ヨ剢锛屽唴棣呴鐢滐紝缁忓吀鍙ｅ懗'
###   @4=30.00
###   @5=40.00
###   @6=0
###   @7=100
###   @8='浼犵粺绯曠偣'
###   @9='缁胯眴楗?鎵嬪伐鍒朵綔,浼犵粺绯曠偣'
###   @10=1
###   @11=1
###   @12='2026-03-18 19:19:25'
###   @13='2026-03-18 19:19:25'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=2
###   @2='缁胯眴绯?鍘熷懗) 绾墜宸ユ棤娣诲姞'
###   @3='鍘熷懗缁胯眴绯曪紝绾墜宸ュ埗浣滐紝鏃犳坊鍔犻槻鑵愬墏锛屽彛鎰熺粏鑵?
###   @4=30.00
###   @5=40.00
###   @6=0
###   @7=100
###   @8='缁胯眴绯?
###   @9='鍘熷懗,鎵嬪伐鍒朵綔,鏃犳坊鍔?
###   @10=1
###   @11=2
###   @12='2026-03-18 19:19:25'
###   @13='2026-03-18 19:19:25'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=3
###   @2='妗冨北鏈堥ゼ 涓浣宠妭 绮剧編绀肩洅'
###   @3='妗冨北鐨湀楗硷紝澶氱鍙ｅ懗锛岀簿缇庣ぜ鐩掑寘瑁咃紝涓閫佺ぜ浣冲搧'
###   @4=30.00
###   @5=40.00
###   @6=0
###   @7=100
###   @8='鏈堥ゼ'
###   @9='妗冨北鏈堥ゼ,涓,绀肩洅瑁?
###   @10=1
###   @11=3
###   @12='2026-03-18 19:19:25'
###   @13='2026-03-18 19:19:25'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=4
###   @2='缁胯眴绯?妗傝姳鍛? 妗傝姳棣欐祿 鐙珛鍖呰'
###   @3='妗傝姳鍛崇豢璞嗙硶锛屾鑺遍姘旀祿閮侊紝鐙珛鍖呰锛屾柟渚挎惡甯?
###   @4=30.00
###   @5=40.00
###   @6=0
###   @7=100
###   @8='缁胯眴绯?
###   @9='妗傝姳鍛?鐙珛鍖呰,娓呴'
###   @10=1
###   @11=4
###   @12='2026-03-18 19:19:25'
###   @13='2026-03-18 19:19:25'
# at 7521
#260318 19:19:25 server id 1  end_log_pos 7552 CRC32 0x6ad5e7f9 	Xid = 188
COMMIT/*!*/;
# at 7552
# at 7631
#260319 14:23:45 server id 1  end_log_pos 7846 CRC32 0x6fb8e5d1 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
/*!80016 SET @@session.default_table_encryption=0*//*!*/;
CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
/*!*/;
# at 7846
# at 7923
#260319 14:23:45 server id 1  end_log_pos 8086 CRC32 0x09170592 	Query	thread_id=271	exec_time=0	error_code=0
use `mung_bean_cake_mall`/*!*/;
SET TIMESTAMP=1773901425/*!*/;
SET @@session.pseudo_thread_id=271/*!*/;
DROP TABLE IF EXISTS `ai_form` /* generated by server */
/*!*/;
# at 8086
# at 8163
#260319 14:23:45 server id 1  end_log_pos 8331 CRC32 0xec1b2897 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `chat_message` /* generated by server */
/*!*/;
# at 8331
# at 8408
#260319 14:23:45 server id 1  end_log_pos 8574 CRC32 0xd5c59aea 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `order_item` /* generated by server */
/*!*/;
# at 8574
# at 8651
#260319 14:23:45 server id 1  end_log_pos 8813 CRC32 0xaad45b59 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `orders` /* generated by server */
/*!*/;
# at 8813
# at 8890
#260319 14:23:45 server id 1  end_log_pos 9053 CRC32 0x8b8062d8 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `address` /* generated by server */
/*!*/;
# at 9053
# at 9130
#260319 14:23:45 server id 1  end_log_pos 9294 CRC32 0xea9cdaad 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `favorite` /* generated by server */
/*!*/;
# at 9294
# at 9371
#260319 14:23:45 server id 1  end_log_pos 9543 CRC32 0xb2cf1c5f 	Query	thread_id=271	exec_time=0	error_code=0	Xid = 2021
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `product` /* generated by server */
/*!*/;
# at 9543
# at 9620
#260319 14:23:45 server id 1  end_log_pos 9780 CRC32 0x3f3509a4 	Query	thread_id=271	exec_time=0	error_code=0
SET TIMESTAMP=1773901425/*!*/;
DROP TABLE IF EXISTS `user` /* generated by server */
/*!*/;
# at 9780
# at 9859
#260319 14:23:54 server id 1  end_log_pos 10074 CRC32 0x35a19aee 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80016 SET @@session.default_table_encryption=0*//*!*/;
CREATE DATABASE IF NOT EXISTS mung_bean_cake_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
/*!*/;
# at 10074
# at 10151
#260319 14:23:54 server id 1  end_log_pos 10314 CRC32 0x408343de 	Query	thread_id=272	exec_time=0	error_code=0
use `mung_bean_cake_mall`/*!*/;
SET TIMESTAMP=1773901434/*!*/;
SET @@session.pseudo_thread_id=272/*!*/;
DROP TABLE IF EXISTS `ai_form` /* generated by server */
/*!*/;
# at 10314
# at 10391
#260319 14:23:54 server id 1  end_log_pos 10559 CRC32 0x90fa2f70 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `chat_message` /* generated by server */
/*!*/;
# at 10559
# at 10636
#260319 14:23:54 server id 1  end_log_pos 10802 CRC32 0xe4f9aba2 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `order_item` /* generated by server */
/*!*/;
# at 10802
# at 10879
#260319 14:23:54 server id 1  end_log_pos 11041 CRC32 0x1fd1e984 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `orders` /* generated by server */
/*!*/;
# at 11041
# at 11118
#260319 14:23:54 server id 1  end_log_pos 11281 CRC32 0x7980d50c 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `address` /* generated by server */
/*!*/;
# at 11281
# at 11358
#260319 14:23:54 server id 1  end_log_pos 11522 CRC32 0xfb65065a 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `favorite` /* generated by server */
/*!*/;
# at 11522
# at 11599
#260319 14:23:54 server id 1  end_log_pos 11762 CRC32 0x867b9d41 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `product` /* generated by server */
/*!*/;
# at 11762
# at 11839
#260319 14:23:54 server id 1  end_log_pos 11999 CRC32 0xc84206a1 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901434/*!*/;
DROP TABLE IF EXISTS `user` /* generated by server */
/*!*/;
# at 11999
# at 12078
#260319 14:23:54 server id 1  end_log_pos 12823 CRC32 0x2f535755 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2037
SET TIMESTAMP=1773901434/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `username` VARCHAR(50) NOT NULL COMMENT '???',
    `password` VARCHAR(100) NOT NULL COMMENT '??',
    `nickname` VARCHAR(50) DEFAULT NULL COMMENT '??',
    `avatar` VARCHAR(255) DEFAULT NULL COMMENT '??URL',
    `phone` VARCHAR(20) DEFAULT NULL COMMENT '???',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='???'
/*!*/;
# at 12823
# at 12902
#260319 14:23:54 server id 1  end_log_pos 13775 CRC32 0xf6eb86c6 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2038
SET TIMESTAMP=1773901434/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `product` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `name` VARCHAR(100) NOT NULL COMMENT '????',
    `description` TEXT COMMENT '????',
    `price` DECIMAL(10,2) NOT NULL COMMENT '??',
    `original_price` DECIMAL(10,2) DEFAULT NULL COMMENT '??',
    `image` VARCHAR(255) DEFAULT NULL COMMENT '????URL',
    `images` TEXT COMMENT '??????(JSON)',
    `sales` INT DEFAULT 0 COMMENT '??',
    `stock` INT DEFAULT 0 COMMENT '??',
    `category` VARCHAR(50) DEFAULT NULL COMMENT '??',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='???'
/*!*/;
# at 13775
# at 13854
#260319 14:23:54 server id 1  end_log_pos 14354 CRC32 0x502434ee 	Query	thread_id=272	exec_time=1	error_code=0	Xid = 2039
SET TIMESTAMP=1773901434/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `favorite` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `user_id` BIGINT NOT NULL COMMENT '??ID',
    `product_id` BIGINT NOT NULL COMMENT '??ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_product` (`user_id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='???'
/*!*/;
# at 14354
# at 14433
#260319 14:23:55 server id 1  end_log_pos 15278 CRC32 0xd1205b34 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2040
SET TIMESTAMP=1773901435/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `address` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `user_id` BIGINT NOT NULL COMMENT '??ID',
    `name` VARCHAR(50) NOT NULL COMMENT '?????',
    `phone` VARCHAR(20) NOT NULL COMMENT '?????',
    `province` VARCHAR(50) NOT NULL COMMENT '??',
    `city` VARCHAR(50) NOT NULL COMMENT '??',
    `district` VARCHAR(50) NOT NULL COMMENT '??',
    `detail` VARCHAR(255) NOT NULL COMMENT '????',
    `is_default` TINYINT(1) DEFAULT 0 COMMENT '?????? 0? 1?',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='???'
/*!*/;
# at 15278
# at 15357
#260319 14:23:55 server id 1  end_log_pos 16117 CRC32 0x67c9bed3 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2041
SET TIMESTAMP=1773901435/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `orders` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `order_no` VARCHAR(50) NOT NULL COMMENT '???',
    `user_id` BIGINT NOT NULL COMMENT '??ID',
    `address_id` BIGINT NOT NULL COMMENT '??ID',
    `total_amount` DECIMAL(10,2) NOT NULL COMMENT '?????',
    `status` TINYINT DEFAULT 0 COMMENT '???? 0??? 1??? 2??? 3??? 4???',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='???'
/*!*/;
# at 16117
# at 16196
#260319 14:23:55 server id 1  end_log_pos 16851 CRC32 0xcfb5ae5f 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2042
SET TIMESTAMP=1773901435/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `order_item` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '???ID',
    `order_id` BIGINT NOT NULL COMMENT '??ID',
    `product_id` BIGINT NOT NULL COMMENT '??ID',
    `product_name` VARCHAR(100) NOT NULL COMMENT '????',
    `product_image` VARCHAR(255) DEFAULT NULL COMMENT '????',
    `price` DECIMAL(10,2) NOT NULL COMMENT '??',
    `quantity` INT NOT NULL COMMENT '??',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='????'
/*!*/;
# at 16851
# at 16930
#260319 14:23:55 server id 1  end_log_pos 17427 CRC32 0x1d03dc88 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2043
SET TIMESTAMP=1773901435/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `chat_message` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `user_id` BIGINT NOT NULL COMMENT '??ID',
    `from_type` TINYINT NOT NULL COMMENT '??? 0?? 1??',
    `content` TEXT NOT NULL COMMENT '????',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='?????'
/*!*/;
# at 17427
# at 17506
#260319 14:23:55 server id 1  end_log_pos 18151 CRC32 0x6beac072 	Query	thread_id=272	exec_time=0	error_code=0	Xid = 2044
SET TIMESTAMP=1773901435/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE `ai_form` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '??ID',
    `user_id` BIGINT NOT NULL COMMENT '??ID',
    `flavor` VARCHAR(50) DEFAULT NULL COMMENT '??',
    `sweetness` VARCHAR(50) DEFAULT NULL COMMENT '??',
    `packaging` VARCHAR(50) DEFAULT NULL COMMENT '??',
    `quantity` INT DEFAULT NULL COMMENT '??',
    `special_request` TEXT COMMENT '????',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '????',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI?????'
/*!*/;
# at 18151
# at 18230
#260319 14:23:55 server id 1  end_log_pos 18328 CRC32 0xb9fe6b8a 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901435/*!*/;
BEGIN
/*!*/;
# at 18328
#260319 14:23:55 server id 1  end_log_pos 18417 CRC32 0xe362098e 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 109
# at 18417
#260319 14:23:55 server id 1  end_log_pos 18659 CRC32 0x70a3a575 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`user`
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='???'
###   @5='https://api.dicebear.com/7.x/avataaars/svg?seed=admin'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`user`
### SET
###   @1=2
###   @2='user1'
###   @3='123456'
###   @4='??'
###   @5='https://api.dicebear.com/7.x/avataaars/svg?seed=user1'
###   @6='13800138001'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:23:55'
# at 18659
#260319 14:23:55 server id 1  end_log_pos 18690 CRC32 0x8ff5eb6a 	Xid = 2045
COMMIT/*!*/;
# at 18690
# at 18769
#260319 14:23:55 server id 1  end_log_pos 18867 CRC32 0xabeff939 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901435/*!*/;
BEGIN
/*!*/;
# at 18867
#260319 14:23:55 server id 1  end_log_pos 18966 CRC32 0x35001d59 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 110
# at 18966
#260319 14:23:55 server id 1  end_log_pos 20215 CRC32 0x9880cacb 	Write_rows: table id 110 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=1
###   @2='???????'
###   @3='??????????????????'
###   @4=19.90
###   @5=39.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=traditional%20Chinese%20mung%20bean%20cake%20food%20photography&image_size=square'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=2
###   @2='??????'
###   @3='????????????'
###   @4=25.90
###   @5=49.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=matcha%20mung%20bean%20cake%20green%20tea%20dessert&image_size=square'
###   @7=NULL
###   @8=892
###   @9=300
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=3
###   @2='?????'
###   @3='???????????'
###   @4=22.90
###   @5=45.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=osmanthus%20mung%20bean%20cake%20sweet%20dessert&image_size=square'
###   @7=NULL
###   @8=567
###   @9=200
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=4
###   @2='?????'
###   @3='????????????????'
###   @4=28.90
###   @5=55.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=sugar%20free%20mung%20bean%20cake%20healthy%20dessert&image_size=square'
###   @7=NULL
###   @8=432
###   @9=150
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=5
###   @2='?????'
###   @3='??????????'
###   @4=23.90
###   @5=46.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=purple%20sweet%20potato%20mung%20bean%20cake%20dessert&image_size=square'
###   @7=NULL
###   @8=678
###   @9=250
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`product`
### SET
###   @1=6
###   @2='?????'
###   @3='?????????'
###   @4=26.90
###   @5=52.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=coconut%20mung%20bean%20cake%20tropical%20dessert&image_size=square'
###   @7=NULL
###   @8=345
###   @9=180
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
# at 20215
#260319 14:23:55 server id 1  end_log_pos 20246 CRC32 0xde818023 	Xid = 2046
COMMIT/*!*/;
# at 20246
# at 20325
#260319 14:23:55 server id 1  end_log_pos 20423 CRC32 0x41667dc0 	Query	thread_id=272	exec_time=0	error_code=0
SET TIMESTAMP=1773901435/*!*/;
BEGIN
/*!*/;
# at 20423
#260319 14:23:55 server id 1  end_log_pos 20521 CRC32 0x5f77dd96 	Table_map: `mung_bean_cake_mall`.`address` mapped to number 111
# at 20521
#260319 14:23:55 server id 1  end_log_pos 20704 CRC32 0x0e06d49f 	Write_rows: table id 111 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`address`
### SET
###   @1=1
###   @2=1
###   @3='??'
###   @4='13800138001'
###   @5='???'
###   @6='???'
###   @7='???'
###   @8='?????A?1001?'
###   @9=1
###   @10='2026-03-19 14:23:55'
###   @11='2026-03-19 14:23:55'
### INSERT INTO `mung_bean_cake_mall`.`address`
### SET
###   @1=2
###   @2=2
###   @3='??'
###   @4='13800138002'
###   @5='???'
###   @6='???'
###   @7='???'
###   @8='???88?SOHO???B?2002'
###   @9=1
###   @10='2026-03-19 14:23:55'
###   @11='2026-03-19 14:23:55'
# at 20704
#260319 14:23:55 server id 1  end_log_pos 20735 CRC32 0x20a46cd9 	Xid = 2047
COMMIT/*!*/;
# at 20735
# at 20814
#260319 14:27:59 server id 1  end_log_pos 21048 CRC32 0x9e3a8b6d 	Query	thread_id=274	exec_time=0	error_code=0	Xid = 2057
SET TIMESTAMP=1773901679/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE user ADD COLUMN header_background VARCHAR(500) DEFAULT NULL COMMENT '涓汉涓績澶撮儴鑳屾櫙鍥剧墖 URL'
/*!*/;
# at 21048
# at 21127
#260319 14:34:25 server id 1  end_log_pos 21234 CRC32 0x10812a0e 	Query	thread_id=287	exec_time=0	error_code=0
SET TIMESTAMP=1773902065/*!*/;
BEGIN
/*!*/;
# at 21234
#260319 14:34:25 server id 1  end_log_pos 21327 CRC32 0xae790db5 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 112
# at 21327
#260319 14:34:25 server id 1  end_log_pos 21673 CRC32 0xa0bb928d 	Update_rows: table id 112 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='???'
###   @5='https://api.dicebear.com/7.x/avataaars/svg?seed=admin'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:23:55'
###   @9=NULL
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='???'
###   @5=NULL
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:34:25'
###   @9=NULL
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=2
###   @2='user1'
###   @3='123456'
###   @4='??'
###   @5='https://api.dicebear.com/7.x/avataaars/svg?seed=user1'
###   @6='13800138001'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:23:55'
###   @9=NULL
### SET
###   @1=2
###   @2='user1'
###   @3='123456'
###   @4='??'
###   @5=NULL
###   @6='13800138001'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:34:25'
###   @9=NULL
# at 21673
#260319 14:34:25 server id 1  end_log_pos 21704 CRC32 0xef260702 	Xid = 2120
COMMIT/*!*/;
# at 21704
# at 21783
#260319 15:04:33 server id 1  end_log_pos 21890 CRC32 0x7c053fb3 	Query	thread_id=296	exec_time=0	error_code=0
SET TIMESTAMP=1773903873/*!*/;
BEGIN
/*!*/;
# at 21890
#260319 15:04:33 server id 1  end_log_pos 21983 CRC32 0xe682ce3d 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 112
# at 21983
#260319 15:04:33 server id 1  end_log_pos 22185 CRC32 0xb3b5b853 	Update_rows: table id 112 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='???'
###   @5=NULL
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 14:34:25'
###   @9=NULL
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='li'
###   @5='../images/mine/avatar-default.jpg'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 15:04:33'
###   @9='../images/mine/header-bg.jpg'
# at 22185
#260319 15:04:33 server id 1  end_log_pos 22216 CRC32 0x83dd7aa1 	Xid = 2227
COMMIT/*!*/;
# at 22216
# at 22295
#260319 15:27:12 server id 1  end_log_pos 22402 CRC32 0x6aa56061 	Query	thread_id=296	exec_time=0	error_code=0
SET TIMESTAMP=1773905232/*!*/;
BEGIN
/*!*/;
# at 22402
#260319 15:27:12 server id 1  end_log_pos 22495 CRC32 0xe48d90a1 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 112
# at 22495
#260319 15:27:12 server id 1  end_log_pos 22762 CRC32 0x2b15821e 	Update_rows: table id 112 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='li'
###   @5='../images/mine/avatar-default.jpg'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 15:04:33'
###   @9='../images/mine/header-bg.jpg'
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='寮?
###   @5='../images/mine/avatar-default.jpg'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 15:27:12'
###   @9='../images/mine/header-bg.jpg'
# at 22762
#260319 15:27:12 server id 1  end_log_pos 22793 CRC32 0x3cb1d366 	Xid = 2262
COMMIT/*!*/;
# at 22793
# at 22872
#260319 15:46:57 server id 1  end_log_pos 22979 CRC32 0x5c7db4af 	Query	thread_id=318	exec_time=0	error_code=0
SET TIMESTAMP=1773906417/*!*/;
BEGIN
/*!*/;
# at 22979
#260319 15:46:57 server id 1  end_log_pos 23078 CRC32 0xf02eec2d 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 110
# at 23078
#260319 15:46:57 server id 1  end_log_pos 23445 CRC32 0x5d5b4b8e 	Update_rows: table id 110 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=1
###   @2='???????'
###   @3='??????????????????'
###   @4=19.90
###   @5=39.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=traditional%20Chinese%20mung%20bean%20cake%20food%20photography&image_size=square'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
### SET
###   @1=1
###   @2='浼犵粺缁胯眴绯?
###   @3='??????????????????'
###   @4=19.90
###   @5=39.90
###   @6='/images/product/product1.jpg'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 15:46:57'
# at 23445
#260319 15:46:57 server id 1  end_log_pos 23476 CRC32 0xb60f1f17 	Xid = 2351
COMMIT/*!*/;
# at 23476
# at 23555
#260319 15:48:08 server id 1  end_log_pos 23662 CRC32 0x92262dfe 	Query	thread_id=321	exec_time=0	error_code=0
SET TIMESTAMP=1773906488/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 23662
#260319 15:48:08 server id 1  end_log_pos 23761 CRC32 0xe65beadd 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 110
# at 23761
#260319 15:48:08 server id 1  end_log_pos 24009 CRC32 0x48b79d45 	Update_rows: table id 110 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=1
###   @2='浼犵粺缁胯眴绯?
###   @3='??????????????????'
###   @4=19.90
###   @5=39.90
###   @6='/images/product/product1.jpg'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 15:46:57'
### SET
###   @1=1
###   @2='?????'
###   @3='??????????????????'
###   @4=19.90
###   @5=39.90
###   @6='/images/product/product1.jpg'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 15:48:08'
# at 24009
#260319 15:48:08 server id 1  end_log_pos 24040 CRC32 0x8bec77ff 	Xid = 2364
COMMIT/*!*/;
# at 24040
# at 24119
#260319 16:15:54 server id 1  end_log_pos 24217 CRC32 0x57e95cea 	Query	thread_id=336	exec_time=0	error_code=0
SET TIMESTAMP=1773908154/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 24217
#260319 16:15:54 server id 1  end_log_pos 24322 CRC32 0x7fcfc8b7 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 24322
#260319 16:15:54 server id 1  end_log_pos 24472 CRC32 0x4daa2d94 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=5
###   @2='product1.jpg'
###   @3='product1.jpg'
###   @4='/images/product/product1.jpg'
###   @5='image/jpeg'
###   @6=50000
###   @7=NULL
###   @8='product'
###   @9='1'
###   @10=0
###   @11=1
###   @12='2026-03-19 16:15:54'
###   @13='2026-03-19 16:15:54'
# at 24472
#260319 16:15:54 server id 1  end_log_pos 24503 CRC32 0x03ff4947 	Xid = 2469
COMMIT/*!*/;
# at 24503
# at 24582
#260319 16:15:54 server id 1  end_log_pos 24680 CRC32 0x9559165c 	Query	thread_id=336	exec_time=0	error_code=0
SET TIMESTAMP=1773908154/*!*/;
BEGIN
/*!*/;
# at 24680
#260319 16:15:54 server id 1  end_log_pos 24785 CRC32 0xa45a3d56 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 24785
#260319 16:15:54 server id 1  end_log_pos 24935 CRC32 0xa72b6c19 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=6
###   @2='product2.jpg'
###   @3='product2.jpg'
###   @4='/images/product/product2.jpg'
###   @5='image/jpeg'
###   @6=50000
###   @7=NULL
###   @8='product'
###   @9='2'
###   @10=0
###   @11=1
###   @12='2026-03-19 16:15:54'
###   @13='2026-03-19 16:15:54'
# at 24935
#260319 16:15:54 server id 1  end_log_pos 24966 CRC32 0x46360af9 	Xid = 2470
COMMIT/*!*/;
# at 24966
# at 25045
#260319 16:15:54 server id 1  end_log_pos 25143 CRC32 0xb4b2f094 	Query	thread_id=336	exec_time=0	error_code=0
SET TIMESTAMP=1773908154/*!*/;
BEGIN
/*!*/;
# at 25143
#260319 16:15:54 server id 1  end_log_pos 25248 CRC32 0xdc6ff202 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 25248
#260319 16:15:54 server id 1  end_log_pos 25398 CRC32 0x06a974e0 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=7
###   @2='product3.jpg'
###   @3='product3.jpg'
###   @4='/images/product/product3.jpg'
###   @5='image/jpeg'
###   @6=50000
###   @7=NULL
###   @8='product'
###   @9='3'
###   @10=0
###   @11=1
###   @12='2026-03-19 16:15:54'
###   @13='2026-03-19 16:15:54'
# at 25398
#260319 16:15:54 server id 1  end_log_pos 25429 CRC32 0x32d9be88 	Xid = 2471
COMMIT/*!*/;
# at 25429
# at 25508
#260319 16:15:54 server id 1  end_log_pos 25606 CRC32 0x2e591b06 	Query	thread_id=336	exec_time=0	error_code=0
SET TIMESTAMP=1773908154/*!*/;
BEGIN
/*!*/;
# at 25606
#260319 16:15:54 server id 1  end_log_pos 25711 CRC32 0x5490129a 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 25711
#260319 16:15:54 server id 1  end_log_pos 25861 CRC32 0xe9427a56 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=8
###   @2='product4.jpg'
###   @3='product4.jpg'
###   @4='/images/product/product4.jpg'
###   @5='image/jpeg'
###   @6=50000
###   @7=NULL
###   @8='product'
###   @9='4'
###   @10=0
###   @11=1
###   @12='2026-03-19 16:15:54'
###   @13='2026-03-19 16:15:54'
# at 25861
#260319 16:15:54 server id 1  end_log_pos 25892 CRC32 0x3c7c21ca 	Xid = 2472
COMMIT/*!*/;
# at 25892
# at 25969
#260319 16:26:03 server id 1  end_log_pos 26142 CRC32 0x8574c369 	Query	thread_id=348	exec_time=0	error_code=0	Xid = 2547
SET TIMESTAMP=1773908763/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE product ADD COLUMN status TINYINT DEFAULT 1
/*!*/;
# at 26142
# at 26219
#260319 16:26:03 server id 1  end_log_pos 26392 CRC32 0xa7f7488e 	Query	thread_id=348	exec_time=0	error_code=0	Xid = 2548
SET TIMESTAMP=1773908763/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE product ADD COLUMN sort_order INT DEFAULT 0
/*!*/;
# at 26392
# at 26471
#260319 16:30:40 server id 1  end_log_pos 26650 CRC32 0x681ae9a2 	Query	thread_id=351	exec_time=0	error_code=0	Xid = 2562
SET TIMESTAMP=1773909040/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE product ADD COLUMN tags VARCHAR(255) DEFAULT NULL
/*!*/;
# at 26650
# at 26729
#260319 16:42:51 server id 1  end_log_pos 26836 CRC32 0xde30271f 	Query	thread_id=364	exec_time=0	error_code=0
SET TIMESTAMP=1773909771/*!*/;
BEGIN
/*!*/;
# at 26836
#260319 16:42:51 server id 1  end_log_pos 26940 CRC32 0x0122019b 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 26940
#260319 16:42:51 server id 1  end_log_pos 27352 CRC32 0x03aaf645 	Update_rows: table id 115 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=1
###   @2='?????'
###   @3='??????????????????'
###   @4=19.90
###   @5=39.90
###   @6='/images/product/product1.jpg'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 15:48:08'
###   @13=1
###   @14=0
###   @15=NULL
### SET
###   @1=1
###   @2='缁胯眴绯?缁忓吀鍘熷懗 浼犵粺绯曠偣'
###   @3='绮鹃€変紭璐ㄧ豢璞嗭紝浼犵粺宸ヨ壓鍒朵綔锛屽彛鎰熺粏鑵伙紝鐢滆€屼笉鑵汇€傜嫭绔嬪皬鍖呰锛屾柟渚挎惡甯︼紝鏄笅鍗堣尪鍜屼紤闂叉椂鍒荤殑鐞嗘兂閫夋嫨銆?
###   @4=19.90
###   @5=39.90
###   @6='/images/product/product1.jpg'
###   @7=NULL
###   @8=1256
###   @9=500
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:42:51'
###   @13=1
###   @14=0
###   @15=NULL
# at 27352
#260319 16:42:51 server id 1  end_log_pos 27383 CRC32 0x96c0552c 	Xid = 2692
COMMIT/*!*/;
# at 27383
# at 27462
#260319 16:43:16 server id 1  end_log_pos 27569 CRC32 0x58d07992 	Query	thread_id=365	exec_time=0	error_code=0
SET TIMESTAMP=1773909796/*!*/;
BEGIN
/*!*/;
# at 27569
#260319 16:43:16 server id 1  end_log_pos 27673 CRC32 0x6f077e70 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 27673
#260319 16:43:16 server id 1  end_log_pos 28277 CRC32 0x9015c627 	Update_rows: table id 115 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=2
###   @2='??????'
###   @3='????????????'
###   @4=25.90
###   @5=49.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=matcha%20mung%20bean%20cake%20green%20tea%20dessert&image_size=square'
###   @7=NULL
###   @8=892
###   @9=300
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
###   @13=1
###   @14=0
###   @15=NULL
### SET
###   @1=2
###   @2='妗傝姳缁胯眴绯?娓呴鎬′汉'
###   @3='鍦ㄧ豢璞嗙硶鐨勫熀纭€涓婃坊鍔犲ぉ鐒舵鑺憋紝娓呴鎬′汉锛屽彛鎰熶赴瀵屻€傞噰鐢ㄤ紶缁熼厤鏂癸紝鎵嬪伐鍒朵綔锛屾瘡涓€鍙ｉ兘鏄効鏃剁殑鍛抽亾銆?
###   @4=25.90
###   @5=49.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=matcha%20mung%20bean%20cake%20green%20tea%20dessert&image_size=square'
###   @7=NULL
###   @8=892
###   @9=300
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:43:16'
###   @13=1
###   @14=0
###   @15=NULL
# at 28277
#260319 16:43:16 server id 1  end_log_pos 28308 CRC32 0x84f4540d 	Xid = 2695
COMMIT/*!*/;
# at 28308
# at 28387
#260319 16:43:29 server id 1  end_log_pos 28494 CRC32 0x264b3f58 	Query	thread_id=366	exec_time=0	error_code=0
SET TIMESTAMP=1773909809/*!*/;
BEGIN
/*!*/;
# at 28494
#260319 16:43:29 server id 1  end_log_pos 28598 CRC32 0xe77c13b2 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 28598
#260319 16:43:29 server id 1  end_log_pos 29206 CRC32 0x727ee5e7 	Update_rows: table id 115 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=3
###   @2='?????'
###   @3='???????????'
###   @4=22.90
###   @5=45.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=osmanthus%20mung%20bean%20cake%20sweet%20dessert&image_size=square'
###   @7=NULL
###   @8=567
###   @9=200
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
###   @13=1
###   @14=0
###   @15=NULL
### SET
###   @1=3
###   @2='妗冨北鏈堥ゼ 涓绀肩洅瑁?
###   @3='绮鹃€夋灞辩毊锛岄鏂欓ケ婊★紝鍙ｆ劅缁靛瘑銆傜簿缇庣ぜ鐩掑寘瑁咃紝閫傚悎涓浣宠妭閫佺ぜ鎴栧搴垎浜€備紶缁熷伐鑹轰笌鐜颁唬鍙ｅ懗鐨勫畬缇庣粨鍚堛€?
###   @4=22.90
###   @5=45.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=osmanthus%20mung%20bean%20cake%20sweet%20dessert&image_size=square'
###   @7=NULL
###   @8=567
###   @9=200
###   @10='鏈堥ゼ'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:43:29'
###   @13=1
###   @14=0
###   @15=NULL
# at 29206
#260319 16:43:29 server id 1  end_log_pos 29237 CRC32 0xb3edf3e0 	Xid = 2698
COMMIT/*!*/;
# at 29237
# at 29316
#260319 16:44:02 server id 1  end_log_pos 29423 CRC32 0x6e19d00c 	Query	thread_id=367	exec_time=0	error_code=0
SET TIMESTAMP=1773909842/*!*/;
BEGIN
/*!*/;
# at 29423
#260319 16:44:02 server id 1  end_log_pos 29527 CRC32 0x9bbe5fda 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 29527
#260319 16:44:02 server id 1  end_log_pos 30126 CRC32 0xfdbd2aad 	Update_rows: table id 115 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=4
###   @2='?????'
###   @3='????????????????'
###   @4=28.90
###   @5=55.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=sugar%20free%20mung%20bean%20cake%20healthy%20dessert&image_size=square'
###   @7=NULL
###   @8=432
###   @9=150
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
###   @13=1
###   @14=0
###   @15=NULL
### SET
###   @1=4
###   @2='绾㈣眴绯?浼犵粺鎵嬪伐鍒朵綔'
###   @3='閫夌敤浼樿川绾㈣眴锛岀粡杩囧閬撳伐搴忕簿蹇冨埗浣滐紝鍙ｆ劅杞朝锛岀敎搴﹂€備腑銆備笉鍚坊鍔犲墏锛屽仴搴风編鍛筹紝鑰佸皯鐨嗗疁銆?
###   @4=28.90
###   @5=55.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=sugar%20free%20mung%20bean%20cake%20healthy%20dessert&image_size=square'
###   @7=NULL
###   @8=432
###   @9=150
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:44:02'
###   @13=1
###   @14=0
###   @15=NULL
# at 30126
#260319 16:44:02 server id 1  end_log_pos 30157 CRC32 0x33c06e4c 	Xid = 2701
COMMIT/*!*/;
# at 30157
# at 30236
#260319 16:44:15 server id 1  end_log_pos 30343 CRC32 0x681e0f5d 	Query	thread_id=368	exec_time=0	error_code=0
SET TIMESTAMP=1773909855/*!*/;
BEGIN
/*!*/;
# at 30343
#260319 16:44:15 server id 1  end_log_pos 30447 CRC32 0xfcd78258 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 30447
#260319 16:44:15 server id 1  end_log_pos 31039 CRC32 0xd5f87541 	Update_rows: table id 115 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=5
###   @2='?????'
###   @3='??????????'
###   @4=23.90
###   @5=46.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=purple%20sweet%20potato%20mung%20bean%20cake%20dessert&image_size=square'
###   @7=NULL
###   @8=678
###   @9=250
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
###   @13=1
###   @14=0
###   @15=NULL
### SET
###   @1=5
###   @2='鑺濋夯绯?棣欐祿钀ュ吇'
###   @3='閲囩敤榛戣姖楹诲拰鐧借姖楹绘贩鍚堝埗浣滐紝棣欐皵娴撻儊锛岃惀鍏讳赴瀵屻€傚彛鎰熺粏鑵伙紝鍏ュ彛鍗冲寲锛屾槸鍏荤敓淇濆仴鐨勪紶缁熺編椋熴€?
###   @4=23.90
###   @5=46.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=purple%20sweet%20potato%20mung%20bean%20cake%20dessert&image_size=square'
###   @7=NULL
###   @8=678
###   @9=250
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:44:15'
###   @13=1
###   @14=0
###   @15=NULL
# at 31039
#260319 16:44:15 server id 1  end_log_pos 31070 CRC32 0x1a2ba396 	Xid = 2704
COMMIT/*!*/;
# at 31070
# at 31149
#260319 16:44:33 server id 1  end_log_pos 31256 CRC32 0x320fcd8c 	Query	thread_id=369	exec_time=0	error_code=0
SET TIMESTAMP=1773909873/*!*/;
BEGIN
/*!*/;
# at 31256
#260319 16:44:33 server id 1  end_log_pos 31360 CRC32 0x577e8ee6 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 31360
#260319 16:44:33 server id 1  end_log_pos 31941 CRC32 0x19c382f8 	Update_rows: table id 115 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`product`
### WHERE
###   @1=6
###   @2='?????'
###   @3='?????????'
###   @4=26.90
###   @5=52.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=coconut%20mung%20bean%20cake%20tropical%20dessert&image_size=square'
###   @7=NULL
###   @8=345
###   @9=180
###   @10='????'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 14:23:55'
###   @13=1
###   @14=0
###   @15=NULL
### SET
###   @1=6
###   @2='缁胯眴鍐扮硶 娓呭噳瑙ｆ殤'
###   @3='澶忔棩蹇呭娓呭噳绯曠偣锛岀豢璞嗘竻棣欙紝鍙ｆ劅鍐扮埥銆傞噰鐢ㄧ幇浠ｅ喎鍐绘妧鏈紝淇濈暀浼犵粺椋庡懗鐨勫悓鏃舵洿鍔犵埥鍙ｅ疁浜恒€?
###   @4=26.90
###   @5=52.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=coconut%20mung%20bean%20cake%20tropical%20dessert&image_size=square'
###   @7=NULL
###   @8=345
###   @9=180
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:44:33'
###   @13=1
###   @14=0
###   @15=NULL
# at 31941
#260319 16:44:33 server id 1  end_log_pos 31972 CRC32 0xb12bbb4c 	Xid = 2707
COMMIT/*!*/;
# at 31972
# at 32051
#260319 16:45:00 server id 1  end_log_pos 32149 CRC32 0xae2e7395 	Query	thread_id=370	exec_time=0	error_code=0
SET TIMESTAMP=1773909900/*!*/;
BEGIN
/*!*/;
# at 32149
#260319 16:45:00 server id 1  end_log_pos 32254 CRC32 0x6e8e7427 	Table_map: `mung_bean_cake_mall`.`image_file` mapped to number 97
# at 32254
#260319 16:45:00 server id 1  end_log_pos 32518 CRC32 0xe308d705 	Write_rows: table id 97 flags: STMT_END_F
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=9
###   @2='product5.jpg'
###   @3='product5.jpg'
###   @4='/images/product/product5.jpg'
###   @5='image/jpeg'
###   @6=50000
###   @7=NULL
###   @8='product'
###   @9='5'
###   @10=0
###   @11=1
###   @12='2026-03-19 16:45:00'
###   @13='2026-03-19 16:45:00'
### INSERT INTO `mung_bean_cake_mall`.`image_file`
### SET
###   @1=10
###   @2='product6.jpg'
###   @3='product6.jpg'
###   @4='/images/product/product6.jpg'
###   @5='image/jpeg'
###   @6=50000
###   @7=NULL
###   @8='product'
###   @9='6'
###   @10=0
###   @11=1
###   @12='2026-03-19 16:45:00'
###   @13='2026-03-19 16:45:00'
# at 32518
#260319 16:45:00 server id 1  end_log_pos 32549 CRC32 0x0883808c 	Xid = 2710
COMMIT/*!*/;
# at 32549
# at 32628
#260319 16:51:22 server id 1  end_log_pos 32718 CRC32 0x8351cdee 	Query	thread_id=372	exec_time=0	error_code=0
SET TIMESTAMP=1773910282/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 32718
#260319 16:51:22 server id 1  end_log_pos 32822 CRC32 0x3dc0a4a7 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 115
# at 32822
#260319 16:51:22 server id 1  end_log_pos 33551 CRC32 0xa1b2f01a 	Delete_rows: table id 115 flags: STMT_END_F
### DELETE FROM `mung_bean_cake_mall`.`product`
### WHERE
###   @1=5
###   @2='鑺濋夯绯?棣欐祿钀ュ吇'
###   @3='閲囩敤榛戣姖楹诲拰鐧借姖楹绘贩鍚堝埗浣滐紝棣欐皵娴撻儊锛岃惀鍏讳赴瀵屻€傚彛鎰熺粏鑵伙紝鍏ュ彛鍗冲寲锛屾槸鍏荤敓淇濆仴鐨勪紶缁熺編椋熴€?
###   @4=23.90
###   @5=46.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=purple%20sweet%20potato%20mung%20bean%20cake%20dessert&image_size=square'
###   @7=NULL
###   @8=678
###   @9=250
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:44:15'
###   @13=1
###   @14=0
###   @15=NULL
### DELETE FROM `mung_bean_cake_mall`.`product`
### WHERE
###   @1=6
###   @2='缁胯眴鍐扮硶 娓呭噳瑙ｆ殤'
###   @3='澶忔棩蹇呭娓呭噳绯曠偣锛岀豢璞嗘竻棣欙紝鍙ｆ劅鍐扮埥銆傞噰鐢ㄧ幇浠ｅ喎鍐绘妧鏈紝淇濈暀浼犵粺椋庡懗鐨勫悓鏃舵洿鍔犵埥鍙ｅ疁浜恒€?
###   @4=26.90
###   @5=52.90
###   @6='https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=coconut%20mung%20bean%20cake%20tropical%20dessert&image_size=square'
###   @7=NULL
###   @8=345
###   @9=180
###   @10='绯曠偣'
###   @11='2026-03-19 14:23:55'
###   @12='2026-03-19 16:44:33'
###   @13=1
###   @14=0
###   @15=NULL
# at 33551
#260319 16:51:22 server id 1  end_log_pos 33582 CRC32 0xa594df4b 	Xid = 2750
COMMIT/*!*/;
# at 33582
# at 33661
#260319 18:41:06 server id 1  end_log_pos 33768 CRC32 0x40caf41f 	Query	thread_id=405	exec_time=0	error_code=0
SET TIMESTAMP=1773916866/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 33768
#260319 18:41:06 server id 1  end_log_pos 33861 CRC32 0x9ee5c0ae 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 112
# at 33861
#260319 18:41:06 server id 1  end_log_pos 34129 CRC32 0x8b3ff9b5 	Update_rows: table id 112 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='寮?
###   @5='../images/mine/avatar-default.jpg'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 15:27:12'
###   @9='../images/mine/header-bg.jpg'
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='鏉?
###   @5='../images/mine/avatar-default.jpg'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 18:41:06'
###   @9='../images/mine/header-bg.jpg'
# at 34129
#260319 18:41:06 server id 1  end_log_pos 34160 CRC32 0xb65078e5 	Xid = 3098
COMMIT/*!*/;
# at 34160
# at 34239
#260319 18:42:52 server id 1  end_log_pos 34346 CRC32 0xbfdea241 	Query	thread_id=415	exec_time=0	error_code=0
SET TIMESTAMP=1773916972/*!*/;
BEGIN
/*!*/;
# at 34346
#260319 18:42:52 server id 1  end_log_pos 34439 CRC32 0x775cc3aa 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 112
# at 34439
#260319 18:42:52 server id 1  end_log_pos 34713 CRC32 0x270a5d90 	Update_rows: table id 112 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='鏉?
###   @5='../images/mine/avatar-default.jpg'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 18:41:06'
###   @9='../images/mine/header-bg.jpg'
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='鏉?
###   @5='/images/user/1/avatar/1773916970335.png'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 18:42:52'
###   @9='../images/mine/header-bg.jpg'
# at 34713
#260319 18:42:52 server id 1  end_log_pos 34744 CRC32 0x0970cfc4 	Xid = 3175
COMMIT/*!*/;
# at 34744
# at 34823
#260319 18:43:11 server id 1  end_log_pos 34930 CRC32 0xb8ff7779 	Query	thread_id=415	exec_time=0	error_code=0
SET TIMESTAMP=1773916991/*!*/;
BEGIN
/*!*/;
# at 34930
#260319 18:43:11 server id 1  end_log_pos 35023 CRC32 0x25f46097 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 112
# at 35023
#260319 18:43:11 server id 1  end_log_pos 35303 CRC32 0xf488d352 	Update_rows: table id 112 flags: STMT_END_F
### UPDATE `mung_bean_cake_mall`.`user`
### WHERE
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='鏉?
###   @5='/images/user/1/avatar/1773916970335.png'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 18:42:52'
###   @9='../images/mine/header-bg.jpg'
### SET
###   @1=1
###   @2='admin'
###   @3='123456'
###   @4='鏉?
###   @5='/images/user/1/avatar/1773916987681.png'
###   @6='13800138000'
###   @7='2026-03-19 14:23:55'
###   @8='2026-03-19 18:43:11'
###   @9='../images/mine/header-bg.jpg'
# at 35303
#260319 18:43:11 server id 1  end_log_pos 35334 CRC32 0x36fcefc8 	Xid = 3184
COMMIT/*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;

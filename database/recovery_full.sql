# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#260331 16:48:13 server id 1  end_log_pos 126 CRC32 0xb226544b 	Start: binlog v 4, server v 8.0.44 created 260331 16:48:13 at startup
ROLLBACK/*!*/;
BINLOG '
TYrLaQ8BAAAAegAAAH4AAAAAAAQAOC4wLjQ0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAABNistpEwANAAgAAAAABAAEAAAAYgAEGggAAAAICAgCAAAACgoKKioAEjQA
CigAAUtUJrI=
'/*!*/;
/*!50616 SET @@SESSION.GTID_NEXT='AUTOMATIC'*//*!*/;
# at 126
# at 157
# at 236
#260401  0:29:04 server id 1  end_log_pos 598 CRC32 0x9dbdea47 	Query	thread_id=60	exec_time=0	error_code=0	Xid = 280
use `mung_bean_cake_mall`/*!*/;
SET TIMESTAMP=1774974544/*!*/;
SET @@session.pseudo_thread_id=60/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1168113696/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS carousel (id BIGINT NOT NULL AUTO_INCREMENT, image_url VARCHAR(500) NOT NULL, link_url VARCHAR(500) DEFAULT NULL, title VARCHAR(100) DEFAULT NULL, sort_order INT DEFAULT 0, enabled TINYINT DEFAULT 1, PRIMARY KEY (id))
/*!*/;
# at 598
# at 677
#260401  0:29:04 server id 1  end_log_pos 767 CRC32 0xfa4f2228 	Query	thread_id=60	exec_time=0	error_code=0
SET TIMESTAMP=1774974544/*!*/;
BEGIN
/*!*/;
# at 767
#260401  0:29:04 server id 1  end_log_pos 852 CRC32 0x241b9fea 	Table_map: `mung_bean_cake_mall`.`carousel` mapped to number 92
# at 852
#260401  0:29:04 server id 1  end_log_pos 1070 CRC32 0x4caac985 	Write_rows: table id 92 flags: STMT_END_F

BINLOG '
UPbLaRMBAAAAVQAAAFQDAAAAAFwAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACGNhcm91c2Vs
AAYIDw8PAwEG0AfQB5ABPAEBAAID/P8A6p8bJA==
UPbLaR4BAAAA2gAAAC4EAAAAAFwAAAAAAAEAAgAG/wQBAAAAAAAAABoAL2ltYWdlcy9iYW5uZXIv
YmFubmVyMS5qcGcRAOe7v+ixhuezleWxleekuiAxAQAAAAEEAgAAAAAAAAAaAC9pbWFnZXMvYmFu
bmVyL2Jhbm5lcjIuanBnEQDnu7/osYbns5XlsZXnpLogMgIAAAABBAMAAAAAAAAAGgAvaW1hZ2Vz
L2Jhbm5lci9iYW5uZXIzLmpwZxEA57u/6LGG57OV5bGV56S6IDMDAAAAAYXJqkw=
'/*!*/;
# at 1070
#260401  0:29:04 server id 1  end_log_pos 1101 CRC32 0xd3d7cf23 	Xid = 281
COMMIT/*!*/;
# at 1101
# at 1180
#260401  1:47:54 server id 1  end_log_pos 2003 CRC32 0xfc8c0485 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 559
SET TIMESTAMP=1774979274/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 2003
# at 2082
#260401  1:47:54 server id 1  end_log_pos 2311 CRC32 0x8717cf10 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 562
SET TIMESTAMP=1774979274/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE `user` ADD COLUMN `password_hash` VARCHAR(255) DEFAULT NULL COMMENT '密码哈希' AFTER `username`
/*!*/;
# at 2311
# at 2390
#260401  1:47:54 server id 1  end_log_pos 2603 CRC32 0x3c8bd7ea 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 594
SET TIMESTAMP=1774979274/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE `user` ADD COLUMN `wechat_openid` VARCHAR(100) DEFAULT NULL COMMENT '微信 OpenID'
/*!*/;
# at 2603
# at 2682
#260401  1:47:54 server id 1  end_log_pos 2887 CRC32 0xa0236bbf 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 604
SET TIMESTAMP=1774979274/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE `user` ADD COLUMN `qq_openid` VARCHAR(100) DEFAULT NULL COMMENT 'QQ OpenID'
/*!*/;
# at 2887
# at 2966
#260401  1:47:54 server id 1  end_log_pos 3164 CRC32 0x4ca07326 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 607
SET TIMESTAMP=1774979274/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE `user` ADD COLUMN `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱'
/*!*/;
# at 3164
# at 3243
#260401  1:47:54 server id 1  end_log_pos 3448 CRC32 0x169e54b8 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 610
SET TIMESTAMP=1774979274/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE `user` ADD COLUMN `email_verified` TINYINT DEFAULT 0 COMMENT '邮箱验证'
/*!*/;
# at 3448
# at 3527
#260401  1:47:54 server id 1  end_log_pos 3732 CRC32 0x64f99ba3 	Query	thread_id=104	exec_time=0	error_code=0	Xid = 613
SET TIMESTAMP=1774979274/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE `user` ADD COLUMN `phone_verified` TINYINT DEFAULT 0 COMMENT '手机验证'
/*!*/;
# at 3732
# at 3811
#260401  2:09:31 server id 1  end_log_pos 4625 CRC32 0xda78c456 	Query	thread_id=114	exec_time=0	error_code=0
SET TIMESTAMP=1774980571/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 4625
# at 4704
#260401  2:17:19 server id 1  end_log_pos 5518 CRC32 0x43001875 	Query	thread_id=124	exec_time=0	error_code=0
SET TIMESTAMP=1774981039/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 5518
# at 5597
#260401 13:00:07 server id 1  end_log_pos 6411 CRC32 0x68c0383b 	Query	thread_id=144	exec_time=0	error_code=0
SET TIMESTAMP=1775019607/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 6411
# at 6490
#260401 15:43:01 server id 1  end_log_pos 6588 CRC32 0xa9b519f6 	Query	thread_id=194	exec_time=0	error_code=0
SET TIMESTAMP=1775029381/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
BEGIN
/*!*/;
# at 6588
#260401 15:43:01 server id 1  end_log_pos 6673 CRC32 0x3026aa68 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 6673
#260401 15:43:01 server id 1  end_log_pos 6771 CRC32 0xe26b63d1 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
hczMaRMBAAAAVQAAABEaAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AaKomMA==
hczMaR4BAAAAYgAAAHMaAAAAAGsAAAAAAAEAAgAI/wACAAAAAAAAABVPUkQyMDI2MDQwMTE1NDMw
MTU4NDQBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmC+sGZuYL6wdFja+I=
'/*!*/;
# at 6771
#260401 15:43:01 server id 1  end_log_pos 6861 CRC32 0x45fbff11 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 6861
#260401 15:43:01 server id 1  end_log_pos 6994 CRC32 0x94becab1 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
hczMaRMBAAAAWgAAAM0aAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAR//tF
hczMaR4BAAAAhQAAAFIbAAAAAG0AAAAAAAEAAgAI/wADAAAAAAAAAAIAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gvrBscq+lA==
'/*!*/;
# at 6994
#260401 15:43:01 server id 1  end_log_pos 7025 CRC32 0xc586c51d 	Xid = 1360
COMMIT/*!*/;
# at 7025
# at 7104
#260401 15:43:55 server id 1  end_log_pos 7202 CRC32 0xf38ee738 	Query	thread_id=194	exec_time=0	error_code=0
SET TIMESTAMP=1775029435/*!*/;
BEGIN
/*!*/;
# at 7202
#260401 15:43:55 server id 1  end_log_pos 7287 CRC32 0xcea60ec4 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 7287
#260401 15:43:55 server id 1  end_log_pos 7385 CRC32 0x37263cc1 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
u8zMaRMBAAAAVQAAAHccAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AxA6mzg==
u8zMaR4BAAAAYgAAANkcAAAAAGsAAAAAAAEAAgAI/wADAAAAAAAAABVPUkQyMDI2MDQwMTE1NDM1
NTVCRkQBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmC+veZuYL698E8Jjc=
'/*!*/;
# at 7385
#260401 15:43:55 server id 1  end_log_pos 7475 CRC32 0x0fbb23e4 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 7475
#260401 15:43:55 server id 1  end_log_pos 7608 CRC32 0xcc5e3bd7 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
u8zMaRMBAAAAWgAAADMdAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDkI7sP
u8zMaR4BAAAAhQAAALgdAAAAAG0AAAAAAAEAAgAI/wAEAAAAAAAAAAMAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gvr31ztezA==
'/*!*/;
# at 7608
#260401 15:43:55 server id 1  end_log_pos 7639 CRC32 0x3809d54b 	Xid = 1395
COMMIT/*!*/;
# at 7639
# at 7718
#260401 15:44:06 server id 1  end_log_pos 7816 CRC32 0xe02fcef7 	Query	thread_id=194	exec_time=0	error_code=0
SET TIMESTAMP=1775029446/*!*/;
BEGIN
/*!*/;
# at 7816
#260401 15:44:06 server id 1  end_log_pos 7901 CRC32 0x1a5cf3aa 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 7901
#260401 15:44:06 server id 1  end_log_pos 7999 CRC32 0xcbd80494 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
xszMaRMBAAAAVQAAAN0eAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AqvNcGg==
xszMaR4BAAAAYgAAAD8fAAAAAGsAAAAAAAEAAgAI/wAEAAAAAAAAABVPUkQyMDI2MDQwMTE1NDQw
NjkzREYBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmC+waZuYL7BpQE2Ms=
'/*!*/;
# at 7999
#260401 15:44:06 server id 1  end_log_pos 8089 CRC32 0x00b2d2af 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 8089
#260401 15:44:06 server id 1  end_log_pos 8222 CRC32 0x5868cd3e 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
xszMaRMBAAAAWgAAAJkfAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCv0rIA
xszMaR4BAAAAhQAAAB4gAAAAAG0AAAAAAAEAAgAI/wAFAAAAAAAAAAQAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gvsGPs1oWA==
'/*!*/;
# at 8222
#260401 15:44:06 server id 1  end_log_pos 8253 CRC32 0x0eff14c8 	Xid = 1420
COMMIT/*!*/;
# at 8253
# at 8332
#260401 15:44:39 server id 1  end_log_pos 8430 CRC32 0x4091b3da 	Query	thread_id=196	exec_time=0	error_code=0
SET TIMESTAMP=1775029479/*!*/;
BEGIN
/*!*/;
# at 8430
#260401 15:44:39 server id 1  end_log_pos 8515 CRC32 0xaeebad3f 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 8515
#260401 15:44:39 server id 1  end_log_pos 8613 CRC32 0x741796bf 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
58zMaRMBAAAAVQAAAEMhAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AP63rrg==
58zMaR4BAAAAYgAAAKUhAAAAAGsAAAAAAAEAAgAI/wAFAAAAAAAAABVPUkQyMDI2MDQwMTE1NDQz
OTg2MUMBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmC+yeZuYL7J7+WF3Q=
'/*!*/;
# at 8613
#260401 15:44:39 server id 1  end_log_pos 8703 CRC32 0xf7514b43 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 8703
#260401 15:44:39 server id 1  end_log_pos 8836 CRC32 0x46a46254 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
58zMaRMBAAAAWgAAAP8hAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wBDS1H3
58zMaR4BAAAAhQAAAIQiAAAAAG0AAAAAAAEAAgAI/wAGAAAAAAAAAAUAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gvsnVGKkRg==
'/*!*/;
# at 8836
#260401 15:44:39 server id 1  end_log_pos 8867 CRC32 0x228d5bd3 	Xid = 1437
COMMIT/*!*/;
# at 8867
# at 8946
#260401 15:46:32 server id 1  end_log_pos 9044 CRC32 0x7fa12f6f 	Query	thread_id=194	exec_time=0	error_code=0
SET TIMESTAMP=1775029592/*!*/;
BEGIN
/*!*/;
# at 9044
#260401 15:46:32 server id 1  end_log_pos 9129 CRC32 0x0c9bdf0b 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 9129
#260401 15:46:32 server id 1  end_log_pos 9227 CRC32 0xf8211ac6 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
WM3MaRMBAAAAVQAAAKkjAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AC9+bDA==
WM3MaR4BAAAAYgAAAAskAAAAAGsAAAAAAAEAAgAI/wAGAAAAAAAAABVPUkQyMDI2MDQwMTE1NDYz
MjM0REYBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmC+6CZuYL7oMYaIfg=
'/*!*/;
# at 9227
#260401 15:46:32 server id 1  end_log_pos 9317 CRC32 0xf913f459 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 9317
#260401 15:46:32 server id 1  end_log_pos 9450 CRC32 0x95520a90 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
WM3MaRMBAAAAWgAAAGUkAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wBZ9BP5
WM3MaR4BAAAAhQAAAOokAAAAAG0AAAAAAAEAAgAI/wAHAAAAAAAAAAYAAAAAAAAABAAAAAAAAAAc
AOe6ouixhuezlSDkvKDnu5/miYvlt6XliLbkvZwbAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gvugkApSlQ==
'/*!*/;
# at 9450
#260401 15:46:32 server id 1  end_log_pos 9481 CRC32 0x025663c8 	Xid = 1476
COMMIT/*!*/;
# at 9481
# at 9560
#260401 16:10:37 server id 1  end_log_pos 9658 CRC32 0xbec65d52 	Query	thread_id=204	exec_time=0	error_code=0
SET TIMESTAMP=1775031037/*!*/;
BEGIN
/*!*/;
# at 9658
#260401 16:10:37 server id 1  end_log_pos 9743 CRC32 0x90366036 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 9743
#260401 16:10:37 server id 1  end_log_pos 9841 CRC32 0x51558544 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
/dLMaRMBAAAAVQAAAA8mAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ANmA2kA==
/dLMaR4BAAAAYgAAAHEmAAAAAGsAAAAAAAEAAgAI/wAHAAAAAAAAABVPUkQyMDI2MDQwMTE2MTAz
NzdBMzUBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDAqWZuYMCpUSFVVE=
'/*!*/;
# at 9841
#260401 16:10:37 server id 1  end_log_pos 9931 CRC32 0xc693929d 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 9931
#260401 16:10:37 server id 1  end_log_pos 10064 CRC32 0x25e4c7a2 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
/dLMaRMBAAAAWgAAAMsmAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCdkpPG
/dLMaR4BAAAAhQAAAFAnAAAAAG0AAAAAAAEAAgAI/wAIAAAAAAAAAAcAAAAAAAAABAAAAAAAAAAc
AOe6ouixhuezlSDkvKDnu5/miYvlt6XliLbkvZwbAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gwKlosfkJQ==
'/*!*/;
# at 10064
#260401 16:10:37 server id 1  end_log_pos 10095 CRC32 0xccf42140 	Xid = 1545
COMMIT/*!*/;
# at 10095
# at 10174
#260401 16:48:12 server id 1  end_log_pos 10272 CRC32 0xc29645b0 	Query	thread_id=214	exec_time=0	error_code=0
SET TIMESTAMP=1775033292/*!*/;
BEGIN
/*!*/;
# at 10272
#260401 16:48:12 server id 1  end_log_pos 10357 CRC32 0x15b9c45d 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 10357
#260401 16:48:12 server id 1  end_log_pos 10455 CRC32 0xaa8147d0 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
zNvMaRMBAAAAVQAAAHUoAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AXcS5FQ==
zNvMaR4BAAAAYgAAANcoAAAAAGsAAAAAAAEAAgAI/wAIAAAAAAAAABVPUkQyMDI2MDQwMTE2NDgx
MjYyQzUBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDDAyZuYMMDNBHgao=
'/*!*/;
# at 10455
#260401 16:48:12 server id 1  end_log_pos 10545 CRC32 0xbfeb907e 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 10545
#260401 16:48:12 server id 1  end_log_pos 10678 CRC32 0xa4331c78 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
zNvMaRMBAAAAWgAAADEpAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wB+kOu/
zNvMaR4BAAAAhQAAALYpAAAAAG0AAAAAAAEAAgAI/wAJAAAAAAAAAAgAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gwwMeBwzpA==
'/*!*/;
# at 10678
#260401 16:48:12 server id 1  end_log_pos 10709 CRC32 0x606b966e 	Xid = 1643
COMMIT/*!*/;
# at 10709
# at 10788
#260401 16:48:34 server id 1  end_log_pos 10886 CRC32 0xa201a9e8 	Query	thread_id=215	exec_time=0	error_code=0
SET TIMESTAMP=1775033314/*!*/;
BEGIN
/*!*/;
# at 10886
#260401 16:48:34 server id 1  end_log_pos 10971 CRC32 0x23fa958f 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 10971
#260401 16:48:34 server id 1  end_log_pos 11069 CRC32 0xc42907ff 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
4tvMaRMBAAAAVQAAANsqAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8Aj5X6Iw==
4tvMaR4BAAAAYgAAAD0rAAAAAGsAAAAAAAEAAgAI/wAJAAAAAAAAABVPUkQyMDI2MDQwMTE2NDgz
NEU1QTABAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDDCKZuYMMIv8HKcQ=
'/*!*/;
# at 11069
#260401 16:48:34 server id 1  end_log_pos 11159 CRC32 0x17098f18 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 11159
#260401 16:48:34 server id 1  end_log_pos 11292 CRC32 0x64dfa071 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
4tvMaRMBAAAAWgAAAJcrAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAYjwkX
4tvMaR4BAAAAhQAAABwsAAAAAG0AAAAAAAEAAgAI/wAKAAAAAAAAAAkAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gwwicaDfZA==
'/*!*/;
# at 11292
#260401 16:48:34 server id 1  end_log_pos 11323 CRC32 0x07f8fcfa 	Xid = 1659
COMMIT/*!*/;
# at 11323
# at 11402
#260401 16:49:08 server id 1  end_log_pos 11500 CRC32 0xca36e2aa 	Query	thread_id=214	exec_time=0	error_code=0
SET TIMESTAMP=1775033348/*!*/;
BEGIN
/*!*/;
# at 11500
#260401 16:49:08 server id 1  end_log_pos 11585 CRC32 0x654b4b4f 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 11585
#260401 16:49:08 server id 1  end_log_pos 11683 CRC32 0x77a066f1 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
BNzMaRMBAAAAVQAAAEEtAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AT0tLZQ==
BNzMaR4BAAAAYgAAAKMtAAAAAGsAAAAAAAEAAgAI/wAKAAAAAAAAABVPUkQyMDI2MDQwMTE2NDkw
ODRCQUQBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDDEiZuYMMSPFmoHc=
'/*!*/;
# at 11683
#260401 16:49:08 server id 1  end_log_pos 11773 CRC32 0x0ce1e68d 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 11773
#260401 16:49:08 server id 1  end_log_pos 11906 CRC32 0xcf04c466 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
BNzMaRMBAAAAWgAAAP0tAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCN5uEM
BNzMaR4BAAAAhQAAAIIuAAAAAG0AAAAAAAEAAgAI/wALAAAAAAAAAAoAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gwxIZsQEzw==
'/*!*/;
# at 11906
#260401 16:49:08 server id 1  end_log_pos 11937 CRC32 0x411ad6c2 	Xid = 1676
COMMIT/*!*/;
# at 11937
# at 12016
#260401 16:59:59 server id 1  end_log_pos 12114 CRC32 0x70b08714 	Query	thread_id=224	exec_time=0	error_code=0
SET TIMESTAMP=1775033999/*!*/;
BEGIN
/*!*/;
# at 12114
#260401 16:59:59 server id 1  end_log_pos 12199 CRC32 0xe057490d 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 12199
#260401 16:59:59 server id 1  end_log_pos 12297 CRC32 0xc5c91298 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
j97MaRMBAAAAVQAAAKcvAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ADUlX4A==
j97MaR4BAAAAYgAAAAkwAAAAAGsAAAAAAAEAAgAI/wALAAAAAAAAABVPUkQyMDI2MDQwMTE2NTk1
OTM0N0EBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDDvuZuYMO+5gSycU=
'/*!*/;
# at 12297
#260401 16:59:59 server id 1  end_log_pos 12387 CRC32 0xc7b60498 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 12387
#260401 16:59:59 server id 1  end_log_pos 12527 CRC32 0x6d7e7a77 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
j97MaRMBAAAAWgAAAGMwAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCYBLbH
j97MaR4BAAAAjAAAAO8wAAAAAG0AAAAAAAEAAgAI/wAMAAAAAAAAAAsAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMO+3d6fm0=
'/*!*/;
# at 12527
#260401 16:59:59 server id 1  end_log_pos 12558 CRC32 0xeaaacf0e 	Xid = 1771
COMMIT/*!*/;
# at 12558
# at 12637
#260401 17:01:12 server id 1  end_log_pos 12735 CRC32 0x2e4874d6 	Query	thread_id=224	exec_time=0	error_code=0
SET TIMESTAMP=1775034072/*!*/;
BEGIN
/*!*/;
# at 12735
#260401 17:01:12 server id 1  end_log_pos 12820 CRC32 0xe1e25321 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 12820
#260401 17:01:12 server id 1  end_log_pos 12918 CRC32 0x1b0c26a8 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
2N7MaRMBAAAAVQAAABQyAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AIVPi4Q==
2N7MaR4BAAAAYgAAAHYyAAAAAGsAAAAAAAEAAgAI/wAMAAAAAAAAABVPUkQyMDI2MDQwMTE3MDEx
MjNBM0QBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDEEyZuYMQTKgmDBs=
'/*!*/;
# at 12918
#260401 17:01:12 server id 1  end_log_pos 13008 CRC32 0x4a695b1b 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 13008
#260401 17:01:12 server id 1  end_log_pos 13148 CRC32 0xb2361812 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
2N7MaRMBAAAAWgAAANAyAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAbW2lK
2N7MaR4BAAAAjAAAAFwzAAAAAG0AAAAAAAEAAgAI/wANAAAAAAAAAAwAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMQTBIYNrI=
'/*!*/;
# at 13148
#260401 17:01:12 server id 1  end_log_pos 13179 CRC32 0xb683d080 	Xid = 1787
COMMIT/*!*/;
# at 13179
# at 13258
#260401 17:39:07 server id 1  end_log_pos 14072 CRC32 0xe779eac6 	Query	thread_id=256	exec_time=0	error_code=0
SET TIMESTAMP=1775036347/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 14072
# at 14151
#260401 17:40:18 server id 1  end_log_pos 14258 CRC32 0xa9f0eaaa 	Query	thread_id=267	exec_time=0	error_code=0
SET TIMESTAMP=1775036418/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 14258
#260401 17:40:18 server id 1  end_log_pos 14365 CRC32 0x26357a51 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 105
# at 14365
#260401 17:40:18 server id 1  end_log_pos 14651 CRC32 0xf6f5b5dd 	Update_rows: table id 105 flags: STMT_END_F

BINLOG '
AujMaRMBAAAAawAAAB04AAAAAGkAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABHVzZXIADwgP
Dw8PDw8SEg8PDw8BARbIAPwDkAHIAPwDUAAAANAHkAGQAZAB9H8BAQACA/z/AFF6NSY=
AujMaR8BAAAAHgEAADs5AAAAAGkAAAAAAAEAAgAP/////wQcAQAAAAAAAAAFYWRtaW4GADEyMzQ1
NgNKQVknAC9pbWFnZXMvdXNlci8xL2F2YXRhci8xNzczOTM2OTM2MDg1LnBuZwsxMzgwMDEzODAw
MJm5ZuX3mbloA+UcAC4uL2ltYWdlcy9taW5lL2hlYWRlci1iZy5qcGcAAAAcAQAAAAAAAAAFYWRt
aW4AAAYAMTIzNDU2A0pBWScAL2ltYWdlcy91c2VyLzEvYXZhdGFyLzE3NzM5MzY5MzYwODUucG5n
CzEzODAwMTM4MDAwmblm5feZuYMaEhwALi4vaW1hZ2VzL21pbmUvaGVhZGVyLWJnLmpwZwAA3bX1
9g==
'/*!*/;
# at 14651
#260401 17:40:18 server id 1  end_log_pos 14682 CRC32 0x8d4d351c 	Xid = 2138
COMMIT/*!*/;
# at 14682
# at 14761
#260401 17:40:55 server id 1  end_log_pos 14868 CRC32 0xbe910cdf 	Query	thread_id=268	exec_time=0	error_code=0
SET TIMESTAMP=1775036455/*!*/;
BEGIN
/*!*/;
# at 14868
#260401 17:40:55 server id 1  end_log_pos 14975 CRC32 0x0d0562eb 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 105
# at 14975
#260401 17:40:55 server id 1  end_log_pos 15117 CRC32 0xee17e09c 	Update_rows: table id 105 flags: STMT_END_F

BINLOG '
J+jMaRMBAAAAawAAAH86AAAAAGkAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABHVzZXIADwgP
Dw8PDw8SEg8PDw8BARbIAPwDkAHIAPwDUAAAANAHkAGQAZAB9H8BAQACA/z/AOtiBQ0=
J+jMaR8BAAAAjgAAAA07AAAAAGkAAAAAAAEAAgAP/////yQeAgAAAAAAAAAFdXNlcjEGADEyMzQ1
NgI/PwsxMzgwMDEzODAwMZm5ZuX3mblm6JkAACAeAgAAAAAAAAAFdXNlcjEAAAYAMTIzNDU2Aj8/
CzEzODAwMTM4MDAxmblm5feZuYMaNwAAnOAX7g==
'/*!*/;
# at 15117
#260401 17:40:55 server id 1  end_log_pos 15148 CRC32 0x0478506e 	Xid = 2143
COMMIT/*!*/;
# at 15148
# at 15227
#260401 17:41:40 server id 1  end_log_pos 15325 CRC32 0x4932966c 	Query	thread_id=269	exec_time=0	error_code=0
SET TIMESTAMP=1775036500/*!*/;
BEGIN
/*!*/;
# at 15325
#260401 17:41:40 server id 1  end_log_pos 15425 CRC32 0x1a5bcca1 	Table_map: `mung_bean_cake_mall`.`verification_code` mapped to number 106
# at 15425
#260401 17:41:40 server id 1  end_log_pos 15505 CRC32 0x68597f6f 	Write_rows: table id 106 flags: STMT_END_F

BINLOG '
VOjMaRMBAAAAZAAAAEE8AAAAAGoAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwAEXZlcmlmaWNh
dGlvbl9jb2RlAAgIDw8PDxIBEgpQAJABKABQAAAAxgEBAAID/P8AocxbGg==
VOjMaR4BAAAAUAAAAJE8AAAAAGoAAAAAAAEAAgAI/wQBAAAAAAAAAAsxMzgwMDEzODAwMAYxMjM0
NTYFbG9naW6ZuYMc6ACZuYMaaG9/WWg=
'/*!*/;
# at 15505
#260401 17:41:40 server id 1  end_log_pos 15536 CRC32 0x4412323b 	Xid = 2155
COMMIT/*!*/;
# at 15536
# at 15615
#260401 17:42:59 server id 1  end_log_pos 15713 CRC32 0x2502f078 	Query	thread_id=256	exec_time=0	error_code=0
SET TIMESTAMP=1775036579/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 15713
#260401 17:42:59 server id 1  end_log_pos 15798 CRC32 0x1ad77f46 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 15798
#260401 17:42:59 server id 1  end_log_pos 15896 CRC32 0x817fede6 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
o+jMaRMBAAAAVQAAALY9AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ARn/XGg==
o+jMaR4BAAAAYgAAABg+AAAAAGsAAAAAAAEAAgAI/wANAAAAAAAAABVPUkQyMDI2MDQwMTE3NDI1
OTcxNjMBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDGruZuYMau+btf4E=
'/*!*/;
# at 15896
#260401 17:42:59 server id 1  end_log_pos 15986 CRC32 0x771b0d30 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 15986
#260401 17:42:59 server id 1  end_log_pos 16126 CRC32 0xefee2dfa 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
o+jMaRMBAAAAWgAAAHI+AAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAwDRt3
o+jMaR4BAAAAjAAAAP4+AAAAAG0AAAAAAAEAAgAI/wAOAAAAAAAAAA0AAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMau/ot7u8=
'/*!*/;
# at 16126
#260401 17:42:59 server id 1  end_log_pos 16157 CRC32 0xd252c0a4 	Xid = 2176
COMMIT/*!*/;
# at 16157
# at 16236
#260401 18:10:03 server id 1  end_log_pos 17050 CRC32 0x7214fac9 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038203/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 17050
# at 17129
#260401 18:10:24 server id 1  end_log_pos 17236 CRC32 0x28391455 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038224/*!*/;
BEGIN
/*!*/;
# at 17236
#260401 18:10:24 server id 1  end_log_pos 17321 CRC32 0x8fd52fa0 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 17321
#260401 18:10:24 server id 1  end_log_pos 17483 CRC32 0x6b6e3b13 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
EO/MaRMBAAAAVQAAAKlDAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AoC/Vjw==
EO/MaR8BAAAAogAAAEtEAAAAAGsAAAAAAAEAAgAI//8ADQAAAAAAAAAVT1JEMjAyNjA0MDExNzQy
NTk3MTYzAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gxq7mbmDGrsADQAAAAAAAAAVT1JEMjAyNjA0
MDExNzQyNTk3MTYzAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gxq7mbmDIpgTO25r
'/*!*/;
# at 17483
#260401 18:10:24 server id 1  end_log_pos 17514 CRC32 0xbc19c841 	Xid = 2403
COMMIT/*!*/;
# at 17514
# at 17593
#260401 18:11:56 server id 1  end_log_pos 17700 CRC32 0x26d3cee9 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038316/*!*/;
BEGIN
/*!*/;
# at 17700
#260401 18:11:56 server id 1  end_log_pos 17785 CRC32 0xec9baf30 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 17785
#260401 18:11:56 server id 1  end_log_pos 17947 CRC32 0xfe82bf44 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
bO/MaRMBAAAAVQAAAHlFAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AMK+b7A==
bO/MaR8BAAAAogAAABtGAAAAAGsAAAAAAAEAAgAI//8ADAAAAAAAAAAVT1JEMjAyNjA0MDExNzAx
MTIzQTNEAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gxBMmbmDEEwADAAAAAAAAAAVT1JEMjAyNjA0
MDExNzAxMTIzQTNEAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gxBMmbmDIvhEv4L+
'/*!*/;
# at 17947
#260401 18:11:56 server id 1  end_log_pos 17978 CRC32 0x7b4777b2 	Xid = 2426
COMMIT/*!*/;
# at 17978
# at 18057
#260401 18:12:03 server id 1  end_log_pos 18164 CRC32 0xbb1dcbb6 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038323/*!*/;
BEGIN
/*!*/;
# at 18164
#260401 18:12:03 server id 1  end_log_pos 18249 CRC32 0xb1dcb158 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 18249
#260401 18:12:03 server id 1  end_log_pos 18411 CRC32 0x10d642d8 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
c+/MaRMBAAAAVQAAAElHAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AWLHcsQ==
c+/MaR8BAAAAogAAAOtHAAAAAGsAAAAAAAEAAgAI//8ACwAAAAAAAAAVT1JEMjAyNjA0MDExNjU5
NTkzNDdBAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gw77mbmDDvsACwAAAAAAAAAVT1JEMjAyNjA0
MDExNjU5NTkzNDdBAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gw77mbmDIwPYQtYQ
'/*!*/;
# at 18411
#260401 18:12:03 server id 1  end_log_pos 18442 CRC32 0xc6550cf3 	Xid = 2433
COMMIT/*!*/;
# at 18442
# at 18521
#260401 18:12:45 server id 1  end_log_pos 18628 CRC32 0x113f6d8a 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038365/*!*/;
BEGIN
/*!*/;
# at 18628
#260401 18:12:45 server id 1  end_log_pos 18713 CRC32 0x779a151b 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 18713
#260401 18:12:45 server id 1  end_log_pos 18875 CRC32 0x5ba6fdc2 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
ne/MaRMBAAAAVQAAABlJAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AGxWadw==
ne/MaR8BAAAAogAAALtJAAAAAGsAAAAAAAEAAgAI//8ACgAAAAAAAAAVT1JEMjAyNjA0MDExNjQ5
MDg0QkFEAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gwxImbmDDEgACgAAAAAAAAAVT1JEMjAyNjA0
MDExNjQ5MDg0QkFEAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gwxImbmDIy3C/aZb
'/*!*/;
# at 18875
#260401 18:12:45 server id 1  end_log_pos 18906 CRC32 0x983cc53c 	Xid = 2446
COMMIT/*!*/;
# at 18906
# at 18985
#260401 18:14:48 server id 1  end_log_pos 19092 CRC32 0x02f24130 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038488/*!*/;
BEGIN
/*!*/;
# at 19092
#260401 18:14:48 server id 1  end_log_pos 19177 CRC32 0xe4c31d60 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 19177
#260401 18:14:48 server id 1  end_log_pos 19339 CRC32 0x827a9a1b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
GPDMaRMBAAAAVQAAAOlKAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AYB3D5A==
GPDMaR8BAAAAogAAAItLAAAAAGsAAAAAAAEAAgAI//8ACQAAAAAAAAAVT1JEMjAyNjA0MDExNjQ4
MzRFNUEwAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gwwimbmDDCIACQAAAAAAAAAVT1JEMjAyNjA0
MDExNjQ4MzRFNUEwAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gwwimbmDI7AbmnqC
'/*!*/;
# at 19339
#260401 18:14:48 server id 1  end_log_pos 19370 CRC32 0xc7b8c4bf 	Xid = 2455
COMMIT/*!*/;
# at 19370
# at 19449
#260401 18:15:00 server id 1  end_log_pos 19556 CRC32 0x6560d54b 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038500/*!*/;
BEGIN
/*!*/;
# at 19556
#260401 18:15:00 server id 1  end_log_pos 19641 CRC32 0xb0f8c849 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 19641
#260401 18:15:00 server id 1  end_log_pos 19803 CRC32 0x88b78d15 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
JPDMaRMBAAAAVQAAALlMAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AScj4sA==
JPDMaR8BAAAAogAAAFtNAAAAAGsAAAAAAAEAAgAI//8AAQAAAAAAAAAVT1JEMjAyNjAzMzAxMTIy
MDhGMUI2AQAAAAAAAAABAAAAAAAAAIAAADVGAJm5fLWImbl8tYgAAQAAAAAAAAAVT1JEMjAyNjAz
MzAxMTIyMDhGMUI2AQAAAAAAAAABAAAAAAAAAIAAADVGBZm5fLWImbmDI8AVjbeI
'/*!*/;
# at 19803
#260401 18:15:00 server id 1  end_log_pos 19834 CRC32 0x519e6498 	Xid = 2463
COMMIT/*!*/;
# at 19834
# at 19913
#260401 18:15:06 server id 1  end_log_pos 20020 CRC32 0x2bea0223 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038506/*!*/;
BEGIN
/*!*/;
# at 20020
#260401 18:15:06 server id 1  end_log_pos 20105 CRC32 0xead73d27 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 20105
#260401 18:15:06 server id 1  end_log_pos 20267 CRC32 0xabc92290 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
KvDMaRMBAAAAVQAAAIlOAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AJz3X6g==
KvDMaR8BAAAAogAAACtPAAAAAGsAAAAAAAEAAgAI//8AAgAAAAAAAAAVT1JEMjAyNjA0MDExNTQz
MDE1ODQ0AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gvrBmbmC+sEAAgAAAAAAAAAVT1JEMjAyNjA0
MDExNTQzMDE1ODQ0AQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gvrBmbmDI8aQIsmr
'/*!*/;
# at 20267
#260401 18:15:06 server id 1  end_log_pos 20298 CRC32 0xb2e756e2 	Xid = 2471
COMMIT/*!*/;
# at 20298
# at 20377
#260401 18:17:47 server id 1  end_log_pos 20484 CRC32 0x0866e4f3 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038667/*!*/;
BEGIN
/*!*/;
# at 20484
#260401 18:17:47 server id 1  end_log_pos 20569 CRC32 0xd1ca5a87 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 20569
#260401 18:17:47 server id 1  end_log_pos 20731 CRC32 0x6879d052 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
y/DMaRMBAAAAVQAAAFlQAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8Ah1rK0Q==
y/DMaR8BAAAAogAAAPtQAAAAAGsAAAAAAAEAAgAI//8ACAAAAAAAAAAVT1JEMjAyNjA0MDExNjQ4
MTI2MkM1AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gwwMmbmDDAwACAAAAAAAAAAVT1JEMjAyNjA0
MDExNjQ4MTI2MkM1AQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gwwMmbmDJG9S0Hlo
'/*!*/;
# at 20731
#260401 18:17:47 server id 1  end_log_pos 20762 CRC32 0xcd0cbe51 	Xid = 2483
COMMIT/*!*/;
# at 20762
# at 20841
#260401 18:17:55 server id 1  end_log_pos 20948 CRC32 0x67d313cd 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038675/*!*/;
BEGIN
/*!*/;
# at 20948
#260401 18:17:55 server id 1  end_log_pos 21033 CRC32 0x75e973e1 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 21033
#260401 18:17:55 server id 1  end_log_pos 21195 CRC32 0x92b0aa49 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
0/DMaRMBAAAAVQAAAClSAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A4XPpdQ==
0/DMaR8BAAAAogAAAMtSAAAAAGsAAAAAAAEAAgAI//8AAwAAAAAAAAAVT1JEMjAyNjA0MDExNTQz
NTU1QkZEAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gvr3mbmC+vcAAwAAAAAAAAAVT1JEMjAyNjA0
MDExNTQzNTU1QkZEAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gvr3mbmDJHdJqrCS
'/*!*/;
# at 21195
#260401 18:17:55 server id 1  end_log_pos 21226 CRC32 0x56c9e852 	Xid = 2491
COMMIT/*!*/;
# at 21226
# at 21305
#260401 18:17:58 server id 1  end_log_pos 21412 CRC32 0x7a6c9911 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038678/*!*/;
BEGIN
/*!*/;
# at 21412
#260401 18:17:58 server id 1  end_log_pos 21497 CRC32 0x79834918 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 21497
#260401 18:17:58 server id 1  end_log_pos 21659 CRC32 0x5c31a93b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
1vDMaRMBAAAAVQAAAPlTAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AGEmDeQ==
1vDMaR8BAAAAogAAAJtUAAAAAGsAAAAAAAEAAgAI//8ABAAAAAAAAAAVT1JEMjAyNjA0MDExNTQ0
MDY5M0RGAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gvsGmbmC+wYABAAAAAAAAAAVT1JEMjAyNjA0
MDExNTQ0MDY5M0RGAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gvsGmbmDJHo7qTFc
'/*!*/;
# at 21659
#260401 18:17:58 server id 1  end_log_pos 21690 CRC32 0xa15f0633 	Xid = 2499
COMMIT/*!*/;
# at 21690
# at 21769
#260401 18:18:03 server id 1  end_log_pos 21876 CRC32 0x5414b681 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038683/*!*/;
BEGIN
/*!*/;
# at 21876
#260401 18:18:03 server id 1  end_log_pos 21961 CRC32 0xcd7a6240 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 21961
#260401 18:18:03 server id 1  end_log_pos 22123 CRC32 0x281d1bb9 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
2/DMaRMBAAAAVQAAAMlVAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AQGJ6zQ==
2/DMaR8BAAAAogAAAGtWAAAAAGsAAAAAAAEAAgAI//8ABwAAAAAAAAAVT1JEMjAyNjA0MDExNjEw
Mzc3QTM1AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gwKlmbmDAqUABwAAAAAAAAAVT1JEMjAyNjA0
MDExNjEwMzc3QTM1AQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gwKlmbmDJIO5Gx0o
'/*!*/;
# at 22123
#260401 18:18:03 server id 1  end_log_pos 22154 CRC32 0x747f4af7 	Xid = 2507
COMMIT/*!*/;
# at 22154
# at 22233
#260401 18:18:12 server id 1  end_log_pos 22340 CRC32 0x4a7bc160 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038692/*!*/;
BEGIN
/*!*/;
# at 22340
#260401 18:18:12 server id 1  end_log_pos 22425 CRC32 0x7797695f 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 22425
#260401 18:18:12 server id 1  end_log_pos 22587 CRC32 0x77642738 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
5PDMaRMBAAAAVQAAAJlXAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AX2mXdw==
5PDMaR8BAAAAogAAADtYAAAAAGsAAAAAAAEAAgAI//8ABgAAAAAAAAAVT1JEMjAyNjA0MDExNTQ2
MzIzNERGAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gvugmbmC+6AABgAAAAAAAAAVT1JEMjAyNjA0
MDExNTQ2MzIzNERGAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gvugmbmDJIw4J2R3
'/*!*/;
# at 22587
#260401 18:18:12 server id 1  end_log_pos 22618 CRC32 0x77752555 	Xid = 2515
COMMIT/*!*/;
# at 22618
# at 22697
#260401 18:18:14 server id 1  end_log_pos 22804 CRC32 0xbdc13fdf 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038694/*!*/;
BEGIN
/*!*/;
# at 22804
#260401 18:18:14 server id 1  end_log_pos 22889 CRC32 0x156fa779 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 22889
#260401 18:18:14 server id 1  end_log_pos 23051 CRC32 0x772931ed 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
5vDMaRMBAAAAVQAAAGlZAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AeadvFQ==
5vDMaR8BAAAAogAAAAtaAAAAAGsAAAAAAAEAAgAI//8ABQAAAAAAAAAVT1JEMjAyNjA0MDExNTQ0
Mzk4NjFDAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gvsnmbmC+ycABQAAAAAAAAAVT1JEMjAyNjA0
MDExNTQ0Mzk4NjFDAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gvsnmbmDJI7tMSl3
'/*!*/;
# at 23051
#260401 18:18:14 server id 1  end_log_pos 23082 CRC32 0xf3bb0e6c 	Xid = 2523
COMMIT/*!*/;
# at 23082
# at 23161
#260401 18:21:05 server id 1  end_log_pos 23259 CRC32 0x4fe68430 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775038865/*!*/;
BEGIN
/*!*/;
# at 23259
#260401 18:21:05 server id 1  end_log_pos 23344 CRC32 0xe0afd14c 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 23344
#260401 18:21:05 server id 1  end_log_pos 23442 CRC32 0xaa60e0e5 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
kfHMaRMBAAAAVQAAADBbAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ATNGv4A==
kfHMaR4BAAAAYgAAAJJbAAAAAGsAAAAAAAEAAgAI/wAOAAAAAAAAABVPUkQyMDI2MDQwMTE4MjEw
NTFDRTgBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDJUWZuYMlReXgYKo=
'/*!*/;
# at 23442
#260401 18:21:05 server id 1  end_log_pos 23532 CRC32 0xa258b458 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 23532
#260401 18:21:05 server id 1  end_log_pos 23672 CRC32 0x0121efbf 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
kfHMaRMBAAAAWgAAAOxbAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wBYtFii
kfHMaR4BAAAAjAAAAHhcAAAAAG0AAAAAAAEAAgAI/wAPAAAAAAAAAA4AAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMlRb/vIQE=
'/*!*/;
# at 23672
#260401 18:21:05 server id 1  end_log_pos 23703 CRC32 0xc4cbd0eb 	Xid = 2559
COMMIT/*!*/;
# at 23703
# at 23782
#260401 18:26:31 server id 1  end_log_pos 23889 CRC32 0x9801ea70 	Query	thread_id=284	exec_time=0	error_code=0
SET TIMESTAMP=1775039191/*!*/;
BEGIN
/*!*/;
# at 23889
#260401 18:26:31 server id 1  end_log_pos 23974 CRC32 0xbdb13f1b 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 23974
#260401 18:26:31 server id 1  end_log_pos 24136 CRC32 0x65c7f7d6 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
1/LMaRMBAAAAVQAAAKZdAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AGz+xvQ==
1/LMaR8BAAAAogAAAEheAAAAAGsAAAAAAAEAAgAI//8ADgAAAAAAAAAVT1JEMjAyNjA0MDExODIx
MDUxQ0U4AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyVFmbmDJUUADgAAAAAAAAAVT1JEMjAyNjA0
MDExODIxMDUxQ0U4AQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gyVFmbmDJp/W98dl
'/*!*/;
# at 24136
#260401 18:26:31 server id 1  end_log_pos 24167 CRC32 0x230f2c64 	Xid = 2574
COMMIT/*!*/;
# at 24167
# at 24246
#260401 18:35:23 server id 1  end_log_pos 24344 CRC32 0x334a04f9 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775039723/*!*/;
BEGIN
/*!*/;
# at 24344
#260401 18:35:23 server id 1  end_log_pos 24429 CRC32 0x6a4b2b52 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 24429
#260401 18:35:23 server id 1  end_log_pos 24527 CRC32 0xc957e4c2 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
6/TMaRMBAAAAVQAAAG1fAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AUitLag==
6/TMaR4BAAAAYgAAAM9fAAAAAGsAAAAAAAEAAgAI/wAPAAAAAAAAABVPUkQyMDI2MDQwMTE4MzUy
MzNERTIBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKNeZuYMo18LkV8k=
'/*!*/;
# at 24527
#260401 18:35:23 server id 1  end_log_pos 24617 CRC32 0x74c8dbc8 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 24617
#260401 18:35:23 server id 1  end_log_pos 24750 CRC32 0x133aaa54 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
6/TMaRMBAAAAWgAAAClgAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDI28h0
6/TMaR4BAAAAhQAAAK5gAAAAAG0AAAAAAAEAAgAI/wAQAAAAAAAAAA8AAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gyjXVKo6Ew==
'/*!*/;
# at 24750
#260401 18:35:23 server id 1  end_log_pos 24781 CRC32 0xe49752f0 	Xid = 2613
COMMIT/*!*/;
# at 24781
# at 24860
#260401 18:35:28 server id 1  end_log_pos 24967 CRC32 0x9d966a3e 	Query	thread_id=284	exec_time=0	error_code=0
SET TIMESTAMP=1775039728/*!*/;
BEGIN
/*!*/;
# at 24967
#260401 18:35:28 server id 1  end_log_pos 25052 CRC32 0x814e474a 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 25052
#260401 18:35:28 server id 1  end_log_pos 25214 CRC32 0x6bb11c0c 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
8PTMaRMBAAAAVQAAANxhAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ASkdOgQ==
8PTMaR8BAAAAogAAAH5iAAAAAGsAAAAAAAEAAgAI//8ADwAAAAAAAAAVT1JEMjAyNjA0MDExODM1
MjMzREUyAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyjXmbmDKNcADwAAAAAAAAAVT1JEMjAyNjA0
MDExODM1MjMzREUyAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gyjXmbmDKNwMHLFr
'/*!*/;
# at 25214
#260401 18:35:28 server id 1  end_log_pos 25245 CRC32 0xa4b8e350 	Xid = 2625
COMMIT/*!*/;
# at 25245
# at 25324
#260401 18:36:21 server id 1  end_log_pos 25422 CRC32 0x5f904a41 	Query	thread_id=284	exec_time=0	error_code=0
SET TIMESTAMP=1775039781/*!*/;
BEGIN
/*!*/;
# at 25422
#260401 18:36:21 server id 1  end_log_pos 25507 CRC32 0x0da0c25f 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 25507
#260401 18:36:21 server id 1  end_log_pos 25605 CRC32 0x872e4d5e 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
JfXMaRMBAAAAVQAAAKNjAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AX8KgDQ==
JfXMaR4BAAAAYgAAAAVkAAAAAGsAAAAAAAEAAgAI/wAQAAAAAAAAABVPUkQyMDI2MDQwMTE4MzYy
MTkxRTIBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKRWZuYMpFV5NLoc=
'/*!*/;
# at 25605
#260401 18:36:21 server id 1  end_log_pos 25695 CRC32 0x239334db 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 25695
#260401 18:36:21 server id 1  end_log_pos 25835 CRC32 0x77930461 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
JfXMaRMBAAAAWgAAAF9kAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDbNJMj
JfXMaR4BAAAAjAAAAOtkAAAAAG0AAAAAAAEAAgAI/wARAAAAAAAAABAAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMpFWEEk3c=
'/*!*/;
# at 25835
#260401 18:36:21 server id 1  end_log_pos 25866 CRC32 0x563b4983 	Xid = 2673
COMMIT/*!*/;
# at 25866
# at 25945
#260401 18:36:35 server id 1  end_log_pos 26052 CRC32 0x734f8ee8 	Query	thread_id=284	exec_time=0	error_code=0
SET TIMESTAMP=1775039795/*!*/;
BEGIN
/*!*/;
# at 26052
#260401 18:36:35 server id 1  end_log_pos 26137 CRC32 0xe238b6ae 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 26137
#260401 18:36:35 server id 1  end_log_pos 26299 CRC32 0x8c57b72b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
M/XMaRMBAAAAVQAAABlmAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ArrY44g==
M/XMaR8BAAAAogAAALtmAAAAAGsAAAAAAAEAAgAI//8AEAAAAAAAAAAVT1JEMjAyNjA0MDExODM2
MjE5MUUyAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gykVmbmDKRUAEAAAAAAAAAAVT1JEMjAyNjA0
MDExODM2MjE5MUUyAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gykVmbmDKSMrt1eM
'/*!*/;
# at 26299
#260401 18:36:35 server id 1  end_log_pos 26330 CRC32 0xb82ee592 	Xid = 2687
COMMIT/*!*/;
# at 26330
# at 26409
#260401 18:38:20 server id 1  end_log_pos 26516 CRC32 0x1ea2a740 	Query	thread_id=283	exec_time=0	error_code=0
SET TIMESTAMP=1775039900/*!*/;
BEGIN
/*!*/;
# at 26516
#260401 18:38:20 server id 1  end_log_pos 26601 CRC32 0xca6c3ee0 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 26601
#260401 18:38:20 server id 1  end_log_pos 26763 CRC32 0x9489d36b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
nPXMaRMBAAAAVQAAAOlnAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A4D5syg==
nPXMaR8BAAAAogAAAItoAAAAAGsAAAAAAAEAAgAI//8ADQAAAAAAAAAVT1JEMjAyNjA0MDExNzQy
NTk3MTYzAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gxq7mbmDIpgADQAAAAAAAAAVT1JEMjAyNjA0
MDExNzQyNTk3MTYzAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gxq7mbmDKZRr04mU
'/*!*/;
# at 26763
#260401 18:38:20 server id 1  end_log_pos 26794 CRC32 0x6f81d1f9 	Xid = 2696
COMMIT/*!*/;
# at 26794
# at 26873
#260401 18:40:22 server id 1  end_log_pos 26971 CRC32 0x90877cf8 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040022/*!*/;
BEGIN
/*!*/;
# at 26971
#260401 18:40:22 server id 1  end_log_pos 27056 CRC32 0x1a809bde 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 27056
#260401 18:40:22 server id 1  end_log_pos 27154 CRC32 0xbedad938 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
FvbMaRMBAAAAVQAAALBpAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A3puAGg==
FvbMaR4BAAAAYgAAABJqAAAAAGsAAAAAAAEAAgAI/wARAAAAAAAAABVPUkQyMDI2MDQwMTE4NDAy
Mjk2RUQBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKhaZuYMqFjjZ2r4=
'/*!*/;
# at 27154
#260401 18:40:22 server id 1  end_log_pos 27244 CRC32 0x09198266 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 27244
#260401 18:40:22 server id 1  end_log_pos 27377 CRC32 0xfba53ce4 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
FvbMaRMBAAAAWgAAAGxqAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wBmghkJ
FvbMaR4BAAAAhQAAAPFqAAAAAG0AAAAAAAEAAgAI/wASAAAAAAAAABEAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gyoW5Dyl+w==
'/*!*/;
# at 27377
#260401 18:40:22 server id 1  end_log_pos 27408 CRC32 0x787a5a95 	Xid = 2767
COMMIT/*!*/;
# at 27408
# at 27487
#260401 18:40:23 server id 1  end_log_pos 27594 CRC32 0x0aadd191 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040023/*!*/;
BEGIN
/*!*/;
# at 27594
#260401 18:40:23 server id 1  end_log_pos 27679 CRC32 0x8a53eacc 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 27679
#260401 18:40:23 server id 1  end_log_pos 27841 CRC32 0x4cf8d939 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
F/bMaRMBAAAAVQAAAB9sAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AzOpTig==
F/bMaR8BAAAAogAAAMFsAAAAAGsAAAAAAAEAAgAI//8AEQAAAAAAAAAVT1JEMjAyNjA0MDExODQw
MjI5NkVEAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyoWmbmDKhYAEQAAAAAAAAAVT1JEMjAyNjA0
MDExODQwMjI5NkVEAQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gyoWmbmDKhc52fhM
'/*!*/;
# at 27841
#260401 18:40:23 server id 1  end_log_pos 27872 CRC32 0x36c22464 	Xid = 2778
COMMIT/*!*/;
# at 27872
# at 27951
#260401 18:42:54 server id 1  end_log_pos 28049 CRC32 0xe72240ff 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040174/*!*/;
BEGIN
/*!*/;
# at 28049
#260401 18:42:54 server id 1  end_log_pos 28134 CRC32 0x8568922c 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 28134
#260401 18:42:54 server id 1  end_log_pos 28232 CRC32 0x1ce5ac96 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
rvbMaRMBAAAAVQAAAOZtAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8ALJJohQ==
rvbMaR4BAAAAYgAAAEhuAAAAAGsAAAAAAAEAAgAI/wASAAAAAAAAABVPUkQyMDI2MDQwMTE4NDI1
NEI2RDUBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKraZuYMqtpas5Rw=
'/*!*/;
# at 28232
#260401 18:42:54 server id 1  end_log_pos 28322 CRC32 0xef527d0b 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 28322
#260401 18:42:54 server id 1  end_log_pos 28455 CRC32 0xb361e616 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
rvbMaRMBAAAAWgAAAKJuAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wALfVLv
rvbMaR4BAAAAhQAAACdvAAAAAG0AAAAAAAEAAgAI/wATAAAAAAAAABIAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gyq2FuZhsw==
'/*!*/;
# at 28455
#260401 18:42:54 server id 1  end_log_pos 28486 CRC32 0xa41fa79a 	Xid = 2795
COMMIT/*!*/;
# at 28486
# at 28565
#260401 18:42:56 server id 1  end_log_pos 28672 CRC32 0x25c8a0ec 	Query	thread_id=294	exec_time=0	error_code=0
SET TIMESTAMP=1775040176/*!*/;
BEGIN
/*!*/;
# at 28672
#260401 18:42:56 server id 1  end_log_pos 28757 CRC32 0x4025fbfc 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 28757
#260401 18:42:56 server id 1  end_log_pos 28919 CRC32 0x07e8fc65 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
sPbMaRMBAAAAVQAAAFVwAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A/PslQA==
sPbMaR8BAAAAogAAAPdwAAAAAGsAAAAAAAEAAgAI//8AEgAAAAAAAAAVT1JEMjAyNjA0MDExODQy
NTRCNkQ1AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyq2mbmDKrYAEgAAAAAAAAAVT1JEMjAyNjA0
MDExODQyNTRCNkQ1AQAAAAAAAAABAAAAAAAAAIAAABFaBZm5gyq2mbmDKrhl/OgH
'/*!*/;
# at 28919
#260401 18:42:56 server id 1  end_log_pos 28950 CRC32 0xc64ec211 	Xid = 2807
COMMIT/*!*/;
# at 28950
# at 29029
#260401 18:43:08 server id 1  end_log_pos 29127 CRC32 0xfe66dac8 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040188/*!*/;
BEGIN
/*!*/;
# at 29127
#260401 18:43:08 server id 1  end_log_pos 29212 CRC32 0xec2e053c 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 29212
#260401 18:43:08 server id 1  end_log_pos 29310 CRC32 0x7a1430d9 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
vPbMaRMBAAAAVQAAABxyAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8APAUu7A==
vPbMaR4BAAAAYgAAAH5yAAAAAGsAAAAAAAEAAgAI/wATAAAAAAAAABVPUkQyMDI2MDQwMTE4NDMw
ODVCNjYBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKsiZuYMqyNkwFHo=
'/*!*/;
# at 29310
#260401 18:43:08 server id 1  end_log_pos 29400 CRC32 0x1164493f 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 29400
#260401 18:43:08 server id 1  end_log_pos 29533 CRC32 0x79f39be3 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
vPbMaRMBAAAAWgAAANhyAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wA/SWQR
vPbMaR4BAAAAhQAAAF1zAAAAAG0AAAAAAAEAAgAI/wAUAAAAAAAAABMAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gyrI45vzeQ==
'/*!*/;
# at 29533
#260401 18:43:08 server id 1  end_log_pos 29564 CRC32 0xce8d8047 	Xid = 2822
COMMIT/*!*/;
# at 29564
# at 29643
#260401 18:43:08 server id 1  end_log_pos 29752 CRC32 0xeff10be3 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040188/*!*/;
BEGIN
/*!*/;
# at 29752
#260401 18:43:08 server id 1  end_log_pos 29856 CRC32 0x7803a134 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 29856
#260401 18:43:08 server id 1  end_log_pos 30616 CRC32 0xc8d2a9fb 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
vPbMaRMBAAAAaAAAAKB0AAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/ADShA3g=
vPbMaR8BAAAA+AIAAJh3AAAAAFcAAAAAAAEAAgAP/////0BAAgAAAAAAAAAcAOahguiKsee7v+ix
huezlSDmuIXpppnmgKHkurqQAOWcqOe7v+ixhuezleeahOWfuuehgOS4iua3u+WKoOWkqeeEtuah
guiKse+8jOa4hemmmeaAoeS6uu+8jOWPo+aEn+S4sOWvjOOAgumHh+eUqOS8oOe7n+mFjeaWue+8
jOaJi+W3peWItuS9nO+8jOavj+S4gOWPo+mDveaYr+WEv+aXtueahOWRs+mBk+OAgoAAABFagAAA
E1qFAGh0dHBzOi8vdHJhZS1hcGktY24ubWNob3N0Lmd1cnUvYXBpL2lkZS92MS90ZXh0X3RvX2lt
YWdlP3Byb21wdD1tYXRjaGElMjBtdW5nJTIwYmVhbiUyMGNha2UlMjBncmVlbiUyMHRlYSUyMGRl
c3NlcnQmaW1hZ2Vfc2l6ZT1zcXVhcmV8AwAALAEAAAbns5XngrmZuWbl95m5a0eoAQAAAABAQAIA
AAAAAAAAHADmoYLoirHnu7/osYbns5Ug5riF6aaZ5oCh5Lq6kADlnKjnu7/osYbns5XnmoTln7rn
oYDkuIrmt7vliqDlpKnnhLbmoYLoirHvvIzmuIXpppnmgKHkurrvvIzlj6PmhJ/kuLDlr4zjgILp
h4fnlKjkvKDnu5/phY3mlrnvvIzmiYvlt6XliLbkvZzvvIzmr4/kuIDlj6Ppg73mmK/lhL/ml7bn
moTlkbPpgZPjgIKAAAARWoAAABNahQBodHRwczovL3RyYWUtYXBpLWNuLm1jaG9zdC5ndXJ1L2Fw
aS9pZGUvdjEvdGV4dF90b19pbWFnZT9wcm9tcHQ9bWF0Y2hhJTIwbXVuZyUyMGJlYW4lMjBjYWtl
JTIwZ3JlZW4lMjB0ZWElMjBkZXNzZXJ0JmltYWdlX3NpemU9c3F1YXJlfQMAACwBAAAG57OV54K5
mblm5feZuYMqyAEAAAAA+6nSyA==
'/*!*/;
# at 30616
#260401 18:43:08 server id 1  end_log_pos 30701 CRC32 0xcdf2c831 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 30701
#260401 18:43:08 server id 1  end_log_pos 30863 CRC32 0x78bab244 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
vPbMaRMBAAAAVQAAAO13AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AMcjyzQ==
vPbMaR8BAAAAogAAAI94AAAAAGsAAAAAAAEAAgAI//8AEwAAAAAAAAAVT1JEMjAyNjA0MDExODQz
MDg1QjY2AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyrImbmDKsgAEwAAAAAAAAAVT1JEMjAyNjA0
MDExODQzMDg1QjY2AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gyrImbmDKshEsrp4
'/*!*/;
# at 30863
#260401 18:43:08 server id 1  end_log_pos 30894 CRC32 0x731dc41d 	Xid = 2831
COMMIT/*!*/;
# at 30894
# at 30973
#260401 18:43:16 server id 1  end_log_pos 31071 CRC32 0x7f6e060f 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040196/*!*/;
BEGIN
/*!*/;
# at 31071
#260401 18:43:16 server id 1  end_log_pos 31156 CRC32 0xcf70d3f6 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 31156
#260401 18:43:16 server id 1  end_log_pos 31254 CRC32 0x030f29d8 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
xPbMaRMBAAAAVQAAALR5AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A9tNwzw==
xPbMaR4BAAAAYgAAABZ6AAAAAGsAAAAAAAEAAgAI/wAUAAAAAAAAABVPUkQyMDI2MDQwMTE4NDMx
NjZFOEUBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKtCZuYMq0NgpDwM=
'/*!*/;
# at 31254
#260401 18:43:16 server id 1  end_log_pos 31344 CRC32 0x4019d926 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 31344
#260401 18:43:16 server id 1  end_log_pos 31477 CRC32 0x3bd223b5 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
xPbMaRMBAAAAWgAAAHB6AAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAm2RlA
xPbMaR4BAAAAhQAAAPV6AAAAAG0AAAAAAAEAAgAI/wAVAAAAAAAAABQAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gyrQtSPSOw==
'/*!*/;
# at 31477
#260401 18:43:16 server id 1  end_log_pos 31508 CRC32 0xd48a2ef9 	Xid = 2850
COMMIT/*!*/;
# at 31508
# at 31587
#260401 18:43:16 server id 1  end_log_pos 31696 CRC32 0x43b0e2fa 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040196/*!*/;
BEGIN
/*!*/;
# at 31696
#260401 18:43:16 server id 1  end_log_pos 31800 CRC32 0x1da84438 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 31800
#260401 18:43:16 server id 1  end_log_pos 32560 CRC32 0x9380a7c9 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
xPbMaRMBAAAAaAAAADh8AAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/ADhEqB0=
xPbMaR8BAAAA+AIAADB/AAAAAFcAAAAAAAEAAgAP/////0BAAgAAAAAAAAAcAOahguiKsee7v+ix
huezlSDmuIXpppnmgKHkurqQAOWcqOe7v+ixhuezleeahOWfuuehgOS4iua3u+WKoOWkqeeEtuah
guiKse+8jOa4hemmmeaAoeS6uu+8jOWPo+aEn+S4sOWvjOOAgumHh+eUqOS8oOe7n+mFjeaWue+8
jOaJi+W3peWItuS9nO+8jOavj+S4gOWPo+mDveaYr+WEv+aXtueahOWRs+mBk+OAgoAAABFagAAA
E1qFAGh0dHBzOi8vdHJhZS1hcGktY24ubWNob3N0Lmd1cnUvYXBpL2lkZS92MS90ZXh0X3RvX2lt
YWdlP3Byb21wdD1tYXRjaGElMjBtdW5nJTIwYmVhbiUyMGNha2UlMjBncmVlbiUyMHRlYSUyMGRl
c3NlcnQmaW1hZ2Vfc2l6ZT1zcXVhcmV9AwAALAEAAAbns5XngrmZuWbl95m5gyrIAQAAAABAQAIA
AAAAAAAAHADmoYLoirHnu7/osYbns5Ug5riF6aaZ5oCh5Lq6kADlnKjnu7/osYbns5XnmoTln7rn
oYDkuIrmt7vliqDlpKnnhLbmoYLoirHvvIzmuIXpppnmgKHkurrvvIzlj6PmhJ/kuLDlr4zjgILp
h4fnlKjkvKDnu5/phY3mlrnvvIzmiYvlt6XliLbkvZzvvIzmr4/kuIDlj6Ppg73mmK/lhL/ml7bn
moTlkbPpgZPjgIKAAAARWoAAABNahQBodHRwczovL3RyYWUtYXBpLWNuLm1jaG9zdC5ndXJ1L2Fw
aS9pZGUvdjEvdGV4dF90b19pbWFnZT9wcm9tcHQ9bWF0Y2hhJTIwbXVuZyUyMGJlYW4lMjBjYWtl
JTIwZ3JlZW4lMjB0ZWElMjBkZXNzZXJ0JmltYWdlX3NpemU9c3F1YXJlfgMAACwBAAAG57OV54K5
mblm5feZuYMq0AEAAAAAyaeAkw==
'/*!*/;
# at 32560
#260401 18:43:16 server id 1  end_log_pos 32645 CRC32 0xc7efbf68 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 32645
#260401 18:43:16 server id 1  end_log_pos 32807 CRC32 0xc026922b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
xPbMaRMBAAAAVQAAAIV/AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AaL/vxw==
xPbMaR8BAAAAogAAACeAAAAAAGsAAAAAAAEAAgAI//8AFAAAAAAAAAAVT1JEMjAyNjA0MDExODQz
MTY2RThFAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyrQmbmDKtAAFAAAAAAAAAAVT1JEMjAyNjA0
MDExODQzMTY2RThFAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gyrQmbmDKtArkibA
'/*!*/;
# at 32807
#260401 18:43:16 server id 1  end_log_pos 32838 CRC32 0xf0f7dcd2 	Xid = 2859
COMMIT/*!*/;
# at 32838
# at 32917
#260401 18:43:44 server id 1  end_log_pos 33015 CRC32 0x91d08535 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040224/*!*/;
BEGIN
/*!*/;
# at 33015
#260401 18:43:44 server id 1  end_log_pos 33100 CRC32 0x99011bdf 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 33100
#260401 18:43:44 server id 1  end_log_pos 33198 CRC32 0x6eb59c2b 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
4PbMaRMBAAAAVQAAAEyBAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A3xsBmQ==
4PbMaR4BAAAAYgAAAK6BAAAAAGsAAAAAAAEAAgAI/wAVAAAAAAAAABVPUkQyMDI2MDQwMTE4NDM0
NEREQTgBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKuyZuYMq7CuctW4=
'/*!*/;
# at 33198
#260401 18:43:44 server id 1  end_log_pos 33288 CRC32 0xd1e603c5 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 33288
#260401 18:43:44 server id 1  end_log_pos 33428 CRC32 0x7e7ab810 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
4PbMaRMBAAAAWgAAAAiCAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDFA+bR
4PbMaR4BAAAAjAAAAJSCAAAAAG0AAAAAAAEAAgAI/wAWAAAAAAAAABUAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMq7BC4en4=
'/*!*/;
# at 33428
#260401 18:43:44 server id 1  end_log_pos 33459 CRC32 0xf41dc8fd 	Xid = 2895
COMMIT/*!*/;
# at 33459
# at 33538
#260401 18:43:44 server id 1  end_log_pos 33647 CRC32 0xf877d860 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040224/*!*/;
BEGIN
/*!*/;
# at 33647
#260401 18:43:44 server id 1  end_log_pos 33751 CRC32 0xc580f938 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 33751
#260401 18:43:44 server id 1  end_log_pos 34327 CRC32 0xd1c24daa 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
4PbMaRMBAAAAaAAAANeDAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/ADj5gMU=
4PbMaR8BAAAAQAIAABeGAAAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn6AQAAPQBAAAG57OV
54K5mblm5feZuWtHqAEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGfpBAAA9AEAAAbns5XngrmZuWbl95m5gyrsAQAA
AACqTcLR
'/*!*/;
# at 34327
#260401 18:43:44 server id 1  end_log_pos 34412 CRC32 0x9c8e965e 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 34412
#260401 18:43:44 server id 1  end_log_pos 34574 CRC32 0x0c0eb6a6 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
4PbMaRMBAAAAVQAAAGyGAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AXpaOnA==
4PbMaR8BAAAAogAAAA6HAAAAAGsAAAAAAAEAAgAI//8AFQAAAAAAAAAVT1JEMjAyNjA0MDExODQz
NDREREE4AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyrsmbmDKuwAFQAAAAAAAAAVT1JEMjAyNjA0
MDExODQzNDREREE4AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gyrsmbmDKuymtg4M
'/*!*/;
# at 34574
#260401 18:43:44 server id 1  end_log_pos 34605 CRC32 0xb116c5d2 	Xid = 2904
COMMIT/*!*/;
# at 34605
# at 34684
#260401 18:44:01 server id 1  end_log_pos 34782 CRC32 0x3470dde2 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040241/*!*/;
BEGIN
/*!*/;
# at 34782
#260401 18:44:01 server id 1  end_log_pos 34867 CRC32 0x0a5af802 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 34867
#260401 18:44:01 server id 1  end_log_pos 34965 CRC32 0x2731ac1a 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
8fbMaRMBAAAAVQAAADOIAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AAvhaCg==
8fbMaR4BAAAAYgAAAJWIAAAAAGsAAAAAAAEAAgAI/wAWAAAAAAAAABVPUkQyMDI2MDQwMTE4NDQw
MTkwRjcBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDKwGZuYMrARqsMSc=
'/*!*/;
# at 34965
#260401 18:44:01 server id 1  end_log_pos 35055 CRC32 0x8f3f1899 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 35055
#260401 18:44:01 server id 1  end_log_pos 35195 CRC32 0x6637b5f8 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
8fbMaRMBAAAAWgAAAO+IAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCZGD+P
8fbMaR4BAAAAjAAAAHuJAAAAAG0AAAAAAAEAAgAI/wAXAAAAAAAAABYAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMrAfi1N2Y=
'/*!*/;
# at 35195
#260401 18:44:01 server id 1  end_log_pos 35226 CRC32 0x37e72567 	Xid = 2924
COMMIT/*!*/;
# at 35226
# at 35305
#260401 18:44:01 server id 1  end_log_pos 35414 CRC32 0xf0308dbb 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040241/*!*/;
BEGIN
/*!*/;
# at 35414
#260401 18:44:01 server id 1  end_log_pos 35518 CRC32 0x7cc87fb9 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 35518
#260401 18:44:01 server id 1  end_log_pos 36094 CRC32 0x99488cf8 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
8fbMaRMBAAAAaAAAAL6KAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/ALl/yHw=
8fbMaR8BAAAAQAIAAP6MAAAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn6QQAAPQBAAAG57OV
54K5mblm5feZuYMq7AEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGfqBAAA9AEAAAbns5XngrmZuWbl95m5gysBAQAA
AAD4jEiZ
'/*!*/;
# at 36094
#260401 18:44:01 server id 1  end_log_pos 36179 CRC32 0xed77c264 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 36179
#260401 18:44:01 server id 1  end_log_pos 36341 CRC32 0xef098ccb 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
8fbMaRMBAAAAVQAAAFONAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AZMJ37Q==
8fbMaR8BAAAAogAAAPWNAAAAAGsAAAAAAAEAAgAI//8AFgAAAAAAAAAVT1JEMjAyNjA0MDExODQ0
MDE5MEY3AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gysBmbmDKwEAFgAAAAAAAAAVT1JEMjAyNjA0
MDExODQ0MDE5MEY3AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gysBmbmDKwHLjAnv
'/*!*/;
# at 36341
#260401 18:44:01 server id 1  end_log_pos 36372 CRC32 0x6188b35d 	Xid = 2933
COMMIT/*!*/;
# at 36372
# at 36451
#260401 18:48:00 server id 1  end_log_pos 36549 CRC32 0x0d8bf183 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040480/*!*/;
BEGIN
/*!*/;
# at 36549
#260401 18:48:00 server id 1  end_log_pos 36634 CRC32 0xeea95320 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 36634
#260401 18:48:00 server id 1  end_log_pos 36732 CRC32 0x8ad9e046 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
4PfMaRMBAAAAVQAAABqPAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AIFOp7g==
4PfMaR4BAAAAYgAAAHyPAAAAAGsAAAAAAAEAAgAI/wAXAAAAAAAAABVPUkQyMDI2MDQwMTE4NDgw
MEIxNTEBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDLACZuYMsAEbg2Yo=
'/*!*/;
# at 36732
#260401 18:48:00 server id 1  end_log_pos 36822 CRC32 0x5ff8f531 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 36822
#260401 18:48:00 server id 1  end_log_pos 36962 CRC32 0xead9a439 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
4PfMaRMBAAAAWgAAANaPAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAx9fhf
4PfMaR4BAAAAjAAAAGKQAAAAAG0AAAAAAAEAAgAI/wAYAAAAAAAAABcAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMsADmk2eo=
'/*!*/;
# at 36962
#260401 18:48:00 server id 1  end_log_pos 36993 CRC32 0x52de9952 	Xid = 2960
COMMIT/*!*/;
# at 36993
# at 37072
#260401 18:48:00 server id 1  end_log_pos 37181 CRC32 0x4f63b299 	Query	thread_id=294	exec_time=0	error_code=0
SET TIMESTAMP=1775040480/*!*/;
BEGIN
/*!*/;
# at 37181
#260401 18:48:00 server id 1  end_log_pos 37285 CRC32 0x329a41c3 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 37285
#260401 18:48:00 server id 1  end_log_pos 37861 CRC32 0x7617a95e 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
4PfMaRMBAAAAaAAAAKWRAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AMNBmjI=
4PfMaR8BAAAAQAIAAOWTAAAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn6gQAAPQBAAAG57OV
54K5mblm5feZuYMrAQEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGfrBAAA9AEAAAbns5XngrmZuWbl95m5gywAAQAA
AABeqRd2
'/*!*/;
# at 37861
#260401 18:48:00 server id 1  end_log_pos 37946 CRC32 0xbbb81a89 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 37946
#260401 18:48:00 server id 1  end_log_pos 38108 CRC32 0x6c4c8c5b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
4PfMaRMBAAAAVQAAADqUAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AiRq4uw==
4PfMaR8BAAAAogAAANyUAAAAAGsAAAAAAAEAAgAI//8AFwAAAAAAAAAVT1JEMjAyNjA0MDExODQ4
MDBCMTUxAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gywAmbmDLAAAFwAAAAAAAAAVT1JEMjAyNjA0
MDExODQ4MDBCMTUxAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gywAmbmDLABbjExs
'/*!*/;
# at 38108
#260401 18:48:00 server id 1  end_log_pos 38139 CRC32 0x3bff86d2 	Xid = 2970
COMMIT/*!*/;
# at 38139
# at 38218
#260401 18:49:41 server id 1  end_log_pos 38316 CRC32 0x49bd7fa4 	Query	thread_id=294	exec_time=0	error_code=0
SET TIMESTAMP=1775040581/*!*/;
BEGIN
/*!*/;
# at 38316
#260401 18:49:41 server id 1  end_log_pos 38401 CRC32 0x3c42cf9f 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 38401
#260401 18:49:41 server id 1  end_log_pos 38499 CRC32 0x3ef21bf0 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
RfjMaRMBAAAAVQAAAAGWAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8An89CPA==
RfjMaR4BAAAAYgAAAGOWAAAAAGsAAAAAAAEAAgAI/wAYAAAAAAAAABVPUkQyMDI2MDQwMTE4NDk0
MTdDOEUBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDLGmZuYMsafAb8j4=
'/*!*/;
# at 38499
#260401 18:49:41 server id 1  end_log_pos 38589 CRC32 0x8387652a 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 38589
#260401 18:49:41 server id 1  end_log_pos 38729 CRC32 0xd2da1a2c 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
RfjMaRMBAAAAWgAAAL2WAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAqZYeD
RfjMaR4BAAAAjAAAAEmXAAAAAG0AAAAAAAEAAgAI/wAZAAAAAAAAABgAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMsaSwa2tI=
'/*!*/;
# at 38729
#260401 18:49:41 server id 1  end_log_pos 38760 CRC32 0x7240610f 	Xid = 2991
COMMIT/*!*/;
# at 38760
# at 38839
#260401 18:49:41 server id 1  end_log_pos 38948 CRC32 0x6910b45a 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040581/*!*/;
BEGIN
/*!*/;
# at 38948
#260401 18:49:41 server id 1  end_log_pos 39052 CRC32 0x0a775dc9 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 39052
#260401 18:49:41 server id 1  end_log_pos 39628 CRC32 0xc02d5ada 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
RfjMaRMBAAAAaAAAAIyYAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AMlddwo=
RfjMaR8BAAAAQAIAAMyaAAAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn6wQAAPQBAAAG57OV
54K5mblm5feZuYMsAAEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGfsBAAA9AEAAAbns5XngrmZuWbl95m5gyxpAQAA
AADaWi3A
'/*!*/;
# at 39628
#260401 18:49:41 server id 1  end_log_pos 39713 CRC32 0x4916bba9 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 39713
#260401 18:49:41 server id 1  end_log_pos 39875 CRC32 0x04156b5e 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
RfjMaRMBAAAAVQAAACGbAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AqbsWSQ==
RfjMaR8BAAAAogAAAMObAAAAAGsAAAAAAAEAAgAI//8AGAAAAAAAAAAVT1JEMjAyNjA0MDExODQ5
NDE3QzhFAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyxpmbmDLGkAGAAAAAAAAAAVT1JEMjAyNjA0
MDExODQ5NDE3QzhFAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gyxpmbmDLGleaxUE
'/*!*/;
# at 39875
#260401 18:49:41 server id 1  end_log_pos 39906 CRC32 0x036ad521 	Xid = 3001
COMMIT/*!*/;
# at 39906
# at 39985
#260401 18:51:04 server id 1  end_log_pos 40083 CRC32 0x1fab3b67 	Query	thread_id=295	exec_time=0	error_code=0
SET TIMESTAMP=1775040664/*!*/;
BEGIN
/*!*/;
# at 40083
#260401 18:51:04 server id 1  end_log_pos 40168 CRC32 0xe37ecb07 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 40168
#260401 18:51:04 server id 1  end_log_pos 40266 CRC32 0xbc9dae77 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
mPjMaRMBAAAAVQAAAOicAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AB8t+4w==
mPjMaR4BAAAAYgAAAEqdAAAAAGsAAAAAAAEAAgAI/wAZAAAAAAAAABVPUkQyMDI2MDQwMTE4NTEw
NEQ5NDcBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDLMSZuYMsxHeunbw=
'/*!*/;
# at 40266
#260401 18:51:04 server id 1  end_log_pos 40356 CRC32 0x908b68c8 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 40356
#260401 18:51:04 server id 1  end_log_pos 40496 CRC32 0xb9bb389c 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
mPjMaRMBAAAAWgAAAKSdAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDIaIuQ
mPjMaR4BAAAAjAAAADCeAAAAAG0AAAAAAAEAAgAI/wAaAAAAAAAAABkAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMsxJw4u7k=
'/*!*/;
# at 40496
#260401 18:51:04 server id 1  end_log_pos 40527 CRC32 0xc400969c 	Xid = 3046
COMMIT/*!*/;
# at 40527
# at 40606
#260401 18:51:04 server id 1  end_log_pos 40715 CRC32 0x92c4af7a 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040664/*!*/;
BEGIN
/*!*/;
# at 40715
#260401 18:51:04 server id 1  end_log_pos 40819 CRC32 0x2168e7cf 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 40819
#260401 18:51:04 server id 1  end_log_pos 41395 CRC32 0xed940072 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
mPjMaRMBAAAAaAAAAHOfAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AM/naCE=
mPjMaR8BAAAAQAIAALOhAAAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn7AQAAPQBAAAG57OV
54K5mblm5feZuYMsaQEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGftBAAA9AEAAAbns5XngrmZuWbl95m5gyzEAQAA
AAByAJTt
'/*!*/;
# at 41395
#260401 18:51:04 server id 1  end_log_pos 41480 CRC32 0xaf7da1b4 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 41480
#260401 18:51:04 server id 1  end_log_pos 41642 CRC32 0x996321da 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
mPjMaRMBAAAAVQAAAAiiAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AtKF9rw==
mPjMaR8BAAAAogAAAKqiAAAAAGsAAAAAAAEAAgAI//8AGQAAAAAAAAAVT1JEMjAyNjA0MDExODUx
MDREOTQ3AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gyzEmbmDLMQAGQAAAAAAAAAVT1JEMjAyNjA0
MDExODUxMDREOTQ3AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gyzEmbmDLMTaIWOZ
'/*!*/;
# at 41642
#260401 18:51:04 server id 1  end_log_pos 41673 CRC32 0x98a65eb0 	Xid = 3056
COMMIT/*!*/;
# at 41673
# at 41752
#260401 18:52:19 server id 1  end_log_pos 41850 CRC32 0xeeed11ef 	Query	thread_id=295	exec_time=0	error_code=0
SET TIMESTAMP=1775040739/*!*/;
BEGIN
/*!*/;
# at 41850
#260401 18:52:19 server id 1  end_log_pos 41935 CRC32 0x078d8dfc 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 41935
#260401 18:52:19 server id 1  end_log_pos 42033 CRC32 0x648ea742 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
4/jMaRMBAAAAVQAAAM+jAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A/I2NBw==
4/jMaR4BAAAAYgAAADGkAAAAAGsAAAAAAAEAAgAI/wAaAAAAAAAAABVPUkQyMDI2MDQwMTE4NTIx
OTFGMTMBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDLROZuYMtE0KnjmQ=
'/*!*/;
# at 42033
#260401 18:52:19 server id 1  end_log_pos 42123 CRC32 0x1dffe98a 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 42123
#260401 18:52:19 server id 1  end_log_pos 42263 CRC32 0xa8e9e884 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
4/jMaRMBAAAAWgAAAIukAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCK6f8d
4/jMaR4BAAAAjAAAABelAAAAAG0AAAAAAAEAAgAI/wAbAAAAAAAAABoAAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYMtE4To6ag=
'/*!*/;
# at 42263
#260401 18:52:19 server id 1  end_log_pos 42294 CRC32 0x238d0116 	Xid = 3091
COMMIT/*!*/;
# at 42294
# at 42373
#260401 18:52:21 server id 1  end_log_pos 42482 CRC32 0x9efcb01c 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040741/*!*/;
BEGIN
/*!*/;
# at 42482
#260401 18:52:21 server id 1  end_log_pos 42586 CRC32 0xdba7fea7 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 42586
#260401 18:52:21 server id 1  end_log_pos 43162 CRC32 0xe2a8b83c 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
5fjMaRMBAAAAaAAAAFqmAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AKf+p9s=
5fjMaR8BAAAAQAIAAJqoAAAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn7QQAAPQBAAAG57OV
54K5mblm5feZuYMsxAEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGfuBAAA9AEAAAbns5XngrmZuWbl95m5gy0VAQAA
AAA8uKji
'/*!*/;
# at 43162
#260401 18:52:21 server id 1  end_log_pos 43247 CRC32 0x5c4a21f3 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 43247
#260401 18:52:21 server id 1  end_log_pos 43409 CRC32 0x20efcebf 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
5fjMaRMBAAAAVQAAAO+oAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A8yFKXA==
5fjMaR8BAAAAogAAAJGpAAAAAGsAAAAAAAEAAgAI//8AGgAAAAAAAAAVT1JEMjAyNjA0MDExODUy
MTkxRjEzAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gy0TmbmDLRMAGgAAAAAAAAAVT1JEMjAyNjA0
MDExODUyMTkxRjEzAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gy0TmbmDLRW/zu8g
'/*!*/;
# at 43409
#260401 18:52:21 server id 1  end_log_pos 43440 CRC32 0x6b55534c 	Xid = 3101
COMMIT/*!*/;
# at 43440
# at 43519
#260401 18:56:31 server id 1  end_log_pos 43617 CRC32 0xa28cd839 	Query	thread_id=294	exec_time=0	error_code=0
SET TIMESTAMP=1775040991/*!*/;
BEGIN
/*!*/;
# at 43617
#260401 18:56:31 server id 1  end_log_pos 43702 CRC32 0x01042fb7 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 43702
#260401 18:56:31 server id 1  end_log_pos 43800 CRC32 0x19811a26 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
3/nMaRMBAAAAVQAAALaqAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8Aty8EAQ==
3/nMaR4BAAAAYgAAABirAAAAAGsAAAAAAAEAAgAI/wAbAAAAAAAAABVPUkQyMDI2MDQwMTE4NTYz
MTI4REUBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDLh+ZuYMuHyYagRk=
'/*!*/;
# at 43800
#260401 18:56:31 server id 1  end_log_pos 43890 CRC32 0x68dc9ae5 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 43890
#260401 18:56:31 server id 1  end_log_pos 44023 CRC32 0xde2eb9dd 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
3/nMaRMBAAAAWgAAAHKrAAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDlmtxo
3/nMaR4BAAAAhQAAAPerAAAAAG0AAAAAAAEAAgAI/wAcAAAAAAAAABsAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gy4f3bku3g==
'/*!*/;
# at 44023
#260401 18:56:31 server id 1  end_log_pos 44054 CRC32 0xa789eb1f 	Xid = 3129
COMMIT/*!*/;
# at 44054
# at 44133
#260401 18:56:31 server id 1  end_log_pos 44242 CRC32 0xfcf82814 	Query	thread_id=293	exec_time=0	error_code=0
SET TIMESTAMP=1775040991/*!*/;
BEGIN
/*!*/;
# at 44242
#260401 18:56:31 server id 1  end_log_pos 44346 CRC32 0x571c4507 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 44346
#260401 18:56:31 server id 1  end_log_pos 45106 CRC32 0x12e84ab2 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
3/nMaRMBAAAAaAAAADqtAAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AAdFHFc=
3/nMaR8BAAAA+AIAADKwAAAAAFcAAAAAAAEAAgAP/////0BAAgAAAAAAAAAcAOahguiKsee7v+ix
huezlSDmuIXpppnmgKHkurqQAOWcqOe7v+ixhuezleeahOWfuuehgOS4iua3u+WKoOWkqeeEtuah
guiKse+8jOa4hemmmeaAoeS6uu+8jOWPo+aEn+S4sOWvjOOAgumHh+eUqOS8oOe7n+mFjeaWue+8
jOaJi+W3peWItuS9nO+8jOavj+S4gOWPo+mDveaYr+WEv+aXtueahOWRs+mBk+OAgoAAABFagAAA
E1qFAGh0dHBzOi8vdHJhZS1hcGktY24ubWNob3N0Lmd1cnUvYXBpL2lkZS92MS90ZXh0X3RvX2lt
YWdlP3Byb21wdD1tYXRjaGElMjBtdW5nJTIwYmVhbiUyMGNha2UlMjBncmVlbiUyMHRlYSUyMGRl
c3NlcnQmaW1hZ2Vfc2l6ZT1zcXVhcmV+AwAALAEAAAbns5XngrmZuWbl95m5gyrQAQAAAABAQAIA
AAAAAAAAHADmoYLoirHnu7/osYbns5Ug5riF6aaZ5oCh5Lq6kADlnKjnu7/osYbns5XnmoTln7rn
oYDkuIrmt7vliqDlpKnnhLbmoYLoirHvvIzmuIXpppnmgKHkurrvvIzlj6PmhJ/kuLDlr4zjgILp
h4fnlKjkvKDnu5/phY3mlrnvvIzmiYvlt6XliLbkvZzvvIzmr4/kuIDlj6Ppg73mmK/lhL/ml7bn
moTlkbPpgZPjgIKAAAARWoAAABNahQBodHRwczovL3RyYWUtYXBpLWNuLm1jaG9zdC5ndXJ1L2Fw
aS9pZGUvdjEvdGV4dF90b19pbWFnZT9wcm9tcHQ9bWF0Y2hhJTIwbXVuZyUyMGJlYW4lMjBjYWtl
JTIwZ3JlZW4lMjB0ZWElMjBkZXNzZXJ0JmltYWdlX3NpemU9c3F1YXJlfwMAACwBAAAG57OV54K5
mblm5feZuYMuHwEAAAAAskroEg==
'/*!*/;
# at 45106
#260401 18:56:31 server id 1  end_log_pos 45191 CRC32 0x59058701 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 45191
#260401 18:56:31 server id 1  end_log_pos 45353 CRC32 0xcc24effc 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
3/nMaRMBAAAAVQAAAIewAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AAYcFWQ==
3/nMaR8BAAAAogAAACmxAAAAAGsAAAAAAAEAAgAI//8AGwAAAAAAAAAVT1JEMjAyNjA0MDExODU2
MzEyOERFAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gy4fmbmDLh8AGwAAAAAAAAAVT1JEMjAyNjA0
MDExODU2MzEyOERFAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gy4fmbmDLh/87yTM
'/*!*/;
# at 45353
#260401 18:56:31 server id 1  end_log_pos 45384 CRC32 0x85a23efe 	Xid = 3139
COMMIT/*!*/;
# at 45384
# at 45463
#260401 18:58:08 server id 1  end_log_pos 46277 CRC32 0x1a8ee908 	Query	thread_id=303	exec_time=0	error_code=0
SET TIMESTAMP=1775041088/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 46277
# at 46356
#260401 18:59:13 server id 1  end_log_pos 46454 CRC32 0xbc8c22e0 	Query	thread_id=303	exec_time=0	error_code=0
SET TIMESTAMP=1775041153/*!*/;
BEGIN
/*!*/;
# at 46454
#260401 18:59:13 server id 1  end_log_pos 46539 CRC32 0x2f049719 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 46539
#260401 18:59:13 server id 1  end_log_pos 46637 CRC32 0xe25827c4 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
gfrMaRMBAAAAVQAAAMu1AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AGZcELw==
gfrMaR4BAAAAYgAAAC22AAAAAGsAAAAAAAEAAgAI/wAcAAAAAAAAABVPUkQyMDI2MDQwMTE4NTkx
MzVDRDYBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDLs2ZuYMuzcQnWOI=
'/*!*/;
# at 46637
#260401 18:59:13 server id 1  end_log_pos 46727 CRC32 0x77ce259c 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 46727
#260401 18:59:13 server id 1  end_log_pos 46860 CRC32 0xcd8e3f6c 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
gfrMaRMBAAAAWgAAAIe2AAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wCcJc53
gfrMaR4BAAAAhQAAAAy3AAAAAG0AAAAAAAEAAgAI/wAdAAAAAAAAABwAAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gy7NbD+OzQ==
'/*!*/;
# at 46860
#260401 18:59:13 server id 1  end_log_pos 46891 CRC32 0xeada08db 	Xid = 3234
COMMIT/*!*/;
# at 46891
# at 46970
#260401 18:59:13 server id 1  end_log_pos 47079 CRC32 0x6b7c19f7 	Query	thread_id=303	exec_time=0	error_code=0
SET TIMESTAMP=1775041153/*!*/;
BEGIN
/*!*/;
# at 47079
#260401 18:59:13 server id 1  end_log_pos 47183 CRC32 0x0db6c882 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 47183
#260401 18:59:13 server id 1  end_log_pos 47943 CRC32 0x5aa1b712 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
gfrMaRMBAAAAaAAAAE+4AAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AILItg0=
gfrMaR8BAAAA+AIAAEe7AAAAAFcAAAAAAAEAAgAP/////0BAAgAAAAAAAAAcAOahguiKsee7v+ix
huezlSDmuIXpppnmgKHkurqQAOWcqOe7v+ixhuezleeahOWfuuehgOS4iua3u+WKoOWkqeeEtuah
guiKse+8jOa4hemmmeaAoeS6uu+8jOWPo+aEn+S4sOWvjOOAgumHh+eUqOS8oOe7n+mFjeaWue+8
jOaJi+W3peWItuS9nO+8jOavj+S4gOWPo+mDveaYr+WEv+aXtueahOWRs+mBk+OAgoAAABFagAAA
E1qFAGh0dHBzOi8vdHJhZS1hcGktY24ubWNob3N0Lmd1cnUvYXBpL2lkZS92MS90ZXh0X3RvX2lt
YWdlP3Byb21wdD1tYXRjaGElMjBtdW5nJTIwYmVhbiUyMGNha2UlMjBncmVlbiUyMHRlYSUyMGRl
c3NlcnQmaW1hZ2Vfc2l6ZT1zcXVhcmV/AwAALAEAAAbns5XngrmZuWbl95m5gy4fAQAAAABAQAIA
AAAAAAAAHADmoYLoirHnu7/osYbns5Ug5riF6aaZ5oCh5Lq6kADlnKjnu7/osYbns5XnmoTln7rn
oYDkuIrmt7vliqDlpKnnhLbmoYLoirHvvIzmuIXpppnmgKHkurrvvIzlj6PmhJ/kuLDlr4zjgILp
h4fnlKjkvKDnu5/phY3mlrnvvIzmiYvlt6XliLbkvZzvvIzmr4/kuIDlj6Ppg73mmK/lhL/ml7bn
moTlkbPpgZPjgIKAAAARWoAAABNahQBodHRwczovL3RyYWUtYXBpLWNuLm1jaG9zdC5ndXJ1L2Fw
aS9pZGUvdjEvdGV4dF90b19pbWFnZT9wcm9tcHQ9bWF0Y2hhJTIwbXVuZyUyMGJlYW4lMjBjYWtl
JTIwZ3JlZW4lMjB0ZWElMjBkZXNzZXJ0JmltYWdlX3NpemU9c3F1YXJlgAMAACwBAAAG57OV54K5
mblm5feZuYMuzQEAAAAAErehWg==
'/*!*/;
# at 47943
#260401 18:59:13 server id 1  end_log_pos 48028 CRC32 0x21b6dfd1 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 48028
#260401 18:59:13 server id 1  end_log_pos 48190 CRC32 0x0af1336d 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
gfrMaRMBAAAAVQAAAJy7AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A0d+2IQ==
gfrMaR8BAAAAogAAAD68AAAAAGsAAAAAAAEAAgAI//8AHAAAAAAAAAAVT1JEMjAyNjA0MDExODU5
MTM1Q0Q2AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gy7NmbmDLs0AHAAAAAAAAAAVT1JEMjAyNjA0
MDExODU5MTM1Q0Q2AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gy7NmbmDLs1tM/EK
'/*!*/;
# at 48190
#260401 18:59:13 server id 1  end_log_pos 48221 CRC32 0x00f154a0 	Xid = 3243
COMMIT/*!*/;
# at 48221
# at 48300
#260401 19:00:39 server id 1  end_log_pos 48398 CRC32 0x8d0efb53 	Query	thread_id=304	exec_time=0	error_code=0
SET TIMESTAMP=1775041239/*!*/;
BEGIN
/*!*/;
# at 48398
#260401 19:00:39 server id 1  end_log_pos 48483 CRC32 0xfaa2a1e1 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 48483
#260401 19:00:39 server id 1  end_log_pos 48581 CRC32 0xdd090047 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
1/rMaRMBAAAAVQAAAGO9AAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A4aGi+g==
1/rMaR4BAAAAYgAAAMW9AAAAAGsAAAAAAAEAAgAI/wAdAAAAAAAAABVPUkQyMDI2MDQwMTE5MDAz
OTRGMzYBAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDMCeZuYMwJ0cACd0=
'/*!*/;
# at 48581
#260401 19:00:39 server id 1  end_log_pos 48671 CRC32 0x7f35940e 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 48671
#260401 19:00:39 server id 1  end_log_pos 48804 CRC32 0xe2e33b6f 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
1/rMaRMBAAAAWgAAAB++AAAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAOlDV/
1/rMaR4BAAAAhQAAAKS+AAAAAG0AAAAAAAEAAgAI/wAeAAAAAAAAAB0AAAAAAAAAAgAAAAAAAAAc
AOahguiKsee7v+ixhuezlSDmuIXpppnmgKHkurobAC9pbWFnZXMvcHJvZHVjdC9kZWZhdWx0Lmpw
Z4AAABFaAQAAAJm5gzAnbzvj4g==
'/*!*/;
# at 48804
#260401 19:00:39 server id 1  end_log_pos 48835 CRC32 0x3a22052d 	Xid = 3262
COMMIT/*!*/;
# at 48835
# at 48914
#260401 19:00:39 server id 1  end_log_pos 49023 CRC32 0xbce6c6da 	Query	thread_id=303	exec_time=0	error_code=0
SET TIMESTAMP=1775041239/*!*/;
BEGIN
/*!*/;
# at 49023
#260401 19:00:39 server id 1  end_log_pos 49127 CRC32 0x3bde5712 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 49127
#260401 19:00:39 server id 1  end_log_pos 49887 CRC32 0xfff70e3a 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
1/rMaRMBAAAAaAAAAOe/AAAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/ABJX3js=
1/rMaR8BAAAA+AIAAN/CAAAAAFcAAAAAAAEAAgAP/////0BAAgAAAAAAAAAcAOahguiKsee7v+ix
huezlSDmuIXpppnmgKHkurqQAOWcqOe7v+ixhuezleeahOWfuuehgOS4iua3u+WKoOWkqeeEtuah
guiKse+8jOa4hemmmeaAoeS6uu+8jOWPo+aEn+S4sOWvjOOAgumHh+eUqOS8oOe7n+mFjeaWue+8
jOaJi+W3peWItuS9nO+8jOavj+S4gOWPo+mDveaYr+WEv+aXtueahOWRs+mBk+OAgoAAABFagAAA
E1qFAGh0dHBzOi8vdHJhZS1hcGktY24ubWNob3N0Lmd1cnUvYXBpL2lkZS92MS90ZXh0X3RvX2lt
YWdlP3Byb21wdD1tYXRjaGElMjBtdW5nJTIwYmVhbiUyMGNha2UlMjBncmVlbiUyMHRlYSUyMGRl
c3NlcnQmaW1hZ2Vfc2l6ZT1zcXVhcmWAAwAALAEAAAbns5XngrmZuWbl95m5gy7NAQAAAABAQAIA
AAAAAAAAHADmoYLoirHnu7/osYbns5Ug5riF6aaZ5oCh5Lq6kADlnKjnu7/osYbns5XnmoTln7rn
oYDkuIrmt7vliqDlpKnnhLbmoYLoirHvvIzmuIXpppnmgKHkurrvvIzlj6PmhJ/kuLDlr4zjgILp
h4fnlKjkvKDnu5/phY3mlrnvvIzmiYvlt6XliLbkvZzvvIzmr4/kuIDlj6Ppg73mmK/lhL/ml7bn
moTlkbPpgZPjgIKAAAARWoAAABNahQBodHRwczovL3RyYWUtYXBpLWNuLm1jaG9zdC5ndXJ1L2Fw
aS9pZGUvdjEvdGV4dF90b19pbWFnZT9wcm9tcHQ9bWF0Y2hhJTIwbXVuZyUyMGJlYW4lMjBjYWtl
JTIwZ3JlZW4lMjB0ZWElMjBkZXNzZXJ0JmltYWdlX3NpemU9c3F1YXJlgQMAACwBAAAG57OV54K5
mblm5feZuYMwJwEAAAAAOg73/w==
'/*!*/;
# at 49887
#260401 19:00:39 server id 1  end_log_pos 49972 CRC32 0x6d1affc8 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 49972
#260401 19:00:39 server id 1  end_log_pos 50134 CRC32 0x737b6cd6 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
1/rMaRMBAAAAVQAAADTDAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AyP8abQ==
1/rMaR8BAAAAogAAANbDAAAAAGsAAAAAAAEAAgAI//8AHQAAAAAAAAAVT1JEMjAyNjA0MDExOTAw
Mzk0RjM2AQAAAAAAAAABAAAAAAAAAIAAABFaAJm5gzAnmbmDMCcAHQAAAAAAAAAVT1JEMjAyNjA0
MDExOTAwMzk0RjM2AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gzAnmbmDMCfWbHtz
'/*!*/;
# at 50134
#260401 19:00:39 server id 1  end_log_pos 50165 CRC32 0xfed18ec2 	Xid = 3272
COMMIT/*!*/;
# at 50165
# at 50244
#260401 19:32:48 server id 1  end_log_pos 50988 CRC32 0xff512a8e 	Query	thread_id=327	exec_time=0	error_code=0	Xid = 3569
SET TIMESTAMP=1775043168/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS refund_order ( id BIGINT PRIMARY KEY AUTO_INCREMENT, order_id BIGINT NOT NULL, user_id BIGINT NOT NULL, refund_type INT NOT NULL COMMENT '1:���˿� 2:�˻��˿�', refund_status INT NOT NULL DEFAULT 0 COMMENT '0:������ 1:������ 2:��ͬ�� 3:�Ѿܾ�', refund_amount DECIMAL(10,2) NOT NULL, refund_reason VARCHAR(255), refund_desc TEXT, receipt_status VARCHAR(50), create_time DATETIME DEFAULT CURRENT_TIMESTAMP, update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, INDEX idx_order_id (order_id), INDEX idx_user_id (user_id) ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='�˿����'
/*!*/;
# at 50988
# at 51067
#260401 19:34:37 server id 1  end_log_pos 51881 CRC32 0x27026bea 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775043277/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 51881
# at 51960
#260401 19:48:27 server id 1  end_log_pos 52058 CRC32 0x176bf371 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775044107/*!*/;
BEGIN
/*!*/;
# at 52058
#260401 19:48:27 server id 1  end_log_pos 52156 CRC32 0xfbfd535a 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 52156
#260401 19:48:27 server id 1  end_log_pos 52334 CRC32 0xe3d9bee9 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
CwbNaRMBAAAAYgAAALzLAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/AFpT/fs=
CwbNaR4BAAAAsgAAAG7MAAAAAHAAAAAAAAEAAgAL//8AAAEAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAEAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgQANTY0Nirngrnlh7vpgInmi6nmlLbotKfnirbmgIEKICAgICAgICAgICAgICAgID6ZuYM8G5m5
gzwb6b7Z4w==
'/*!*/;
# at 52334
#260401 19:48:27 server id 1  end_log_pos 52365 CRC32 0xbf5afba7 	Xid = 3648
COMMIT/*!*/;
# at 52365
# at 52444
#260401 19:51:20 server id 1  end_log_pos 52542 CRC32 0x3a1eebd1 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775044280/*!*/;
BEGIN
/*!*/;
# at 52542
#260401 19:51:20 server id 1  end_log_pos 52640 CRC32 0xc04a83ea 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 52640
#260401 19:51:20 server id 1  end_log_pos 52818 CRC32 0x0e9671aa 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
uAbNaRMBAAAAYgAAAKDNAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/AOqDSsA=
uAbNaR4BAAAAsgAAAFLOAAAAAHAAAAAAAAEAAgAL//8AAAIAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAEAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgQAOTU0Nirngrnlh7vpgInmi6nmlLbotKfnirbmgIEKICAgICAgICAgICAgICAgID6ZuYM81Jm5
gzzUqnGWDg==
'/*!*/;
# at 52818
#260401 19:51:20 server id 1  end_log_pos 52849 CRC32 0x047f167e 	Xid = 3660
COMMIT/*!*/;
# at 52849
# at 52928
#260401 19:51:30 server id 1  end_log_pos 53026 CRC32 0xd992891a 	Query	thread_id=329	exec_time=0	error_code=0
SET TIMESTAMP=1775044290/*!*/;
BEGIN
/*!*/;
# at 53026
#260401 19:51:30 server id 1  end_log_pos 53124 CRC32 0xb88f4939 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 53124
#260401 19:51:30 server id 1  end_log_pos 53274 CRC32 0xe30e5197 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
wgbNaRMBAAAAYgAAAITPAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/ADlJj7g=
wgbNaR4BAAAAlgAAABrQAAAAAHAAAAAAAAEAAgAL//8AAAMAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgYANTU2NDY1DOW3suaUtuWIsOi0p5m5gzzembmDPN6XUQ7j
'/*!*/;
# at 53274
#260401 19:51:30 server id 1  end_log_pos 53305 CRC32 0xc884c9af 	Xid = 3668
COMMIT/*!*/;
# at 53305
# at 53384
#260401 19:51:39 server id 1  end_log_pos 53482 CRC32 0x30976278 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775044299/*!*/;
BEGIN
/*!*/;
# at 53482
#260401 19:51:39 server id 1  end_log_pos 53580 CRC32 0xb1f3fdd3 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 53580
#260401 19:51:39 server id 1  end_log_pos 53730 CRC32 0xc6821b6d 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
ywbNaRMBAAAAYgAAAEzRAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/ANP987E=
ywbNaR4BAAAAlgAAAOLRAAAAAHAAAAAAAAEAAgAL//8AAAQAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgYANTY0NTY0DOW3suaUtuWIsOi0p5m5gzznmbmDPOdtG4LG
'/*!*/;
# at 53730
#260401 19:51:39 server id 1  end_log_pos 53761 CRC32 0x4fbcf018 	Xid = 3676
COMMIT/*!*/;
# at 53761
# at 53840
#260401 19:51:58 server id 1  end_log_pos 53938 CRC32 0xeda78423 	Query	thread_id=329	exec_time=0	error_code=0
SET TIMESTAMP=1775044318/*!*/;
BEGIN
/*!*/;
# at 53938
#260401 19:51:58 server id 1  end_log_pos 54036 CRC32 0x909ddc15 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 54036
#260401 19:51:58 server id 1  end_log_pos 54185 CRC32 0xd2632e18 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
3gbNaRMBAAAAYgAAABTTAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/ABXcnZA=
3gbNaR4BAAAAlQAAAKnTAAAAAHAAAAAAAAEAAgAL//8AAAUAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgUAMTYzNTYM5bey5pS25Yiw6LSnmbmDPPqZuYM8+hguY9I=
'/*!*/;
# at 54185
#260401 19:51:58 server id 1  end_log_pos 54216 CRC32 0xf9275d57 	Xid = 3684
COMMIT/*!*/;
# at 54216
# at 54295
#260401 19:52:08 server id 1  end_log_pos 54393 CRC32 0xe2506803 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775044328/*!*/;
BEGIN
/*!*/;
# at 54393
#260401 19:52:08 server id 1  end_log_pos 54491 CRC32 0x13656430 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 54491
#260401 19:52:08 server id 1  end_log_pos 54642 CRC32 0xda6a934b 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
6AbNaRMBAAAAYgAAANvUAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/ADBkZRM=
6AbNaR4BAAAAlwAAAHLVAAAAAHAAAAAAAAEAAgAL//8AAAYAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgcAMTY1NDY1NAzlt7LmlLbliLDotKeZuYM9CJm5gz0IS5Nq2g==
'/*!*/;
# at 54642
#260401 19:52:08 server id 1  end_log_pos 54673 CRC32 0x5dbe0dda 	Xid = 3692
COMMIT/*!*/;
# at 54673
# at 54752
#260401 19:52:15 server id 1  end_log_pos 54850 CRC32 0x10c283e3 	Query	thread_id=329	exec_time=0	error_code=0
SET TIMESTAMP=1775044335/*!*/;
BEGIN
/*!*/;
# at 54850
#260401 19:52:15 server id 1  end_log_pos 54948 CRC32 0x000ae455 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 54948
#260401 19:52:15 server id 1  end_log_pos 55099 CRC32 0xb375cb91 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
7wbNaRMBAAAAYgAAAKTWAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/AFXkCgA=
7wbNaR4BAAAAlwAAADvXAAAAAHAAAAAAAAEAAgAL//8AAAcAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgcANTY0NjQ2NQzlt7LmlLbliLDotKeZuYM9D5m5gz0Pkct1sw==
'/*!*/;
# at 55099
#260401 19:52:15 server id 1  end_log_pos 55130 CRC32 0xcd9bf777 	Xid = 3700
COMMIT/*!*/;
# at 55130
# at 55209
#260401 19:52:41 server id 1  end_log_pos 55307 CRC32 0xc50c4761 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775044361/*!*/;
BEGIN
/*!*/;
# at 55307
#260401 19:52:41 server id 1  end_log_pos 55405 CRC32 0xca31a860 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 55405
#260401 19:52:41 server id 1  end_log_pos 55555 CRC32 0x7c56ed1a 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
CQfNaRMBAAAAYgAAAG3YAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/AGCoMco=
CQfNaR4BAAAAlgAAAAPZAAAAAHAAAAAAAAEAAgAL//8AAAgAAAAAAAAADQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgYANDU2NDY0DOW3suaUtuWIsOi0p5m5gz0pmbmDPSka7VZ8
'/*!*/;
# at 55555
#260401 19:52:41 server id 1  end_log_pos 55586 CRC32 0xe6961b85 	Xid = 3708
COMMIT/*!*/;
# at 55586
# at 55665
#260401 19:54:14 server id 1  end_log_pos 55763 CRC32 0xda0f202c 	Query	thread_id=328	exec_time=0	error_code=0
SET TIMESTAMP=1775044454/*!*/;
BEGIN
/*!*/;
# at 55763
#260401 19:54:14 server id 1  end_log_pos 55861 CRC32 0x12f12838 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 55861
#260401 19:54:14 server id 1  end_log_pos 56017 CRC32 0xdab43971 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
ZgfNaRMBAAAAYgAAADXaAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/ADgo8RI=
ZgfNaR4BAAAAnAAAANHaAAAAAHAAAAAAAAEAAgAL//8AAAkAAAAAAAAADQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgwA5aSH6LSn6K6h5YiSDOW3suaUtuWIsOi0p5m5gz2OmbmDPY5xObTa
'/*!*/;
# at 56017
#260401 19:54:14 server id 1  end_log_pos 56048 CRC32 0x7efcf2a8 	Xid = 3718
COMMIT/*!*/;
# at 56048
# at 56127
#260401 19:56:53 server id 1  end_log_pos 56941 CRC32 0x85428bba 	Query	thread_id=338	exec_time=0	error_code=0
SET TIMESTAMP=1775044613/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 56941
# at 57020
#260401 19:58:36 server id 1  end_log_pos 57118 CRC32 0x62adcbe4 	Query	thread_id=338	exec_time=0	error_code=0
SET TIMESTAMP=1775044716/*!*/;
BEGIN
/*!*/;
# at 57118
#260401 19:58:36 server id 1  end_log_pos 57216 CRC32 0xf11242d1 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 112
# at 57216
#260401 19:58:36 server id 1  end_log_pos 57367 CRC32 0xa0797e4e 	Write_rows: table id 112 flags: STMT_END_F

BINLOG '
bAjNaRMBAAAAYgAAAIDfAAAAAHAAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgALCAgIAwP2D/wPEhIJCgL8AwLIAAAAwAcBAQACA/z/ANFCEvE=
bAjNaR4BAAAAlwAAABfgAAAAAHAAAAAAAAEAAgAL//8AAAoAAAAAAAAAHQAAAAAAAAABAAAAAAAA
AAIAAAAAAAAAgAAAEVoqAOeCueWHu+mAieaLqeeUs+ivt+WOn+WboAogICAgICAgICAgICAgICAg
PgcAMTM1MzEzNgzlt7LmlLbliLDotKeZuYM+pJm5gz6kTn55oA==
'/*!*/;
# at 57367
#260401 19:58:36 server id 1  end_log_pos 57452 CRC32 0x179ba4e5 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 57452
#260401 19:58:36 server id 1  end_log_pos 57614 CRC32 0x17d516af 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
bAjNaRMBAAAAVQAAAGzgAAAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A5aSbFw==
bAjNaR8BAAAAogAAAA7hAAAAAGsAAAAAAAEAAgAI//8AHQAAAAAAAAAVT1JEMjAyNjA0MDExOTAw
Mzk0RjM2AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5gzAnmbmDMCcAHQAAAAAAAAAVT1JEMjAyNjA0
MDExOTAwMzk0RjM2AQAAAAAAAAABAAAAAAAAAIAAABFaY5m5gzAnmbmDPqSvFtUX
'/*!*/;
# at 57614
#260401 19:58:36 server id 1  end_log_pos 57645 CRC32 0x23a9924d 	Xid = 3784
COMMIT/*!*/;
# at 57645
# at 57724
#260401 20:02:58 server id 1  end_log_pos 58538 CRC32 0xaa15796a 	Query	thread_id=348	exec_time=0	error_code=0
SET TIMESTAMP=1775044978/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 58538
# at 58617
#260401 20:06:09 server id 1  end_log_pos 59701 CRC32 0x9710b98a 	Query	thread_id=358	exec_time=0	error_code=0	Xid = 3844
SET TIMESTAMP=1775045169/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
ALTER TABLE refund_order ADD COLUMN shop_id BIGINT COMMENT '�̻� ID' AFTER user_id, ADD COLUMN shop_audit_status INT DEFAULT 0 COMMENT '0:δ��� 1:ͨ�� 2:�ܾ�' AFTER receipt_status, ADD COLUMN shop_audit_desc VARCHAR(255) COMMENT '�̻�������' AFTER shop_audit_status, ADD COLUMN payment_proof VARCHAR(500) COMMENT '���ƾ֤' AFTER shop_audit_desc, ADD COLUMN payment_account VARCHAR(100) COMMENT '����˺�' AFTER payment_proof, ADD COLUMN shop_audit_time DATETIME COMMENT '�̻����ʱ��' AFTER payment_account, ADD COLUMN platform_audit_status INT DEFAULT 0 COMMENT '0:δ��� 1:ͨ�� 2:�ܾ�' AFTER shop_audit_time, ADD COLUMN platform_audit_desc VARCHAR(255) COMMENT 'ƽ̨������' AFTER platform_audit_status, ADD COLUMN platform_audit_time DATETIME COMMENT 'ƽ̨���ʱ��' AFTER platform_audit_desc, ADD COLUMN logistics_company VARCHAR(50) COMMENT '������˾' AFTER platform_audit_time, ADD COLUMN logistics_no VARCHAR(50) COMMENT '��������' AFTER logistics_company
/*!*/;
# at 59701
# at 59780
#260401 20:15:35 server id 1  end_log_pos 60594 CRC32 0x494180a6 	Query	thread_id=359	exec_time=0	error_code=0
SET TIMESTAMP=1775045735/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 60594
# at 60673
#260401 20:31:43 server id 1  end_log_pos 61487 CRC32 0x3bb38534 	Query	thread_id=369	exec_time=0	error_code=0
SET TIMESTAMP=1775046703/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 61487
# at 61566
#260401 20:39:43 server id 1  end_log_pos 62380 CRC32 0x33cab14f 	Query	thread_id=379	exec_time=0	error_code=0
SET TIMESTAMP=1775047183/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 62380
# at 62459
#260401 20:43:48 server id 1  end_log_pos 63273 CRC32 0xd8678a0b 	Query	thread_id=389	exec_time=0	error_code=0
SET TIMESTAMP=1775047428/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 63273
# at 63352
#260401 20:45:35 server id 1  end_log_pos 64166 CRC32 0xddb81a5e 	Query	thread_id=400	exec_time=0	error_code=0
SET TIMESTAMP=1775047535/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 64166
# at 64245
#260401 20:47:38 server id 1  end_log_pos 65059 CRC32 0x94cc5d8e 	Query	thread_id=411	exec_time=0	error_code=0
SET TIMESTAMP=1775047658/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 65059
# at 65138
#260401 20:51:04 server id 1  end_log_pos 65952 CRC32 0x28dec203 	Query	thread_id=421	exec_time=0	error_code=0
SET TIMESTAMP=1775047864/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 65952
# at 66031
#260401 20:52:53 server id 1  end_log_pos 66845 CRC32 0xf5304115 	Query	thread_id=431	exec_time=0	error_code=0
SET TIMESTAMP=1775047973/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 66845
# at 66924
#260401 20:54:43 server id 1  end_log_pos 67031 CRC32 0x477b5f83 	Query	thread_id=444	exec_time=0	error_code=0
SET TIMESTAMP=1775048083/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 67031
#260401 20:54:43 server id 1  end_log_pos 67138 CRC32 0xfe43b49a 	Table_map: `mung_bean_cake_mall`.`user` mapped to number 105
# at 67138
#260401 20:54:43 server id 1  end_log_pos 67335 CRC32 0x92924908 	Update_rows: table id 105 flags: STMT_END_F

BINLOG '
kxXNaRMBAAAAawAAAEIGAQAAAGkAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABHVzZXIADwgP
Dw8PDw8SEg8PDw8BARbIAPwDkAHIAPwDUAAAANAHkAGQAZAB9H8BAQACA/z/AJq0Q/4=
kxXNaR8BAAAAxQAAAAcHAQAAAGkAAAAAAAEAAgAP/////yAeAgAAAAAAAAAFdXNlcjEAAAYAMTIz
NDU2Aj8/CzEzODAwMTM4MDAxmblm5feZuYMaNwAAIB4CAAAAAAAAAAV1c2VyMTUALnpaclJxakp4
UTduM3hRN24zeFFPSnhRN24zeFE3bjN4UTduM3hRN24zeFE3bjN4UTduM3gGADEyMzQ1NgI/Pwsx
MzgwMDEzODAwMZm5ZuX3mbmDTasAAAhJkpI=
'/*!*/;
# at 67335
#260401 20:54:43 server id 1  end_log_pos 67366 CRC32 0xd1ccd59a 	Xid = 4398
COMMIT/*!*/;
# at 67366
# at 67445
#260401 21:12:09 server id 1  end_log_pos 68259 CRC32 0xe4f06447 	Query	thread_id=447	exec_time=0	error_code=0
SET TIMESTAMP=1775049129/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 68259
# at 68338
#260401 21:21:07 server id 1  end_log_pos 69152 CRC32 0xa50b7f10 	Query	thread_id=457	exec_time=0	error_code=0
SET TIMESTAMP=1775049667/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 69152
# at 69231
#260401 21:26:22 server id 1  end_log_pos 70045 CRC32 0x8db8c8f9 	Query	thread_id=467	exec_time=0	error_code=0
SET TIMESTAMP=1775049982/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 70045
# at 70124
#260401 21:31:38 server id 1  end_log_pos 70938 CRC32 0xf7e26b83 	Query	thread_id=477	exec_time=0	error_code=0
SET TIMESTAMP=1775050298/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 70938
# at 71017
#260401 21:42:58 server id 1  end_log_pos 71831 CRC32 0xd18f2657 	Query	thread_id=487	exec_time=0	error_code=0
SET TIMESTAMP=1775050978/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 71831
# at 71910
#260401 21:55:15 server id 1  end_log_pos 72724 CRC32 0x607c4cde 	Query	thread_id=497	exec_time=0	error_code=0
SET TIMESTAMP=1775051715/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 72724
# at 72803
#260401 22:58:35 server id 1  end_log_pos 72901 CRC32 0xf821f368 	Query	thread_id=519	exec_time=0	error_code=0
SET TIMESTAMP=1775055515/*!*/;
BEGIN
/*!*/;
# at 72901
#260401 22:58:35 server id 1  end_log_pos 72986 CRC32 0x3d7b2bf5 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 72986
#260401 22:58:35 server id 1  end_log_pos 73084 CRC32 0xadac3cd1 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
mzLNaRMBAAAAVQAAABodAQAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8A9St7PQ==
mzLNaR4BAAAAYgAAAHwdAQAAAGsAAAAAAAEAAgAI/wAeAAAAAAAAABVPUkQyMDI2MDQwMTIyNTgz
NTAyNTABAAAAAAAAAAEAAAAAAAAAgAAAEVoAmbmDbqOZuYNuo9E8rK0=
'/*!*/;
# at 73084
#260401 22:58:35 server id 1  end_log_pos 73174 CRC32 0x947efae9 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 73174
#260401 22:58:35 server id 1  end_log_pos 73314 CRC32 0x428501d0 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
mzLNaRMBAAAAWgAAANYdAQAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wDp+n6U
mzLNaR4BAAAAjAAAAGIeAQAAAG0AAAAAAAEAAgAI/wAfAAAAAAAAAB4AAAAAAAAAAQAAAAAAAAAj
AOe7v+ixhuezlSDnu4/lhbjljp/lkbMg5Lyg57uf57OV54K5GwAvaW1hZ2VzL3Byb2R1Y3QvZGVm
YXVsdC5qcGeAAAARWgEAAACZuYNuo9ABhUI=
'/*!*/;
# at 73314
#260401 22:58:35 server id 1  end_log_pos 73345 CRC32 0x61e6b0d0 	Xid = 5527
COMMIT/*!*/;
# at 73345
# at 73424
#260401 22:58:35 server id 1  end_log_pos 73533 CRC32 0xa3430665 	Query	thread_id=517	exec_time=0	error_code=0
SET TIMESTAMP=1775055515/*!*/;
BEGIN
/*!*/;
# at 73533
#260401 22:58:35 server id 1  end_log_pos 73637 CRC32 0x9b72879a 	Table_map: `mung_bean_cake_mall`.`product` mapped to number 87
# at 73637
#260401 22:58:35 server id 1  end_log_pos 74213 CRC32 0x703f0caa 	Update_rows: table id 87 flags: STMT_END_F

BINLOG '
mzLNaRMBAAAAaAAAAKUfAQAAAFcAAAAAAAMAE211bmdfYmVhbl9jYWtlX21hbGwAB3Byb2R1Y3QA
DwgP/Pb2D/wDAw8SEgEDDxCQAQIKAgoC/AMCyAAAAPwD9H8BAQACA/z/AJqHcps=
mzLNaR8BAAAAQAIAAOUhAQAAAFcAAAAAAAEAAgAP/////0BAAQAAAAAAAAAjAOe7v+ixhuezlSDn
u4/lhbjljp/lkbMg5Lyg57uf57OV54K5lgDnsr7pgInkvJjotKjnu7/osYbvvIzkvKDnu5/lt6Xo
ibrliLbkvZzvvIzlj6PmhJ/nu4bohbvvvIznlJzogIzkuI3ohbvjgILni6znq4vlsI/ljIXoo4Xv
vIzmlrnkvr/mkLrluKbvvIzmmK/kuIvljYjojLblkozkvJHpl7Lml7bliLvnmoTnkIbmg7PpgInm
i6njgIKAAAARWoAAABNaHAAvaW1hZ2VzL3Byb2R1Y3QvcHJvZHVjdDEuanBn7gQAAPQBAAAG57OV
54K5mblm5feZuYMtFQEAAAAAQEABAAAAAAAAACMA57u/6LGG57OVIOe7j+WFuOWOn+WRsyDkvKDn
u5/ns5XngrmWAOeyvumAieS8mOi0qOe7v+ixhu+8jOS8oOe7n+W3peiJuuWItuS9nO+8jOWPo+aE
n+e7huiFu++8jOeUnOiAjOS4jeiFu+OAgueLrOeri+Wwj+WMheijhe+8jOaWueS+v+aQuuW4pu+8
jOaYr+S4i+WNiOiMtuWSjOS8kemXsuaXtuWIu+eahOeQhuaDs+mAieaLqeOAgoAAABFagAAAE1oc
AC9pbWFnZXMvcHJvZHVjdC9wcm9kdWN0MS5qcGfvBAAA9AEAAAbns5XngrmZuWbl95m5g26jAQAA
AACqDD9w
'/*!*/;
# at 74213
#260401 22:58:35 server id 1  end_log_pos 74298 CRC32 0x99c92e24 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 74298
#260401 22:58:35 server id 1  end_log_pos 74460 CRC32 0x990eb12e 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
mzLNaRMBAAAAVQAAADoiAQAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AJC7JmQ==
mzLNaR8BAAAAogAAANwiAQAAAGsAAAAAAAEAAgAI//8AHgAAAAAAAAAVT1JEMjAyNjA0MDEyMjU4
MzUwMjUwAQAAAAAAAAABAAAAAAAAAIAAABFaAJm5g26jmbmDbqMAHgAAAAAAAAAVT1JEMjAyNjA0
MDEyMjU4MzUwMjUwAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5g26jmbmDbqMusQ6Z
'/*!*/;
# at 74460
#260401 22:58:35 server id 1  end_log_pos 74491 CRC32 0x87dfd720 	Xid = 5537
COMMIT/*!*/;
# at 74491
# at 74570
#260401 22:59:15 server id 1  end_log_pos 74668 CRC32 0x54195754 	Query	thread_id=517	exec_time=0	error_code=0
SET TIMESTAMP=1775055555/*!*/;
BEGIN
/*!*/;
# at 74668
#260401 22:59:15 server id 1  end_log_pos 74793 CRC32 0x3610c9cf 	Table_map: `mung_bean_cake_mall`.`refund_order` mapped to number 113
# at 74793
#260401 22:59:15 server id 1  end_log_pos 74980 CRC32 0x7749440e 	Write_rows: table id 113 flags: STMT_END_F

BINLOG '
wzLNaRMBAAAAfQAAACkkAQAAAHEAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwADHJlZnVuZF9v
cmRlcgAWCAgICAMD9g/8DwMPDw8SAw8SDw8SEhcKAvwDAsgA/APQB5ABAPwDAMgAyAAAAIj/PwEC
AAACA/z/AM/JEDY=
wzLNaR4BAAAAuwAAAOQkAQAAAHEAAAAAAAEAAgAW////CPgPCwAAAAAAAAAeAAAAAAAAAAEAAAAA
AAAAAQAAAAAAAACAAAARWioA54K55Ye76YCJ5oup55Sz6K+35Y6f5ZugCiAgICAgICAgICAgICAg
ICA+BwA0NTY0NjY4KueCueWHu+mAieaLqeaUtui0p+eKtuaAgQogICAgICAgICAgICAgICAgPgAA
AACZuYNuz5m5g27PDkRJdw==
'/*!*/;
# at 74980
#260401 22:59:15 server id 1  end_log_pos 75065 CRC32 0xe138afb2 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 75065
#260401 22:59:15 server id 1  end_log_pos 75227 CRC32 0x6afe071b 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
wzLNaRMBAAAAVQAAADklAQAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8Asq844Q==
wzLNaR8BAAAAogAAANslAQAAAGsAAAAAAAEAAgAI//8AHgAAAAAAAAAVT1JEMjAyNjA0MDEyMjU4
MzUwMjUwAQAAAAAAAAABAAAAAAAAAIAAABFaAZm5g26jmbmDbqMAHgAAAAAAAAAVT1JEMjAyNjA0
MDEyMjU4MzUwMjUwAQAAAAAAAAABAAAAAAAAAIAAABFaY5m5g26jmbmDbs8bB/5q
'/*!*/;
# at 75227
#260401 22:59:15 server id 1  end_log_pos 75258 CRC32 0xe9e7d771 	Xid = 5552
COMMIT/*!*/;
# at 75258
# at 75337
#260401 23:10:24 server id 1  end_log_pos 75435 CRC32 0xb2f26769 	Query	thread_id=534	exec_time=0	error_code=0
SET TIMESTAMP=1775056224/*!*/;
/*!\C gbk *//*!*/;
SET @@session.character_set_client=28,@@session.collation_connection=28,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 75435
#260401 23:10:24 server id 1  end_log_pos 75520 CRC32 0xfa700723 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 75520
#260401 23:10:24 server id 1  end_log_pos 75616 CRC32 0xd5e06337 	Write_rows: table id 107 flags: STMT_END_F

BINLOG '
YDXNaRMBAAAAVQAAAAAnAQAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8AIwdw+g==
YDXNaR4BAAAAYAAAAGAnAQAAAGsAAAAAAAEAAgAI/wAfAAAAAAAAABNPUkQyMDI2MDQwMTEyMzQ1
Njc4AQAAAAAAAAABAAAAAAAAAIAAABFaAZm5g3KYmbmDcpg3Y+DV
'/*!*/;
# at 75616
#260401 23:10:24 server id 1  end_log_pos 75647 CRC32 0x998714c9 	Xid = 5587
COMMIT/*!*/;
# at 75647
# at 75726
#260401 23:10:55 server id 1  end_log_pos 75824 CRC32 0x6e7ec563 	Query	thread_id=537	exec_time=0	error_code=0
SET TIMESTAMP=1775056255/*!*/;
BEGIN
/*!*/;
# at 75824
#260401 23:10:55 server id 1  end_log_pos 75914 CRC32 0x6ac0f91b 	Table_map: `mung_bean_cake_mall`.`order_item` mapped to number 109
# at 75914
#260401 23:10:55 server id 1  end_log_pos 76040 CRC32 0x1175ed53 	Write_rows: table id 109 flags: STMT_END_F

BINLOG '
fzXNaRMBAAAAWgAAAIooAQAAAG0AAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwACm9yZGVyX2l0
ZW0ACAgICA8P9gMSB5AB/AMKAgCQAQEAAgP8/wAb+cBq
fzXNaR4BAAAAfgAAAAgpAQAAAG0AAAAAAAEAAgAI/wAgAAAAAAAAAB8AAAAAAAAAAQAAAAAAAAAV
AOiHu+aso+aJi+W3pee7v+ixhuezlRsAL2ltYWdlcy9wcm9kdWN0L2RlZmF1bHQuanBngAAACF8C
AAAAmbmDcrdT7XUR
'/*!*/;
# at 76040
#260401 23:10:55 server id 1  end_log_pos 76071 CRC32 0xe030e427 	Xid = 5596
COMMIT/*!*/;
# at 76071
# at 76150
#260401 23:12:00 server id 1  end_log_pos 76257 CRC32 0xdb9a6a8c 	Query	thread_id=539	exec_time=0	error_code=0
SET TIMESTAMP=1775056320/*!*/;
BEGIN
/*!*/;
# at 76257
#260401 23:12:00 server id 1  end_log_pos 76342 CRC32 0xd94da73d 	Table_map: `mung_bean_cake_mall`.`orders` mapped to number 107
# at 76342
#260401 23:12:00 server id 1  end_log_pos 76500 CRC32 0xf64c15b1 	Update_rows: table id 107 flags: STMT_END_F

BINLOG '
wDXNaRMBAAAAVQAAADYqAQAAAGsAAAAAAAEAE211bmdfYmVhbl9jYWtlX21hbGwABm9yZGVycwAI
CA8ICPYBEhIGyAAKAgAA4AEBAAID/P8APadN2Q==
wDXNaR8BAAAAngAAANQqAQAAAGsAAAAAAAEAAgAI//8AHwAAAAAAAAATT1JEMjAyNjA0MDExMjM0
NTY3OAEAAAAAAAAAAQAAAAAAAACAAAARWgGZuYNymJm5g3KYAB8AAAAAAAAAE09SRDIwMjYwNDAx
MTIzNDU2NzgBAAAAAAAAAAEAAAAAAAAAgAAAEVoCmbmDcpiZuYNzALEVTPY=
'/*!*/;
# at 76500
#260401 23:12:00 server id 1  end_log_pos 76531 CRC32 0xb3cb75c4 	Xid = 5626
COMMIT/*!*/;
# at 76531
# at 76610
#260401 23:33:18 server id 1  end_log_pos 77424 CRC32 0x71305b77 	Query	thread_id=552	exec_time=0	error_code=0
SET TIMESTAMP=1775057598/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=0*//*!*/;
CREATE TABLE IF NOT EXISTS `verification_code` (`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键 ID',`phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',`email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',`code` VARCHAR(10) NOT NULL COMMENT '验证码',`type` VARCHAR(20) NOT NULL COMMENT '验证码类型（login-登录，register-注册，bind-绑定）',`expire_time` DATETIME NOT NULL COMMENT '过期时间',`used` TINYINT DEFAULT 0 COMMENT '是否已使用（0-未使用，1-已使用）',`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',PRIMARY KEY (`id`),INDEX `idx_phone` (`phone`),INDEX `idx_email` (`email`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码表'
/*!*/;
# at 77424
#260402 13:52:49 server id 1  end_log_pos 77447 CRC32 0xfda8c502 	Stop
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;

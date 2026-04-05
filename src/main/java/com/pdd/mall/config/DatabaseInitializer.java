package com.pdd.mall.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

/**
 * 鏁版嵁搴撳垵濮嬪寲閰嶇疆
 */
// @Slf4j disabled
@Component
public class DatabaseInitializer implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DatabaseInitializer.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) {
        try {
            // 鍒涘缓楠岃瘉鐮佽〃
            String createTableSql = 
                "CREATE TABLE IF NOT EXISTS `verification_code` (" +
                "`id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '涓婚敭 ID'," +
                "`phone` VARCHAR(20) DEFAULT NULL COMMENT '鎵嬫満鍙?," +
                "`email` VARCHAR(100) DEFAULT NULL COMMENT '閭'," +
                "`code` VARCHAR(10) NOT NULL COMMENT '楠岃瘉鐮?," +
                "`type` VARCHAR(20) NOT NULL COMMENT '楠岃瘉鐮佺被鍨嬶紙login-鐧诲綍锛宺egister-娉ㄥ唽锛宐ind-缁戝畾锛?," +
                "`expire_time` DATETIME NOT NULL COMMENT '杩囨湡鏃堕棿'," +
                "`used` TINYINT DEFAULT 0 COMMENT '鏄惁宸蹭娇鐢紙0-鏈娇鐢紝1-宸蹭娇鐢級'," +
                "`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿'," +
                "PRIMARY KEY (`id`)," +
                "INDEX `idx_phone` (`phone`)," +
                "INDEX `idx_email` (`email`)" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='楠岃瘉鐮佽〃'";
            
            jdbcTemplate.execute(createTableSql);
            log.info("楠岃瘉鐮佽〃鍒涘缓鎴愬姛");
            
            // 妫€鏌?user 琛ㄥ瓧娈?            checkAndAddColumn("user", "password_hash", "ALTER TABLE `user` ADD COLUMN `password_hash` VARCHAR(255) DEFAULT NULL COMMENT '瀵嗙爜鍝堝笇' AFTER `username`");
            checkAndAddColumn("user", "wechat_openid", "ALTER TABLE `user` ADD COLUMN `wechat_openid` VARCHAR(100) DEFAULT NULL COMMENT '寰俊 OpenID'");
            checkAndAddColumn("user", "qq_openid", "ALTER TABLE `user` ADD COLUMN `qq_openid` VARCHAR(100) DEFAULT NULL COMMENT 'QQ OpenID'");
            checkAndAddColumn("user", "email", "ALTER TABLE `user` ADD COLUMN `email` VARCHAR(100) DEFAULT NULL COMMENT '閭'");
            checkAndAddColumn("user", "email_verified", "ALTER TABLE `user` ADD COLUMN `email_verified` TINYINT DEFAULT 0 COMMENT '閭楠岃瘉'");
            checkAndAddColumn("user", "phone_verified", "ALTER TABLE `user` ADD COLUMN `phone_verified` TINYINT DEFAULT 0 COMMENT '鎵嬫満楠岃瘉'");
            
            log.info("鏁版嵁搴撳垵濮嬪寲瀹屾垚");
        } catch (Exception e) {
            log.error("鏁版嵁搴撳垵濮嬪寲澶辫触", e);
        }
    }

    /**
     * 检查并添加列
     */
    private void checkAndAddColumn(String tableName, String columnName, String alterSql) {
        try {
            String checkSql = String.format(
                "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '%s' AND TABLE_NAME = '%s' AND COLUMN_NAME = '%s'",
                "mung_bean_cake_mall", tableName, columnName
            );
            Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class);
            if (count != null && count == 0) {
                jdbcTemplate.execute(alterSql);
                log.info("添加列{}到表{}成功", columnName, tableName);
            } else {
                log.debug("列{}.{} 已存在", tableName, columnName);
            }
        } catch (Exception e) {
            log.warn("检查列失败：{}.{}", tableName, columnName, e);
        }
    }
}

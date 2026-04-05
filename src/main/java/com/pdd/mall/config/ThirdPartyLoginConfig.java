package com.pdd.mall.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 绗笁鏂圭櫥褰曢厤缃? * 
 * 鐢ㄤ簬閰嶇疆 QQ銆佸井淇°€侀偖绠辩瓑绗笁鏂圭櫥褰曠殑瀵嗛挜鍜屽弬鏁? * 
 * 猸?鐢熶骇鐜閰嶇疆鏂瑰紡锛? * 1. 鍦?application.yml 涓厤缃? * 2. 浣跨敤鐜鍙橀噺
 * 3. 浣跨敤閰嶇疆涓績锛堝 Nacos銆丄pollo锛? */
@Data
@Component
@ConfigurationProperties(prefix = "third-party.login")
public class ThirdPartyLoginConfig {

    /**
     * QQ 鐧诲綍閰嶇疆
     */
    private QQConfig qq = new QQConfig();

    /**
     * 寰俊鐧诲綍閰嶇疆
     */
    private WechatConfig wechat = new WechatConfig();

    /**
     * 閭鐧诲綍閰嶇疆
     */
    private EmailConfig email = new EmailConfig();

    /**
     * QQ 鐧诲綍閰嶇疆绫?     */
    @Data
    public static class QQConfig {
        /**
         * QQ 浜掕仈 AppID
         * 鑾峰彇鍦板潃锛歨ttps://connect.qq.com/
         */
        private String appId;

        /**
         * QQ 浜掕仈 AppKey
         * 猸?鏁忔劅淇℃伅锛岀敓浜х幆澧冭浣跨敤鐜鍙橀噺
         */
        private String appKey;

        /**
         * QQ 鐧诲綍鎺堟潈鍥炶皟鍩?         */
        private String redirectUri;

        /**
         * QQ API 鍩虹 URL
         */
        private final String baseUrl = "https://graph.qq.com";

        /**
         * 鑾峰彇鐢ㄦ埛淇℃伅 API
         */
        private final String userInfoUrl = "https://graph.qq.com/user/get_user_info";

        /**
         * 鑾峰彇 OpenID API
         */
        private final String openIdUrl = "https://graph.qq.com/oauth2.0/me";

        /**
         * 鑾峰彇 Access Token API
         */
        private final String accessTokenUrl = "https://graph.qq.com/oauth2.0/token";
    }

    /**
     * 寰俊鐧诲綍閰嶇疆绫?     */
    @Data
    public static class WechatConfig {
        /**
         * 寰俊寮€鏀惧钩鍙?AppID
         * 鑾峰彇鍦板潃锛歨ttps://open.weixin.qq.com/
         */
        private String appId;

        /**
         * 寰俊寮€鏀惧钩鍙?AppSecret
         * 猸?鏁忔劅淇℃伅锛岀敓浜х幆澧冭浣跨敤鐜鍙橀噺
         */
        private String appSecret;

        /**
         * 寰俊鎺堟潈鍥炶皟鍩?         */
        private String redirectUri;

        /**
         * 寰俊 API 鍩虹 URL
         */
        private final String baseUrl = "https://api.weixin.qq.com";

        /**
         * 鑾峰彇 Access Token API
         */
        private final String accessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token";

        /**
         * 鑾峰彇鐢ㄦ埛淇℃伅 API
         */
        private final String userInfoUrl = "https://api.weixin.qq.com/sns/userinfo";

        /**
         * 鍒锋柊 Access Token API
         */
        private final String refreshTokenUrl = "https://api.weixin.qq.com/sns/oauth2/refresh_token";
    }

    /**
     * 閭鐧诲綍閰嶇疆绫?     */
    @Data
    public static class EmailConfig {
        /**
         * SMTP 鏈嶅姟鍣ㄥ湴鍧€
         * 绀轰緥锛歴mtp.qq.com, smtp.163.com
         */
        private String smtpHost;

        /**
         * SMTP 鏈嶅姟鍣ㄧ鍙?         * 绀轰緥锛?65 (SSL), 587 (TLS)
         */
        private Integer smtpPort = 465;

        /**
         * 鍙戜欢浜洪偖绠?         */
        private String fromEmail;

        /**
         * 鍙戜欢浜哄瘑鐮侊紙鎺堟潈鐮侊級
         * 猸?鏁忔劅淇℃伅锛岀敓浜х幆澧冭浣跨敤鐜鍙橀噺
         * 娉ㄦ剰锛氫笉鏄偖绠辩櫥褰曞瘑鐮侊紝鏄?SMTP 鎺堟潈鐮?         */
        private String password;

        /**
         * 鏄惁鍚敤 SSL
         */
        private Boolean sslEnabled = true;

        /**
         * 楠岃瘉鐮佹湁鏁堟湡锛堝垎閽燂級
         */
        private Integer codeExpireMinutes = 5;

        /**
         * 閭欢鏍囬
         */
        private String emailSubject = "缁胯眴绯曞晢鍩庨獙璇佺爜";

        /**
         * 邮件签名
         */
        private String emailSignature = "【绿豆糕商城】";
    }
}

package com.pdd.mall.dto;

import lombok.Data;

/**
 * 鐧诲綍璇锋眰 DTO
 */
@Data
public class LoginRequest {

    /**
     * 鐧诲綍璐﹀彿锛堢敤鎴峰悕/鎵嬫満鍙?閭锛?     */
    private String account;

    /**
     * 瀵嗙爜
     */
    private String password;

    /**
     * 鎵嬫満鍙凤紙楠岃瘉鐮佺櫥褰曟椂浣跨敤锛?     */
    private String phone;

    /**
     * 楠岃瘉鐮侊紙楠岃瘉鐮佺櫥褰曟椂浣跨敤锛?     */
    private String code;

    /**
     * 鐧诲綍绫诲瀷锛歱assword-瀵嗙爜鐧诲綍锛宑ode-楠岃瘉鐮佺櫥褰?     */
    private String loginType;

    /**
     * 绗笁鏂圭櫥褰曠被鍨嬶細wechat-寰俊锛宷q-QQ
     */
    private String thirdPartyType;

    /**
     * 绗笁鏂规巿鏉冪爜锛圤Auth code锛?     */
    private String authCode;

    /**
     * 鏄惁鑷姩娉ㄥ唽锛堥獙璇佺爜鐧诲綍鏃惰嚜鍔ㄦ敞鍐岋級
     */
    private Boolean autoRegister = true;
}

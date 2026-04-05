package com.pdd.mall.dto;

import lombok.Data;

/**
 * 鍙戦€侀獙璇佺爜璇锋眰 DTO
 */
@Data
public class SendCodeRequest {

    /**
     * 鎵嬫満鍙?     */
    private String phone;

    /**
     * 閭
     */
    private String email;

    /**
     * 楠岃瘉鐮佺被鍨嬶細login-鐧诲綍锛宺egister-娉ㄥ唽锛宐ind-缁戝畾
     */
    private String type;
}

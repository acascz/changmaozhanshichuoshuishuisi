package com.pdd.mall.dto;

import lombok.Data;

/**
 * 鐧诲綍鍝嶅簲 DTO
 */
@Data
public class LoginResponse {

    /**
     * Access Token锛堢敤浜庢帴鍙ｉ壌鏉冿級
     */
    private String token;

    /**
     * Refresh Token锛堢敤浜庡埛鏂?Access Token锛?     */
    private String refreshToken;

    /**
     * Token 绫诲瀷
     */
    private String tokenType;

    /**
     * Access Token 杩囨湡鏃堕棿锛堟绉掞級
     */
    private Long expiresIn;

    /**
     * Refresh Token 杩囨湡鏃堕棿锛堟绉掞級
     */
    private Long refreshExpiresIn;

    /**
     * 鐢ㄦ埛 ID
     */
    private Long userId;

    /**
     * 鐢ㄦ埛鍚?     */
    private String username;

    /**
     * 鏄电О
     */
    private String nickname;

    /**
     * 澶村儚
     */
    private String avatar;

    /**
     * 鎵嬫満鍙?     */
    private String phone;

    /**
     * 閭
     */
    private String email;

    /**
     * 鏄惁棣栨鐧诲綍锛堥渶瑕佸畬鍠勪俊鎭級
     */
    private Boolean isFirstLogin;

    /**
     * 鏄惁闇€瑕佺粦瀹氭墜鏈哄彿
     */
    private Boolean needBindPhone;

    /**
     * 娑堟伅鎻愮ず
     */
    private String message;

    /**
     * 鏋勫缓鍣?     */
    public static Builder builder() {
        return new Builder();
    }

    /**
     * Setter 鏂规硶
     */
    public void setToken(String token) {
        this.token = token;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public void setExpiresIn(Long expiresIn) {
        this.expiresIn = expiresIn;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setIsFirstLogin(Boolean isFirstLogin) {
        this.isFirstLogin = isFirstLogin;
    }

    public void setNeedBindPhone(Boolean needBindPhone) {
        this.needBindPhone = needBindPhone;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static class Builder {
        private String token;
        private String refreshToken;
        private String tokenType;
        private Long expiresIn;
        private Long refreshExpiresIn;
        private Long userId;
        private String username;
        private String nickname;
        private String avatar;
        private String phone;
        private String email;
        private Boolean isFirstLogin;
        private Boolean needBindPhone;
        private String message;

        public Builder token(String token) {
            this.token = token;
            return this;
        }

        public Builder refreshToken(String refreshToken) {
            this.refreshToken = refreshToken;
            return this;
        }

        public Builder tokenType(String tokenType) {
            this.tokenType = tokenType;
            return this;
        }

        public Builder expiresIn(Long expiresIn) {
            this.expiresIn = expiresIn;
            return this;
        }

        public Builder refreshExpiresIn(Long refreshExpiresIn) {
            this.refreshExpiresIn = refreshExpiresIn;
            return this;
        }

        public Builder userId(Long userId) {
            this.userId = userId;
            return this;
        }

        public Builder username(String username) {
            this.username = username;
            return this;
        }

        public Builder nickname(String nickname) {
            this.nickname = nickname;
            return this;
        }

        public Builder avatar(String avatar) {
            this.avatar = avatar;
            return this;
        }

        public Builder phone(String phone) {
            this.phone = phone;
            return this;
        }

        public Builder email(String email) {
            this.email = email;
            return this;
        }

        public Builder isFirstLogin(Boolean isFirstLogin) {
            this.isFirstLogin = isFirstLogin;
            return this;
        }

        public Builder needBindPhone(Boolean needBindPhone) {
            this.needBindPhone = needBindPhone;
            return this;
        }

        public Builder message(String message) {
            this.message = message;
            return this;
        }

        public LoginResponse build() {
            LoginResponse response = new LoginResponse();
            response.setToken(this.token);
            response.setRefreshToken(this.refreshToken);
            response.setTokenType(this.tokenType);
            response.setExpiresIn(this.expiresIn);
            response.setRefreshExpiresIn(this.refreshExpiresIn);
            response.setUserId(this.userId);
            response.setUsername(this.username);
            response.setNickname(this.nickname);
            response.setAvatar(this.avatar);
            response.setPhone(this.phone);
            response.setEmail(this.email);
            response.setIsFirstLogin(this.isFirstLogin);
            response.setNeedBindPhone(this.needBindPhone);
            response.setMessage(this.message);
            return response;
        }
    }
}

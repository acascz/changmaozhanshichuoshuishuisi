package com.pdd.mall.util;

import io.jsonwebtoken.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * JWT Token 宸ュ叿绫? */
@Component
public class JwtUtil {

    @Value("${jwt.secret:zhongdou_mall_secret_key_2024}")
    private String secret;

    @Value("${jwt.expiration:86400000}")
    private Long expiration;

    @Value("${jwt.refresh-expiration:604800000}")
    private Long refreshExpiration;

    /**
     * 鐢熸垚 Access Token锛?0 鍒嗛挓锛?     */
    public String generateAccessToken(Long userId, String username) {
        Date now = new Date();
        Date expireDate = new Date(now.getTime() + expiration);

        return Jwts.builder()
                .setSubject(String.valueOf(userId))
                .claim("username", username)
                .claim("type", "access")
                .setIssuedAt(now)
                .setExpiration(expireDate)
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }

    /**
     * 鐢熸垚 Refresh Token锛? 澶╋級
     */
    public String generateRefreshToken(Long userId, String username) {
        Date now = new Date();
        Date expireDate = new Date(now.getTime() + refreshExpiration);

        return Jwts.builder()
                .setSubject(String.valueOf(userId))
                .claim("username", username)
                .claim("type", "refresh")
                .setIssuedAt(now)
                .setExpiration(expireDate)
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }

    /**
     * 鐢熸垚鍙?Token
     */
    public Map<String, String> generateTokens(Long userId, String username) {
        Map<String, String> tokens = new HashMap<>();
        tokens.put("accessToken", generateAccessToken(userId, username));
        tokens.put("refreshToken", generateRefreshToken(userId, username));
        return tokens;
    }

    /**
     * 瑙ｆ瀽 Token
     */
    public Claims parseToken(String token) {
        try {
            return Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 鑾峰彇鐢ㄦ埛 ID
     */
    public Long getUserIdFromToken(String token) {
        Claims claims = parseToken(token);
        if (claims == null) {
            return null;
        }
        return Long.parseLong(claims.getSubject());
    }

    /**
     * 鑾峰彇鐢ㄦ埛鍚?     */
    public String getUsernameFromToken(String token) {
        Claims claims = parseToken(token);
        if (claims == null) {
            return null;
        }
        return claims.get("username", String.class);
    }

    /**
     * 楠岃瘉 Token 鏄惁鏈夋晥
     */
    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secret).parseClaimsJws(token);
            return true;
        } catch (SignatureException e) {
            // 绛惧悕鏃犳晥
        } catch (MalformedJwtException e) {
            // Token 鏍煎紡涓嶆纭?        } catch (ExpiredJwtException e) {
            // Token 宸茶繃鏈?        } catch (UnsupportedJwtException e) {
            // 涓嶆敮鎸佺殑 Token
        } catch (IllegalArgumentException e) {
            // 鍙傛暟涓虹┖
        }
        return false;
    }

    /**
     * 楠岃瘉鏄惁涓?Refresh Token
     */
    public boolean isRefreshToken(String token) {
        Claims claims = parseToken(token);
        if (claims == null) {
            return false;
        }
        return "refresh".equals(claims.get("type"));
    }

    /**
     * 楠岃瘉鏄惁涓?Access Token
     */
    public boolean isAccessToken(String token) {
        Claims claims = parseToken(token);
        if (claims == null) {
            return false;
        }
        return "access".equals(claims.get("type"));
    }

    /**
     * 鍒锋柊 Token锛堢敤 Refresh Token 鎹㈠彇鏂扮殑 Access Token锛?     */
    public Map<String, String> refreshTokens(String refreshToken) {
        Claims claims = parseToken(refreshToken);
        
        if (claims == null) {
            throw new RuntimeException("Refresh Token 鏃犳晥");
        }
        
        if (!isRefreshToken(refreshToken)) {
            throw new RuntimeException("涓嶆槸 Refresh Token");
        }
        
        Long userId = Long.parseLong(claims.getSubject());
        String username = claims.get("username", String.class);
        
        // 鐢熸垚鏂扮殑鍙?Token
        return generateTokens(userId, username);
    }
}

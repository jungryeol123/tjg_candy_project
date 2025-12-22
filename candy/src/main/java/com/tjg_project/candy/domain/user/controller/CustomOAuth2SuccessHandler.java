package com.tjg_project.candy.domain.user.controller;

import com.tjg_project.candy.domain.auth.entity.RefreshToken;
import com.tjg_project.candy.domain.auth.service.AuthService;
import com.tjg_project.candy.domain.user.service.CustomOAuth2Service;
import com.tjg_project.candy.global.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {

    private final JwtUtil jwtUtil;
    private final CustomOAuth2Service oAuth2Service;
    private final AuthService authService; // ✅ 추가
    @Value("${app.frontend-url}")
    private String frontendUrl;

    public CustomOAuth2SuccessHandler(JwtUtil jwtUtil,
                                      CustomOAuth2Service oAuth2Service,
                                      AuthService authService) {
        this.jwtUtil = jwtUtil;
        this.oAuth2Service = oAuth2Service;
        this.authService = authService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
        String provider = oauthToken.getAuthorizedClientRegistrationId(); // kakao / naver

        // ✅ 사용자 저장 또는 업데이트
        Long userId = oAuth2Service.saveOrUpdate(oAuth2User.getAttributes(), provider);

        // ✅ AccessToken만 발급
        String accessToken = jwtUtil.generateAccessToken(userId);

        // ✅ 프론트로 리다이렉트 (토큰만 전달)
        String redirectUrl = String.format(
                "%s/oauth/success?accessToken=%s&provider=%s&userId=%d&success=%d",
                frontendUrl, accessToken, provider, userId, 200
        );

        response.sendRedirect(redirectUrl);
    }
}

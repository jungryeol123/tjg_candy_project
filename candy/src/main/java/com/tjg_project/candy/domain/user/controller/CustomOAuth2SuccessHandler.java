////package com.tjg_project.candy.domain.user.controller;
////import com.tjg_project.candy.domain.user.entity.Users;
////import com.tjg_project.candy.domain.user.service.CustomOAuth2Service;
////import com.tjg_project.candy.global.util.JwtUtil;
////import jakarta.servlet.http.HttpServletRequest;
////import jakarta.servlet.http.HttpServletResponse;
////import org.springframework.security.core.Authentication;
////import org.springframework.security.oauth2.core.user.OAuth2User;
////import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
////import org.springframework.stereotype.Component;
////
////import java.io.IOException;
////import java.util.Map;
////@Component
////public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {
////    private final JwtUtil jwtUtil;
////    private final CustomOAuth2Service oAuth2Service;
////
////    public CustomOAuth2SuccessHandler(JwtUtil jwtUtil, CustomOAuth2Service oAuth2Service) {
////        this.jwtUtil = jwtUtil;
////        this.oAuth2Service = oAuth2Service;
////    }
////
////    @Override
////    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
////                                        Authentication authentication) throws IOException {
////        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
////        Map<String, Object> responseMap = (Map<String, Object>) oAuth2User.getAttributes().get("response");
////
////        // ✅ Service 계층에 위임
////        Users user = oAuth2Service.saveOrUpdate(responseMap);
////        System.out.println("responseMap" + responseMap);
//////        // ✅ JWT 발급 및 리다이렉트
//////        String token = jwtUtil.generateToken(user.getId());
////        response.sendRedirect("http://localhost:3000/success?success=200");
////    }
////}
////
//
//
//
//package com.tjg_project.candy.domain.user.controller;
//
//import com.tjg_project.candy.domain.user.entity.Users;
//import com.tjg_project.candy.domain.user.service.CustomOAuth2Service;
//import com.tjg_project.candy.global.util.JwtUtil;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
//import org.springframework.security.oauth2.core.user.OAuth2User;
//import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//import java.util.Map;
//
//@Component
//public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {
//    private final JwtUtil jwtUtil;
//    private final CustomOAuth2Service oAuth2Service;
//
//    public CustomOAuth2SuccessHandler(JwtUtil jwtUtil, CustomOAuth2Service oAuth2Service) {
//        this.jwtUtil = jwtUtil;
//        this.oAuth2Service = oAuth2Service;
//    }
//
//    @Override
//    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
//                                        Authentication authentication) throws IOException {
//
//        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
//        OAuth2AuthenticationToken token = (OAuth2AuthenticationToken) authentication;
//        String provider = token.getAuthorizedClientRegistrationId(); // "naver" or "kakao"
//
//        // ✅ 서비스 계층으로 위임 (provider에 따라 파싱 다르게)
//        Long userId = oAuth2Service.saveOrUpdate(oAuth2User.getAttributes(), provider);
//
//        // ✅ JWT 발급
////        String jwt = jwtUtil.generateToken(user.getEmail());
//
////        // ✅ JSON 응답 (리다이렉트 대신)
////        response.setStatus(HttpServletResponse.SC_OK);
////        response.setContentType("application/json; charset=UTF-8");
////        response.getWriter().write("{\"success\":200, \"provider\":\"" + provider);
//
//        response.sendRedirect("http://localhost:3000/oauth/success?success=200&provider="
//                + provider + "&userId=" + userId);
//    }
//}







package com.tjg_project.candy.domain.user.controller;

import com.tjg_project.candy.domain.auth.entity.RefreshToken;
import com.tjg_project.candy.domain.auth.service.AuthService;
import com.tjg_project.candy.domain.user.service.CustomOAuth2Service;
import com.tjg_project.candy.global.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

        // ✅ AccessToken (10분)
        String accessToken = jwtUtil.generateAccessToken(userId);

        // ✅ RefreshToken (DB에 저장)
        RefreshToken refresh = authService.createRefreshToken(userId);

        // ✅ RefreshToken을 HttpOnly 쿠키로 내려줌
        ResponseCookie cookie = ResponseCookie.from("refresh_token", refresh.getToken())
                .httpOnly(true)
                .secure(false) // ⚠️ HTTPS 환경에서는 true로 변경
                .sameSite("Strict")
                .path("/auth/refresh")
                .maxAge(7 * 24 * 60 * 60)
                .build();

        response.setHeader(HttpHeaders.SET_COOKIE, cookie.toString());

        // ✅ React로 리다이렉트 (AccessToken, provider, userId 전달)
        String redirectUrl = String.format(
                "http://localhost:3000/oauth/success?accessToken=%s&provider=%s&userId=%d&success=%d",
                accessToken, provider, userId, 200
        );

        response.sendRedirect(redirectUrl);
    }
}

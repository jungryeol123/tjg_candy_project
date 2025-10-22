//package com.tjg_project.candy.domain.user.controller;
//
//
//import com.tjg_project.candy.domain.user.entity.Users;
//import com.tjg_project.candy.domain.user.repository.UserRepository;
//import com.tjg_project.candy.global.util.JwtUtil;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.oauth2.core.user.OAuth2User;
//import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//import java.util.Map;
//
//@Component
//public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {
//
//
//    private final JwtUtil jwtUtil;
//    private final UserRepository userRepository;
//
//    public CustomOAuth2SuccessHandler(JwtUtil jwtUtil, UserRepository userRepository) {
//        this.jwtUtil = jwtUtil;
//        this.userRepository = userRepository;
//    }
//
//    @Override
//    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
//                                        Authentication authentication) throws IOException, ServletException {
//        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
//        Map<String, Object> responseMap = (Map<String, Object>) oAuth2User.getAttributes().get("response");
//
//        String email = (String) responseMap.get("email");
//        String name = (String) responseMap.get("name");
//
//        // DB 저장 or 업데이트
//        Users user = userRepository.findByemail(email)
//                .map(u -> {
//                    u.setName(name);
//                    return userRepository.save(u);
//                })
//                .orElseGet(() -> {
//                    Users newUser = new Users();
//                    newUser.setEmail(email);
//                    newUser.setName(name);
//                    newUser.setProvider("naver");
//                    return userRepository.save(newUser);
//                });
//
//        // ✅ 휴대폰 번호 여부 확인
//        boolean hasPhone = (user.getPhone() != null && !user.getPhone().isEmpty());
//        // JWT 발급
//        String token = jwtUtil.generateToken(user.getEmail());
//
//        // 프론트엔드로 리다이렉트 + JWT 전달 (쿼리 파라미터)
//
////        response.sendRedirect("http://localhost:3000/oauth2/success?token=" + token + "&hasPhone=" + hasPhone);
//        response.sendRedirect("http://127.0.0.1:3000/oauth2/success?token=" + token + "&hasPhone=" + hasPhone);
//    }
//}





package com.tjg_project.candy.domain.user.controller;
import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.service.CustomOAuth2Service;
import com.tjg_project.candy.global.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;











@Component
public class CustomOAuth2SuccessHandler implements AuthenticationSuccessHandler {
    private final JwtUtil jwtUtil;
    private final CustomOAuth2Service oAuth2Service;

    public CustomOAuth2SuccessHandler(JwtUtil jwtUtil, CustomOAuth2Service oAuth2Service) {
        this.jwtUtil = jwtUtil;
        this.oAuth2Service = oAuth2Service;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        Map<String, Object> responseMap = (Map<String, Object>) oAuth2User.getAttributes().get("response");

        // ✅ Service 계층에 위임
        Users user = oAuth2Service.saveOrUpdate(responseMap);

        // ✅ JWT 발급 및 리다이렉트
        String token = jwtUtil.generateToken(user.getEmail());
        response.sendRedirect("http://127.0.0.1:3000/oauth2/success?token=" + token);
    }
}


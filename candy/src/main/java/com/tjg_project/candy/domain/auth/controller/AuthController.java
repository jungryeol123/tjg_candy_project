package com.tjg_project.candy.domain.auth.controller;

import com.tjg_project.candy.domain.auth.entity.RefreshToken;
import com.tjg_project.candy.domain.auth.service.AuthService;
import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.service.UsersService;
import com.tjg_project.candy.global.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final JwtUtil jwtUtil;
    private final AuthService authService;
    private final UsersService usersService;

    @Autowired
    public AuthController(JwtUtil jwtUtil, AuthService authService, UsersService usersService) {
        this.jwtUtil = jwtUtil;
        this.authService = authService;
        this.usersService = usersService;
    }

    /**
     * ✅ 로그인 처리
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Users user) {
        Users us = usersService.login(user.getUserId(), user.getPassword());

        if (us == null) {
            return ResponseEntity.status(401).body(Map.of("error", "Invalid credentials"));
        }

        Long userId = us.getId(); // ✅ 실제 유저 PK
        String accessToken = jwtUtil.generateAccessToken(userId);
        RefreshToken refresh = authService.createRefreshToken(userId);

        // ✅ HttpOnly 쿠키에 RefreshToken 저장
        ResponseCookie cookie = ResponseCookie.from("refresh_token", refresh.getToken())
                .httpOnly(true)
                .secure(false) // 배포 시 true
                .path("/")
                .maxAge(7 * 24 * 60 * 60)
                .sameSite("None")
                .build();

        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, cookie.toString())
                .body(Map.of("accessToken", accessToken));
    }

    /**
     * ✅ AccessToken 재발급
     */
    @PostMapping("/refresh")
    public ResponseEntity<?> refresh(@CookieValue(value = "refresh_token", required = false) String token) {
        if (token == null)
            return ResponseEntity.status(401).body(Map.of("error", "No refresh token"));

        Optional<RefreshToken> refresh = authService.verifyToken(token);
        if (refresh.isEmpty())
            return ResponseEntity.status(401).body(Map.of("error", "Invalid or expired refresh token"));

        Long userId = refresh.get().getUserId();
        String newAccessToken = jwtUtil.generateAccessToken(userId);

        return ResponseEntity.ok(Map.of("accessToken", newAccessToken));
    }

    /**
     * ✅ 로그아웃 처리
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@CookieValue(value = "refresh_token", required = false) String token) {
        System.out.println("✅ verifyToken() token = " + token);
        if (token != null) {
            authService.verifyToken(token).ifPresent(t -> authService.deleteByUserId(t.getUserId()));
        }
        ResponseCookie expiredCookie = ResponseCookie.from("refresh_token", "")
                .httpOnly(true)
                .secure(false)
                .path("/")
                .sameSite("None")
                .maxAge(0)
                .build();

        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, expiredCookie.toString())
                .body(Map.of("message", "Logged out"));
    }
}

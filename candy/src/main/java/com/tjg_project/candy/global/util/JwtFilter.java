package com.tjg_project.candy.global.util;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;

    @Autowired
    public JwtFilter(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);

            try {
                // ✅ 토큰 유효성 검증
                if (jwtUtil.validateToken(token)) {
                    Long userId = jwtUtil.extractUserId(token);

                    UsernamePasswordAuthenticationToken authentication =
                            new UsernamePasswordAuthenticationToken(userId, null, null);
                    authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                    SecurityContextHolder.getContext().setAuthentication(authentication);
                } else {
                    System.out.println("⚠️ Invalid JWT → passing down filterChain (refresh expected)");
                    // ❌ 여기서 return 금지! 그냥 아래로 흘려보내야 프론트 인터셉터가 401을 감지함
                }

            } catch (ExpiredJwtException e) {
                System.out.println("⚠️ AccessToken expired → passing down filterChain (refresh expected)");
                // ❌ 이 경우도 return 금지 (refresh 요청 트리거용)
            } catch (JwtException | IllegalArgumentException e) {
                System.out.println("⚠️ Malformed/Invalid JWT → passing down filterChain (refresh expected)");
                // ❌ 여기서 return 금지
            }
        }

        // ✅ 무조건 다음 필터로 전달해야 프론트가 refresh 트리거 가능
        filterChain.doFilter(request, response);
    }
}

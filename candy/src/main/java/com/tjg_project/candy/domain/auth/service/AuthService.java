package com.tjg_project.candy.domain.auth.service;

import com.tjg_project.candy.domain.auth.entity.RefreshToken;
import com.tjg_project.candy.domain.auth.repository.RefreshTokenRepository;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthService {

    private final RefreshTokenRepository refreshTokenRepository;

    public AuthService(RefreshTokenRepository refreshTokenRepository) {
        this.refreshTokenRepository = refreshTokenRepository;
    }

    /**
     * ✅ RefreshToken 생성 및 DB 저장
     */
    public RefreshToken createRefreshToken(Long userId) {
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setUserId(userId);
        refreshToken.setToken(UUID.randomUUID().toString());
        refreshToken.setExpiryDate(Instant.now().plusSeconds(7 * 24 * 60 * 60)); // 7일

        return refreshTokenRepository.save(refreshToken);
    }

    /**
     * ✅ RefreshToken 검증
     */
    public Optional<RefreshToken> verifyToken(String token) {
        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByToken(token);

        if (refreshToken.isEmpty()) return Optional.empty();

        RefreshToken found = refreshToken.get();
        if (found.getExpiryDate().isBefore(Instant.now())) {
            refreshTokenRepository.delete(found); // 만료 시 삭제
            return Optional.empty();
        }

        return refreshToken;
    }

    /**
     * ✅ 로그아웃 시 삭제
     */
    public void deleteByUserId(Long userId) {
        refreshTokenRepository.deleteByUserId(userId);
    }
}

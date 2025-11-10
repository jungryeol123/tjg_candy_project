package com.tjg_project.candy.domain.auth.service;

import com.tjg_project.candy.domain.auth.entity.RefreshToken;
import com.tjg_project.candy.domain.auth.repository.RefreshTokenRepository;
import org.springframework.stereotype.Service;
import org.apache.commons.codec.digest.DigestUtils;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthService {

    private final RefreshTokenRepository refreshTokenRepository;

    public AuthService(RefreshTokenRepository refreshTokenRepository) {
        this.refreshTokenRepository = refreshTokenRepository;
    }

//    /**
//     * ✅ RefreshToken 생성 및 DB 저장
//     */
//    public RefreshToken createRefreshToken(Long userId) {
//        RefreshToken refreshToken = new RefreshToken();
//        refreshToken.setUserId(userId);
//        refreshToken.setToken(UUID.randomUUID().toString());
//        refreshToken.setExpiryDate(Instant.now().plusSeconds(7 * 24 * 60 * 60)); // 7일
//
//        return refreshTokenRepository.save(refreshToken);
//    }

    public RefreshToken createRefreshToken(Long userId) {
        String rawToken = UUID.randomUUID().toString();
        String hashedToken = DigestUtils.sha256Hex(rawToken); // DB에는 해시 저장

        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setUserId(userId);
        refreshToken.setToken(hashedToken);
        refreshToken.setExpiryDate(Instant.now().plusSeconds(7 * 24 * 60 * 60));

        refreshTokenRepository.save(refreshToken);

        // ✅ DB에는 hashedToken 저장, 평문 토큰은 응답 쿠키로 내려줘야 함
        refreshToken.setToken(rawToken);
        return refreshToken;
    }

    //    /**
//     * ✅ RefreshToken 검증
//     */
//    public Optional<RefreshToken> verifyToken(String token) {
//        Optional<RefreshToken> refreshToken = refreshTokenRepository.findByToken(token);
//
//        if (refreshToken.isEmpty()) return Optional.empty();
//
//        RefreshToken found = refreshToken.get();
//        if (found.getExpiryDate().isBefore(Instant.now())) {
//            refreshTokenRepository.delete(found); // 만료 시 삭제
//            return Optional.empty();
//        }
//
//        return refreshToken;
//    }
    public Optional<RefreshToken> verifyToken(String token) {
        String hashed = DigestUtils.sha256Hex(token);
        Optional<RefreshToken> existing = refreshTokenRepository.findByToken(hashed);
        if (existing.isEmpty()) {
            // ✅ 재사용 공격 감지 가능 (DB에 없는데 요청 들어옴)
            System.out.println("⚠️ Refresh Token reuse detected!");
            // → 보안 로그 기록 or 계정 강제 로그아웃 처리 가능
            return Optional.empty();
        }

        RefreshToken found = existing.get();
        if (found.getExpiryDate().isBefore(Instant.now())) {
            refreshTokenRepository.delete(found); // 만료된 건 삭제
            return Optional.empty();
        }

        // ✅ 새 토큰 발급 (회전)
        refreshTokenRepository.delete(found);
        RefreshToken newToken = createRefreshToken(found.getUserId());

        // 새 토큰을 반환해야 프론트에 쿠키로 다시 세팅 가능
        return Optional.of(newToken);
    }

    /**
     * ✅ 로그아웃 시 삭제
     */
    public void deleteByUserId(Long userId) {
        refreshTokenRepository.deleteByUserId(userId);
    }
}

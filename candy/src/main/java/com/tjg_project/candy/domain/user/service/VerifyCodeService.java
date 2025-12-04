package com.tjg_project.candy.domain.user.service;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class VerifyCodeService {

    private final Map<String, String> codeStorage = new HashMap<>();
    private final Map<String, Long> expireStorage = new HashMap<>();

    /** 인증번호 생성 */
    public String generateCode(String email) {

        String code = String.valueOf((int) (Math.random() * 900000) + 100000);

        codeStorage.put(email, code);
        expireStorage.put(email, System.currentTimeMillis() + 3 * 60 * 1000); // 3분 만료

        return code;
    }

    /** 인증번호 검증 */
    public boolean verifyCode(String email, String code) {
        if (!codeStorage.containsKey(email)) return false;

        // 만료됨
        if (System.currentTimeMillis() > expireStorage.get(email)) {
            codeStorage.remove(email);
            expireStorage.remove(email);
            return false;
        }

        boolean match = codeStorage.get(email).equals(code);

        // 맞으면 삭제(재사용 방지)
        if (match) {
            codeStorage.remove(email);
            expireStorage.remove(email);
        }

        return match;
    }
}


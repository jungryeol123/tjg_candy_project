package com.tjg_project.candy.domain.user.controller;

import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.repository.UserRepository;
import com.tjg_project.candy.domain.user.service.EmailService;
import com.tjg_project.candy.domain.user.service.VerifyCodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class EmailAuthController {

    private final UserRepository userRepository;
    private final EmailService emailService;
    private final VerifyCodeService verifyCodeService;

    /** 🔹 인증번호 보내기 */
    @PostMapping("/send-code")
    public ResponseEntity<?> sendCode(@RequestBody Map<String, String> body) {

        String email = body.get("email");
        System.out.println("받은 이메일 = [" + email + "]");

        if (email == null) return ResponseEntity.badRequest().body("이메일 필요");

        // 회원 존재 확인
        if (!userRepository.existsByEmail(email)) {
            return ResponseEntity.status(404).body("등록된 이메일이 아닙니다.");
        }

        // 인증번호 생성 & 저장
        String code = verifyCodeService.generateCode(email);

        // 이메일 발송
        emailService.sendEmail(email, "비밀번호 재설정 인증번호", "인증번호: " + code);

        return ResponseEntity.ok("인증번호가 발송되었습니다!");
    }

    /** 🔹 인증번호 확인 */
    @PostMapping("/verify-code")
    public ResponseEntity<?> verifyCode(@RequestBody Map<String, String> body) {

        String email = body.get("email");
        String code = body.get("code");

        boolean result = verifyCodeService.verifyCode(email, code);

        if (result) return ResponseEntity.ok("인증 성공");
        else return ResponseEntity.status(400).body("인증번호가 일치하지 않거나 만료되었습니다.");
    }

    /** 🔹 비밀번호 초기화 */
    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody Map<String, String> body) {

        String email = body.get("email");
        String newPassword = body.get("password");

        Users users = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("사용자 없음"));

        users.setPassword(new BCryptPasswordEncoder().encode(newPassword));
        userRepository.save(users);

        return ResponseEntity.ok("비밀번호가 변경되었습니다!");
    }
}


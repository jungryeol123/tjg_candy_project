package com.tjg_project.candy.domain.user.service;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender mailSender;

    public void sendEmail(String to, String subject, String text) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);

        // 🔥 네이버 SMTP는 반드시 FROM 주소를 명시해야 함
        message.setFrom("46823971@naver.com"); // spring.mail.username 과 동일하게!

        mailSender.send(message);
    }
    
}



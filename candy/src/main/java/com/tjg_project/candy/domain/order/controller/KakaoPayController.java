package com.tjg_project.candy.domain.order.controller;


import com.tjg_project.candy.domain.order.dto.KakaoApproveResponse;
import com.tjg_project.candy.domain.order.entity.KakaoPay;
import com.tjg_project.candy.domain.order.dto.KakaoReadyResponse;
import com.tjg_project.candy.domain.order.service.KakaoPayService;
import com.tjg_project.candy.domain.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import org.springframework.http.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/payment")
public class KakaoPayController {

    private final KakaoPayService kakaoPayService;
    private  final OrderService orderService;
    private KakaoPay payInfo = null; //kakaoPay DTO 클래스를 전역으로 선언

    @Autowired
    public KakaoPayController(KakaoPayService kakaoPayService, OrderService orderService) {
        this.kakaoPayService = kakaoPayService;
        this.orderService = orderService;
    }

    @PostMapping("/kakao/ready")
    public KakaoReadyResponse ready(@RequestBody KakaoPay kakaoPay) {
        kakaoPay.setOrderId(UUID.randomUUID().toString());
        payInfo = kakaoPay;
        return kakaoPayService.ready(kakaoPay);
    }

    @GetMapping("/qr/success")
    public ResponseEntity<Void> success(@RequestParam String orderId, @RequestParam("pg_token") String pgToken) {
        KakaoApproveResponse approve = kakaoPayService.approve(orderId, pgToken);
        orderService.saveOrder(payInfo);

        URI redirect = URI.create("http://localhost:3000/payResult?orderId=" + orderId + "&status=success");
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(redirect);
        return new ResponseEntity<>(headers, HttpStatus.FOUND);
    }


    /**
     * ✅ 결제 취소 콜백
     */
    @GetMapping("/qr/cancel")
    public ResponseEntity<?> cancel(@RequestParam String orderId) {
        return ResponseEntity.ok(Map.of("status", "CANCEL", "orderId", orderId));
    }

    /**
     * ✅ 결제 실패 콜백
     */
    @GetMapping("/qr/fail")
    public ResponseEntity<?> fail(@RequestParam String orderId) {
        return ResponseEntity.ok(Map.of("status", "FAIL", "orderId", orderId));
    }
}

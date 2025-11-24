package com.tjg_project.candy.domain.order.service;

import com.tjg_project.candy.domain.order.dto.KakaoApproveResponse;
import com.tjg_project.candy.domain.order.dto.NaverApproveResponse;
import com.tjg_project.candy.domain.order.entity.*;
import com.tjg_project.candy.domain.order.repository.CartRepository;
import com.tjg_project.candy.domain.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final CartRepository cartRepository;

    @Transactional
    public Order saveOrder(KakaoApproveResponse approve, KakaoPay kakaoPay) {

//        // ✅ 1. cidList로 cart 항목 조회
//        List<Cart> cartItems = cartRepository.findByCidIn(kakaoPay.getCidList());
//        if (cartItems.isEmpty()) {
//            throw new IllegalArgumentException("결제할 장바구니 항목이 없습니다.");
//        }

        // ✅ 1. Cart + Product 함께 조회 (N+1 방지)
        List<Cart> cartItems = cartRepository.findAllWithProductByCidIn(kakaoPay.getCidList());
        if (cartItems.isEmpty()) {
            throw new IllegalArgumentException("결제할 장바구니 항목이 없습니다.");
        }

        // ✅ 2. Order 엔티티 생성
        Order order = Order.builder()
                .orderCode(kakaoPay.getOrderId())
//                .userId(kakaoPay.getUserId())
                .upk(kakaoPay.getId())
                .deliveryStatus(DeliveryStatus.READY)
                .totalAmount(kakaoPay.getPaymentInfo().getTotalAmount())
                .shippingFee(kakaoPay.getPaymentInfo().getShippingFee())
                .discountAmount(kakaoPay.getPaymentInfo().getDiscountAmount())
                .receiverName(kakaoPay.getReceiver().getName())
                .receiverPhone(kakaoPay.getReceiver().getPhone())
                .zipcode(kakaoPay.getReceiver().getZipcode())
                .address1(kakaoPay.getReceiver().getAddress1())
                .address2(kakaoPay.getReceiver().getAddress2())
                .tid(approve.getTid())
                .memo(kakaoPay.getReceiver().getMemo())
                .build();

        // ✅ 3. cart → OrderDetail 변환
        for (Cart cart : cartItems) {
            OrderDetail detail = OrderDetail.builder()
                    .ppk(cart.getProduct().getId())          // ✅ product 외래키 참조
                    .productName(cart.getProduct().getProductName())     // ✅ 상품명
                    .qty(cart.getQty())                           // ✅ 수량
                    .price(cart.getProduct().getPrice())          // ✅ 단가
                    .build();

            // OrderDetail에 Order 연결 (양방향 관계일 경우)
            order.addOrderDetail(detail);
        }

        // ✅ 4. 주문 저장 (order + detail cascade)
        Order savedOrder = orderRepository.save(order);

        // ✅ 5. 결제 완료 후 장바구니 항목 삭제
        cartRepository.deleteAll(cartItems);

        return savedOrder;
    }

    @Override
    public List<Order> getOrdersByUser(Long userId) {
        // ✅ 주문 + 상세정보 함께 조회
        return orderRepository.findAllWithDetailsByUpk(userId);
    }



    @Transactional
    public Order saveOrder(NaverApproveResponse approve, NaverPay naverPay) {

//        // ✅ 1. cidList로 cart 항목 조회
//        List<Cart> cartItems = cartRepository.findByCidIn(kakaoPay.getCidList());
//        if (cartItems.isEmpty()) {
//            throw new IllegalArgumentException("결제할 장바구니 항목이 없습니다.");
//        }

        // ✅ 1. Cart + Product 함께 조회 (N+1 방지)
        List<Cart> cartItems = cartRepository.findAllWithProductByCidIn(naverPay.getCidList());
        if (cartItems.isEmpty()) {
            throw new IllegalArgumentException("결제할 장바구니 항목이 없습니다.");
        }

        // ✅ 2. Order 엔티티 생성
        Order order = Order.builder()
                .orderCode(naverPay.getOrderId())
//                .userId(kakaoPay.getUserId())
                .upk(naverPay.getId())
                .totalAmount(naverPay.getPaymentInfo().getTotalAmount())
                .shippingFee(naverPay.getPaymentInfo().getShippingFee())
                .discountAmount(naverPay.getPaymentInfo().getDiscountAmount())
                .receiverName(naverPay.getReceiver().getName())
                .receiverPhone(naverPay.getReceiver().getPhone())
                .zipcode(naverPay.getReceiver().getZipcode())
                .address1(naverPay.getReceiver().getAddress1())
                .address2(naverPay.getReceiver().getAddress2())
                .tid(approve.getTid())
                .memo(naverPay.getReceiver().getMemo())
                .build();

        // ✅ 3. cart → OrderDetail 변환
        for (Cart cart : cartItems) {
            OrderDetail detail = OrderDetail.builder()
                    .ppk(cart.getProduct().getId())          // ✅ product 외래키 참조
                    .productName(cart.getProduct().getProductName())     // ✅ 상품명
                    .qty(cart.getQty())                           // ✅ 수량
                    .price(cart.getProduct().getPrice())          // ✅ 단가
                    .build();

            // OrderDetail에 Order 연결 (양방향 관계일 경우)
            order.addOrderDetail(detail);
        }

        // ✅ 4. 주문 저장 (order + detail cascade)
        Order savedOrder = orderRepository.save(order);

        // ✅ 5. 결제 완료 후 장바구니 항목 삭제
        cartRepository.deleteAll(cartItems);

        return savedOrder;
    }
}



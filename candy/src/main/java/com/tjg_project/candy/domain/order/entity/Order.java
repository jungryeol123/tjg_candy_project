package com.tjg_project.candy.domain.order.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // PK

    @Column(name = "order_code", unique = true, nullable = false, length = 50)
    private String orderCode; // 주문 코드

    @Column(name = "upk", nullable = false)
    private Long upk; // users.id 참조

    @Column(name = "total_amount", nullable = false)
    private int totalAmount; // 총 결제금액

    @Column(name = "shipping_fee")
    private int shippingFee;

    @Column(name = "discount_amount")
    private int discountAmount;

    @Column(name = "receiver_name", length = 50)
    private String receiverName;

    @Column(name = "receiver_phone", length = 20)
    private String receiverPhone;

    @Column(length = 10)
    private String zipcode;

    @Column(length = 100)
    private String address1;

    @Column(length = 100)
    private String address2;

    @Column(length = 200)
    private String memo;

    @Column(name = "odate")
    private LocalDateTime odate = LocalDateTime.now();

    @Column(length = 50)
    private String tid; // 카카오페이 TID
}

//package com.tjg_project.candy.domain.order.entity;
//
//import jakarta.persistence.*;
//import lombok.Data;
//
//@Data
//@Entity
//@Table(name = "order_items")
//public class OrderDetail {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id; // PK
//
//    @Column(name = "order_code", nullable = false)
//    private String orderCode; // orders.order_code 참조
//
//    @Column(name = "ppk", nullable = false)
//    private Long ppk; // product.id 참조
//
//    @Column(nullable = false)
//    private int qty; // 수량
//
//    @Column(nullable = false)
//    private int price; // 단가
//}

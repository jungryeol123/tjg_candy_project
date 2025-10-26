package com.tjg_project.candy.domain.order.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 상품 테이블의 id (Product.id)
    @Column(nullable = false)
    private Long ppk;

    // 유저 테이블의 id (User.id)
    @Column(nullable = false)
    private Long upk;

    private int qty;

    @Column(name = "order_date", length = 30)
    private String orderDate;
}

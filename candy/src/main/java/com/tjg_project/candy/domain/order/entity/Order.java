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

    @Column(length = 10, nullable = false)
    private String pid; // product.pid 참조

    @Column(length = 50, nullable = false)
    private String userId; // users.userId 참조

    private int qty;

    @Column(name = "order_date", length = 30)
    private String orderDate;
}

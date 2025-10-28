package com.tjg_project.candy.domain.order.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "cart")
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // PK

    @Column(name = "upk", nullable = false)
    private Long upk; // users.id 참조

    @Column(name = "ppk", nullable = false)
    private Long ppk; // product.id 참조

    @Column(nullable = false)
    private int qty; // 수량

    @Column(name = "added_at")
    private LocalDateTime addedAt = LocalDateTime.now(); // 추가 시간
}

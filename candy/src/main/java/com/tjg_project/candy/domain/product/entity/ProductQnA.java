package com.tjg_project.candy.domain.product.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "product_qna")
public class ProductQnA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long ppk; // Product.id 참조

    @Column(length = 255, nullable = false)
    private String title;

    // 유저 테이블의 id (User.id)
    @Column(nullable = false)
    private Long upk;

    @Column(length = 20)
    private String date;

    @Column(length = 50)
    private String status;

    private boolean isPrivate;
}

package com.tjg_project.candy.domain.product.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "review")
public class ProductReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 10, nullable = false)
    private String pid; // 상품 ID

    @Column(length = 50, nullable = false)
    private String userId; // 작성자 ID

    @Column(length = 255)
    private String productName; // 상품명

    @Column(length = 200)
    private String title; // 리뷰 제목

    @Column(length = 2000)
    private String content; // 리뷰 본문

    @Column(length = 20)
    private String date; // 작성 날짜

    private boolean isBest; // 베스트 리뷰 여부

    private int likes; // 좋아요 수

    @Column(length = 1000)
    private String images; // 이미지 경로들 (JSON 문자열 형태로 저장)

    @Column(length = 500)
    private String tags; // 태그 문자열 (콤마로 구분하거나 JSON 배열로 저장)
}

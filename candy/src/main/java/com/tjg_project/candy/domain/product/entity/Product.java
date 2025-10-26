package com.tjg_project.candy.domain.product.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // PK

    @Column(length = 20, nullable = false, unique = true)
    private String pid; // 상품 코드

    @Column(length = 255)
    private String imageUrl;

    @Column(name = "image_url_name", length = 100)
    private String imageUrlName;

    @Column(length = 100)
    private String brandName;

    @Column(length = 200)
    private String productName;

    private int price;

    @Column(length = 100)
    private String origin;

    private int dc; // 할인율

    @Column(length = 500)
    private String description;

    private boolean isHotDeal;

    private boolean isMemberSpecial;

    @Column(length = 255)
    private String productDescriptionImage;

    @Column(length = 255)
    private String productInformationImage;

    @Column(length = 30)
    private String productDate;
}

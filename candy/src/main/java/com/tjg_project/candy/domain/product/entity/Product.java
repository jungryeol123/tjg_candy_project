package com.tjg_project.candy.domain.product.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "product")
public class Product {

    @Id
    @Column(length = 10, nullable = false)
    private String pid; // 예: "P0002"

    @Column(length = 255)
    private String imageUrl;

    @Column(name = "imageUrl_name", length = 100)
    private String imageUrlName;

    @Column(length = 100)
    private String brandName;

    @Column(length = 200)
    private String productName;

    private int price;

    @Column(length = 50)
    private String origin;

    private int dc;

    @Column(length = 500)
    private String description;

    private boolean isHotDeal;

    private boolean isMemberSpecial;

    @Column(length = 255)
    private String productDescriptionImage;

    @Column(length = 255)
    private String productInformationImage;

    @Column(length = 20)
    private String productDate;
}

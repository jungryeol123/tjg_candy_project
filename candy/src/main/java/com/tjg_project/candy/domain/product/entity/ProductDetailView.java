package com.tjg_project.candy.domain.product.entity;

import jakarta.persistence.*;
import lombok.Value;

@Value
public class ProductDetailView {

    // product table
    @Id
    Long id; // PK
    String pid; // 상품 코드
    String imageUrl; // 이미지
    String imageUrlName; // 이미지URL이름
    String brandName; // 브랜드명
    String productName; // 상품명
    int price; // 가격
    String origin; // 원산지
    int count; // 재고 수량
    int dc; // 할인율
    String description; // 설명
    boolean isHotDeal; // 핫딜 유무
    boolean isMemberSpecial; // 멤버십 유무
    String productDescriptionImage; // 상품 정보 이미지(상품 정보 탭)
    String productInformationImage; // 상품 상세 정보 이미지(상품 상세 정보 탭)
    String productDate; // 등록일?

    // delivery table
    int delType; // 배송 타입
    String delName; // 배송처
    String delDescription; // 배송 정보
}

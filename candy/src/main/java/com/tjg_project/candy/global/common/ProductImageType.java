package com.tjg_project.candy.global.common;

public enum ProductImageType {
    // 상품 이미지
    PRODUCT_IMAGES(0),
    // 상품 속성 이미지
    PRODUCT_INFORMATION(1),
    // 상품 상세 이미지
    PRODUCT_DESCRIPTION(2);

    private final int code;

    ProductImageType(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    // 이미지 타입 추출
    public static ProductImageType fromCode(int code) {
        for (ProductImageType type : values()) {
            if (type.getCode() == code) return type;
        }
        throw new IllegalArgumentException("Invalid code: " + code);
    }
}

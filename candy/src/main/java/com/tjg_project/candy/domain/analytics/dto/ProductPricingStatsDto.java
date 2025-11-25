package com.tjg_project.candy.domain.analytics.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
@Getter
@Setter
public class ProductPricingStatsDto {
    private Long ppk;                // 상품 PK
    private int currentPrice;        // 현재 가격
    private long clicks;             // 클릭수
    private long orders;             // 구매수
    private double conversionRate;   // 구매비율 (%)
    private int aiLowerPrice;        // AI가 추천한 가격
    private double aiClickRate;      // 예측 클릭률 변화(%)
    private double aiConversionRate; // 예측 구매비율 변화(%)
}

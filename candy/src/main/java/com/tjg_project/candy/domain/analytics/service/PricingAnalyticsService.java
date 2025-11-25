package com.tjg_project.candy.domain.analytics.service;

import com.tjg_project.candy.domain.analytics.dto.ProductPricingStatsDto;
import com.tjg_project.candy.domain.order.repository.OrderDetailRepository;
import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.product.repository.ProductRepository;
import com.tjg_project.candy.domain.user.repository.UserViewLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PricingAnalyticsService {

    private final UserViewLogRepository userViewLogRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    // 개별 상품
    public ProductPricingStatsDto getStats(Long ppk) {

        Product product = productRepository.findById(ppk)
                .orElseThrow(() -> new RuntimeException("상품 없음"));

        long clicks = userViewLogRepository.countViewsByProduct(ppk);
        long orders = Optional.ofNullable(orderDetailRepository.countOrdersByProduct(ppk))
                .orElse(0L);

        double conversionRate = (clicks == 0) ? 0 : (orders * 100.0 / clicks);

        int currentPrice = product.getPrice();
        int aiLowerPrice = (int)(currentPrice * 0.95); // 5% 할인 가정

        double aiClickRate = conversionRate + 10;
        double aiConversionRate = conversionRate + 5;

        return new ProductPricingStatsDto(
                product.getId(),
                product.getPrice(),
                clicks,
                orders,
                conversionRate,
                aiLowerPrice,
                aiClickRate,
                aiConversionRate
        );
    }

    // ⭐ 전체 상품
    public List<ProductPricingStatsDto> getAllStats() {

        return productRepository.findAll().stream()
                .map(p -> {
                    long clicks = userViewLogRepository.countViewsByProduct(p.getId());
                    long orders = Optional.ofNullable(orderDetailRepository.countOrdersByProduct(p.getId()))
                            .orElse(0L);

                    double conversionRate = (clicks == 0) ? 0 : (orders * 100.0 / clicks);

                    int currentPrice = p.getPrice();
                    int aiLowerPrice = (int)(currentPrice * 0.95);

                    double aiClickRate = conversionRate + 10;
                    double aiConversionRate = conversionRate + 5;

                    return new ProductPricingStatsDto(
                            p.getId(),
                            currentPrice,
                            clicks,
                            orders,
                            conversionRate,
                            aiLowerPrice,
                            aiClickRate,
                            aiConversionRate
                    );
                })
                .toList();
    }
}

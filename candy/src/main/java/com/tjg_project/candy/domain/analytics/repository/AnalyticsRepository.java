package com.tjg_project.candy.domain.analytics.repository;

import com.tjg_project.candy.domain.analytics.dto.ConversionRateDto;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AnalyticsRepository extends CrudRepository<com.tjg_project.candy.domain.product.entity.Product, Long> {

    @Query("""
        SELECT new com.tjg_project.candy.domain.analytics.dto.ConversionRateDto(
            p.id,
            p.productName,
            (SELECT COUNT(v) FROM UserViewLog v WHERE v.ppk = p.id),
            (SELECT COALESCE(SUM(od.qty),0)
               FROM OrderDetail od
               WHERE od.ppk = p.id)
        )
        FROM Product p
    """)
    List<ConversionRateDto> getConversionRates();
}

package com.tjg_project.candy.domain.order.repository;

import com.tjg_project.candy.domain.order.entity.OrderDetail;
import com.tjg_project.candy.domain.product.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    // ✅ 많이 팔린 상품 순서로 Product 리스트 가져오기
    @Query(value = """
        SELECT p.* 
        FROM product p
        JOIN (
            SELECT ppk, SUM(qty) AS total_qty
            FROM order_detail
            GROUP BY ppk
            ORDER BY total_qty DESC
        ) od_sum
        ON p.id = od_sum.ppk
        """, nativeQuery = true)
    List<Product> findBestSellingProducts();
}

package com.tjg_project.candy.domain.delivery.repository;


import com.tjg_project.candy.domain.delivery.entity.Delivery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeliveryRepository extends JpaRepository<Delivery, Long> {

    @Query(value = """
    SELECT 
        p.id,
        p.brand_name,
        p.dc,
        p.description,
        p.image_url,
        p.image_url_name,
        p.is_hot_deal,
        p.is_member_special,
        p.origin,
        p.pid,
        p.price,
        p.product_date,
        p.product_description_image,
        p.product_information_image,
        p.product_name
    FROM orders o
    JOIN product p ON o.ppk = p.id
    GROUP BY p.id
    ORDER BY SUM(o.qty) DESC
    LIMIT 10
""", nativeQuery = true)
    List<Delivery> findProductBestList();
}

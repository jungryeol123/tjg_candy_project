package com.tjg_project.candy.domain.order.repository;

import com.tjg_project.candy.domain.order.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Order findByOrderCode(String orderCode);
}

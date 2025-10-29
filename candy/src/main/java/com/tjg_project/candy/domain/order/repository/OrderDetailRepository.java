package com.tjg_project.candy.domain.order.repository;

import com.tjg_project.candy.domain.order.entity.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
}

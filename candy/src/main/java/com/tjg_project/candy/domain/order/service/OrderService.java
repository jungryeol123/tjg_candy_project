package com.tjg_project.candy.domain.order.service;

import com.tjg_project.candy.domain.order.entity.KakaoPay;
import com.tjg_project.candy.domain.order.entity.Order;

import java.util.List;

public interface OrderService {
     Order saveOrder(KakaoPay kakaoPay);
     List<Order> getOrdersByUser(Long id);
}

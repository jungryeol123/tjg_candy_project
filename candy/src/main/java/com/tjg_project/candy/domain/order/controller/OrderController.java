package com.tjg_project.candy.domain.order.controller;

import com.tjg_project.candy.domain.order.entity.Order;
import com.tjg_project.candy.domain.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;



@RestController
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private  OrderService orderService;

    @GetMapping("/my/{id}")
    public ResponseEntity<List<Order>> getMyOrders(@PathVariable Long id) {
        List<Order> orders = orderService.getOrdersByUser(id);
        return ResponseEntity.ok(orders);
    }
}

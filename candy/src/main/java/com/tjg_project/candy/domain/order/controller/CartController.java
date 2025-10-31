package com.tjg_project.candy.domain.order.controller;

import com.tjg_project.candy.domain.order.entity.Cart;
import com.tjg_project.candy.domain.order.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    // 장바구니 등록
    @PostMapping("/add")
    public Cart addToCart(@RequestBody Cart cart) {
        System.out.println("cart : " + cart);
        return cartService.addToCart(cart);
    }
}

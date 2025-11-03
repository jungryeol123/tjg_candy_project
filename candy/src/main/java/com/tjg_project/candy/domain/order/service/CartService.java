package com.tjg_project.candy.domain.order.service;

import com.tjg_project.candy.domain.order.entity.Cart;

import java.util.List;
import java.util.Optional;

public interface CartService {
    Cart addToCart(Cart cart);
    List<Cart> cartList(Long upk);
    int updateQty(Cart cart);
}

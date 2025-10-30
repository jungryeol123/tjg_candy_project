package com.tjg_project.candy.domain.order.service;

import com.tjg_project.candy.domain.order.entity.Cart;

import java.util.Optional;

public interface CartService {
    Cart addToCart(Cart cart);
}

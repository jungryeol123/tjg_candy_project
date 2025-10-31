package com.tjg_project.candy.domain.order.service;

import com.tjg_project.candy.domain.order.entity.Cart;
import com.tjg_project.candy.domain.order.entity.CartDTO;

import java.util.Optional;

public interface CartService {
    CartDTO addToCart(Cart cart);
}

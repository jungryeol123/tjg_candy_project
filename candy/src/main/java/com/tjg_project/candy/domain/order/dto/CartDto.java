package com.tjg_project.candy.domain.order.dto;

import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.user.entity.Users;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartDto {
    private UserDto user;

    private Long cid;

    private Product product;

    private int qty;

    private LocalDateTime addedAt = LocalDateTime.now();
}

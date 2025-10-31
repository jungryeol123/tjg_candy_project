package com.tjg_project.candy.domain.order.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CartDTO {
    private Long cid;
    private int qty;
    private Long userId;
    private Long productId;
    private LocalDateTime addedAt;

    public CartDTO(Long cid, int qty, Long userId, Long productId, LocalDateTime addedAt) {
        this.cid = cid;
        this.qty = qty;
        this.userId = userId;
        this.productId = productId;
        this.addedAt = addedAt;
    }
}
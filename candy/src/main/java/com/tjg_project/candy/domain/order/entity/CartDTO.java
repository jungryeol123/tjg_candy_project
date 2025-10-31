package com.tjg_project.candy.domain.order.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CartDTO {
    private Long cid;
    private int qty;
    private Long upk;
    private Long ppk;
    private LocalDateTime addedAt;

    public CartDTO(Long cid, int qty, Long upk, Long ppk, LocalDateTime addedAt) {
        this.cid = cid;
        this.qty = qty;
        this.upk = upk;
        this.ppk = ppk;
        this.addedAt = addedAt;
    }
}
package com.tjg_project.candy.domain.order.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
@Table(name = "order_detail")
public class OrderDetail {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ✅ 다대일 관계 (주문 하나당 여러 상품)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    private Long productId;
    private String productName;
    private int qty;
    private int price;
}

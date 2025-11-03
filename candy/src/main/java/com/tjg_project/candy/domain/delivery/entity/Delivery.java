package com.tjg_project.candy.domain.delivery.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.tjg_project.candy.domain.product.entity.Product;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "delivery")
public class Delivery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int delType; // PK

    @Column(length = 50)
    private String delName;

    @Column(length = 500)
    private String delDescription;
}

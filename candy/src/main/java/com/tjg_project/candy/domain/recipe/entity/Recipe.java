package com.tjg_project.candy.domain.recipe.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "recipe")
public class Recipe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String recipeName;

    private String thumbnail;      // 사진
    private String difficulty;     // 쉬움 / 보통 / 어려움
    private int time;              // 조리 시간 (분)

    private String mainIngredient; // 주재료

    @Column(columnDefinition = "TEXT")
    private String steps;          // JSON 또는 TEXT 단계별 요리방법
}

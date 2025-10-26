package com.tjg_project.candy.domain.user.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "users")
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // AUTO_INCREMENT

    @Column(length = 50, unique = true, nullable = false)
    private String userId; // 로그인용 ID

    @Column(length = 255, nullable = false)
    private String password;

    @Column(length = 100)
    private String name;

    @Column(length = 100)
    private String email;

    @Column(length = 50)
    private String phone;

    @Column(length = 255)
    private String address;

    @Column(length = 10)
    private String gender;

    @Column(length = 20)
    private String birthday;

    @Column(length = 100)
    private String recommendation;

    @Column(length = 50)
    private String provider;
}

package com.tjg_project.candy.domain.user.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "users")
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userId;

    private String password;

    private String name;

    private String email;

    private String phone;

    private String address;

    private String gender;

    private String birthday;

    private String recommendation;
}

package com.tjg_project.candy.domain.user.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateUserDto {
    private String name;
    private String phone;
    private String email;
}

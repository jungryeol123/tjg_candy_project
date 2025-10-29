package com.tjg_project.candy.domain.user.repository;

import com.tjg_project.candy.domain.user.entity.Users;

public interface UsersRepository {
    boolean signup(Users users);
}

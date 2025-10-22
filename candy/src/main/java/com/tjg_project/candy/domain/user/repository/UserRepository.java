package com.tjg_project.candy.domain.user.repository;

import com.tjg_project.candy.domain.user.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<Users, Long> {
    Optional<Users> findByemail(String email);
    Optional<Users> findByUserId(String userId);
}

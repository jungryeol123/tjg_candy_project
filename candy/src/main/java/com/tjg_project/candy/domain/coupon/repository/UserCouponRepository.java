package com.tjg_project.candy.domain.coupon.repository;

import com.tjg_project.candy.domain.coupon.entity.Coupon;
import com.tjg_project.candy.domain.coupon.entity.UserCoupon;
import com.tjg_project.candy.domain.user.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserCouponRepository extends JpaRepository<UserCoupon, Long> {

    Optional<UserCoupon> findByUsersAndCoupon(Users users, Coupon coupon);

    @Query("SELECT uc FROM UserCoupon uc JOIN FETCH uc.coupon WHERE uc.users.id = :userId")
    List<UserCoupon> findAllWithCouponByUserId(@Param("userId") Long userId);

}

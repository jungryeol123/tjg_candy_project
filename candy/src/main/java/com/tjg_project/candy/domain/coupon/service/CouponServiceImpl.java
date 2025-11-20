package com.tjg_project.candy.domain.coupon.service;

import com.tjg_project.candy.domain.coupon.entity.Coupon;
import com.tjg_project.candy.domain.coupon.entity.UserCoupon;
import com.tjg_project.candy.domain.coupon.repository.CouponRepository;
import com.tjg_project.candy.domain.coupon.repository.UserCouponRepository;
import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CouponServiceImpl implements CouponService {

    private final UserRepository userRepository;
    private final CouponRepository couponRepository;
    private final UserCouponRepository userCouponRepository;

    @Override
    @Transactional
    public boolean issueCouponToUser(Long userId, Long couponId) {
        System.out.println("🔥 issueCouponToUser userId=" + userId + ", couponId=" + couponId);

        Users users = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 사용자입니다."));

        Coupon coupon = couponRepository.findById(couponId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 쿠폰입니다."));

        // 이미 보유한 쿠폰인지 확인
        if (userCouponRepository.findByUsersAndCoupon(users, coupon).isPresent()) {
            return false;
        }

        UserCoupon newCoupon = UserCoupon.builder()
                .users(users)
                .coupon(coupon)
                .qty(1)
                .build();

        userCouponRepository.save(newCoupon);
        return true;
    }

    @Override
    @Transactional
    public boolean deleteUserCoupon(Long userId, Long couponId) {

        Users users = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("사용자 없음"));

        Coupon coupon = couponRepository.findById(couponId)
                .orElseThrow(() -> new IllegalArgumentException("쿠폰 없음"));

        return userCouponRepository.findByUsersAndCoupon(users, coupon)
                .map(uc -> { userCouponRepository.delete(uc); return true; })
                .orElse(false);
    }

    @Override
    public List<UserCoupon> getUserCoupons(Long userId) {
        System.out.println("service******************************" + userId);
        return userCouponRepository.findAllWithCouponByUserId(userId);
    }
}

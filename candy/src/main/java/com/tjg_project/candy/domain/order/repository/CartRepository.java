package com.tjg_project.candy.domain.order.repository;

import com.tjg_project.candy.domain.order.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

    // ✅ 선택된 장바구니 항목 조회 (결제용)
    List<Cart> findByCidIn(List<Long> cidList);

    // ✅ 특정 사용자(upk)의 장바구니 조회
    List<Cart> findByUser_Id(Long upk);

    // ✅ 결제 완료 후 장바구니 비우기
    void deleteByUser_Id(Long upk);
}

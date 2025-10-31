package com.tjg_project.candy.domain.order.service;


import com.tjg_project.candy.domain.order.entity.Cart;
import com.tjg_project.candy.domain.order.entity.CartDTO;
import com.tjg_project.candy.domain.order.repository.CartRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Transactional
public class CartServiceImpl  implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Override
    @Transactional // 중복 방지 Transaction
    // 장바구니 추가
    public CartDTO addToCart(Cart cart) {
        // 상품 id
        Long pid = cart.getProduct().getId();
        // 유저 id
        Long uid = cart.getUser().getId();
        // 수량
        int qty = cart.getQty();
        // 장바구니 존재 유무 체크
        Optional<Cart> optionalCart = cartRepository.findByUser_IdAndProduct_Id(uid,pid);
        Cart savedCart;

        // 장바구니에 이미 존재할 경우
        if(optionalCart.isPresent()){
            // 기존 장바구니 수량 증가
            Cart existingCart = optionalCart.get();
            // 기존 qty + 추가된 qty
            existingCart.setQty(existingCart.getQty() + qty);

            // 기존 장바구니 테이블의 qty값 갱신
            savedCart = cartRepository.save(existingCart);
        } else {
            // 없을경우 레코드 추가
            savedCart = cartRepository.save(cart);
        }
        return new CartDTO(
                savedCart.getCid(),
                savedCart.getQty(),
                savedCart.getUser().getId(),
                savedCart.getProduct().getId(),
                savedCart.getAddedAt()
        );
    }
}

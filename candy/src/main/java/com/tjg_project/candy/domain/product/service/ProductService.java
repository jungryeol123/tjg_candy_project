package com.tjg_project.candy.domain.product.service;

import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.product.entity.ProductQnA;
import com.tjg_project.candy.domain.product.entity.ProductReview;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface ProductService {
    List<Product> getProductProductBestList();
    List<Map<String, Object>> getProductProductQnAList();
    List<Map<String, Object>> getProductReviewList();
    List<Product> getProductList();
    Optional<Product> getProductDetail(Long id);
}

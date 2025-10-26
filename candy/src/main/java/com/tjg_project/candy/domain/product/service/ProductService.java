package com.tjg_project.candy.domain.product.service;

import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.product.entity.ProductReview;

import java.util.List;

public interface ProductService {
    List<ProductReview>getProductReviewList();
    List<Product> getProductList();
}

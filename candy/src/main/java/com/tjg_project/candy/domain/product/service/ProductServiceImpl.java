package com.tjg_project.candy.domain.product.service;


import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.product.entity.ProductDetailView;
import com.tjg_project.candy.domain.product.repository.ProductDetailViewRepository;
import com.tjg_project.candy.domain.product.repository.ProductQnARepository;
import com.tjg_project.candy.domain.product.repository.ProductRepository;
import com.tjg_project.candy.domain.product.repository.ProductReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ProductReviewRepository productReviewRepository;
    @Autowired
    private ProductQnARepository productQnARepository;
    @Autowired
    private ProductDetailViewRepository productDetailViewRepository;

    @Override
    public List<Product> getProductList() {
        return productRepository.findAll();
    }

    @Override
    public  List<Map<String, Object>> getProductReviewList() {
        return productReviewRepository.findAllReviewWithUserName();
    }

    @Override
    public List<Map<String, Object>> getProductProductQnAList() {
        return productQnARepository.findAllProductQnAWithUserName();
    }

    @Override
    public List<Product> getProductProductBestList() {
        return productRepository.findProductBestList();
    }

    @Override
    public Optional<ProductDetailView> getProductDetail(Long id) {
        return productDetailViewRepository.findById(id);
    }
}

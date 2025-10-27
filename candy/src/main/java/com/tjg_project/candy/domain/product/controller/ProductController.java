package com.tjg_project.candy.domain.product.controller;


import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.product.entity.ProductQnA;
import com.tjg_project.candy.domain.product.entity.ProductReview;
import com.tjg_project.candy.domain.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/product")
public class ProductController {


    @Autowired
    private ProductService productService;


    @GetMapping("/productList")
    public List<Product>  getProductList() {
        return productService.getProductList();
    }

    @GetMapping("/productReviewList")
    public List<Map<String, Object>>  getProductReviewList() {
        return productService.getProductReviewList();
    }

    @GetMapping("/productQnAList")
    public List<Map<String, Object>>  getProductProductQnAList() {
        return productService.getProductProductQnAList();
    }

    @GetMapping("/productBestList")
    public List<Product>  getProductProductBestList() {
        return productService.getProductProductBestList();
    }

//    @GetMapping("/productList/time")
//    public List<Product>  getProductListTime(@RequestParam(required = false, defaultValue = "time") String keyword) {
//        return productService.getProductList(keyword);
//    }


}

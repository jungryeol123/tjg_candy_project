package com.tjg_project.candy.domain.product.service;

import com.tjg_project.candy.domain.order.repository.OrderDetailRepository;
import com.tjg_project.candy.domain.product.entity.Product;
import com.tjg_project.candy.domain.product.entity.ProductDetailView;
import com.tjg_project.candy.domain.product.repository.ProductDetailViewRepository;
import com.tjg_project.candy.domain.product.repository.ProductQnARepository;
import com.tjg_project.candy.domain.product.repository.ProductRepository;
import com.tjg_project.candy.domain.product.repository.ProductReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
public class ProductServiceImpl implements ProductService {

    // 파일 업로드(application.yml의 file)
    @Value("${spring.file.upload-dir}")
    private String uploadDir;

    @Autowired
    private ProductRepository   productRepository;
    @Autowired
    private ProductReviewRepository productReviewRepository;
    @Autowired
    private ProductQnARepository productQnARepository;
    @Autowired
    private ProductDetailViewRepository productDetailViewRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;

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
        return orderDetailRepository.findBestSellingProducts();
    }

    @Override
    public Optional<ProductDetailView> getProductDetail(Long id) {
        return productDetailViewRepository.findById(id);
    }

    @Override
    // 상품 정보 등록
    public Product saveProduct(Product product, MultipartFile file){
        // 파일명 취득(업로드시 파일명)
        String originalFilename = file.getOriginalFilename();
        // 파일명 중복방지 UUID_기존파일명
        String filename = UUID.randomUUID() + "_" + originalFilename;

        // 파일을 저장할 디렉토리 취득
        Path path = Paths.get(uploadDir, filename);

        // 파일을 저장할 디렉토리가 없으면 생성 후 저장
        try {
            Files.createDirectories(path.getParent());
            Files.write(path, file.getBytes());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 핫딜 정보 설정(DC값이 설정되있으면 true 아니면 false)
        product.setHotDeal(product.getDc() != 0);
        // 등록 날짜
        product.setProductDate(LocalDate.now());
        // 이미지 정보 설정
        product.setImageUrl(filename);
        product.setImageUrlName(originalFilename);

        // product테이블에 등록
        return productRepository.save(product);
    }
}

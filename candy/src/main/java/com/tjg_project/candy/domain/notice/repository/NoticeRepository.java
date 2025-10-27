package com.tjg_project.candy.domain.notice.repository;


import com.tjg_project.candy.domain.notice.entity.Notice;
import com.tjg_project.candy.domain.product.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long> {
}

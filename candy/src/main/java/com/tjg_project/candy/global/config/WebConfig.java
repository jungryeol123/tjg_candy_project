package com.tjg_project.candy.global.config;

<<<<<<< HEAD

=======
>>>>>>> 3763e88b113d714a8a26e7652e5ec725285acfc2
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
<<<<<<< HEAD

        // URL:  http://localhost:8080/product/파일명
        // 실제 파일 위치: C:/uploads/product/파일명
=======
>>>>>>> 3763e88b113d714a8a26e7652e5ec725285acfc2
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:" + uploadDir + "/");
    }
}
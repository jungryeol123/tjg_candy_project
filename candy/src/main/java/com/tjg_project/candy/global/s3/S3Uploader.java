package com.tjg_project.candy.global.s3;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.core.sync.RequestBody;

import java.io.IOException;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class S3Uploader {

    private final S3Client s3Client;

    // ⚠️ 지금은 하드코딩 (나중에 yml로 뺄 것)
    private final String bucketName = "candy-images-storage";

    public String upload(MultipartFile file, String dir) {
        try {
            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            String key = dir + "/" + fileName;

            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(key)
                    .contentType(file.getContentType())
                    .build();

            s3Client.putObject(
                    request,
                    RequestBody.fromBytes(file.getBytes())
            );

            // 👉 업로드된 S3 경로 반환
            return key;

        } catch (IOException e) {
            throw new RuntimeException("S3 업로드 실패", e);
        }
    }
}

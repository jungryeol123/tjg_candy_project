package com.tjg_project.candy.domain.user.service;


import com.tjg_project.candy.domain.user.entity.UpdateUserDto;
import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UpdateUserService {

    private final UserRepository userRepository;

    // 유저 조회
    public Users getUser(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
    }

    // 유저 정보 수정
    @Transactional
    public Users updateUser(Long id, UpdateUserDto dto) {

        Users user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));

        // 중복 이메일 체크
        if (!user.getEmail().equals(dto.getEmail()) && userRepository.findByEmail(dto.getEmail()).isPresent()) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }

        user.setName(dto.getName());
        user.setEmail(dto.getEmail());
        user.setPhone(dto.getPhone());

        return user;
    }


}

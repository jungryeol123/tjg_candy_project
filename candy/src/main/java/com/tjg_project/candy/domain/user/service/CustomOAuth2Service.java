package com.tjg_project.candy.domain.user.service;

import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Map;



@Service
public class CustomOAuth2Service {
    private final UserRepository userRepository;

    public CustomOAuth2Service(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Users saveOrUpdate(Map<String, Object> response) {
        String email = (String) response.get("email");
        String name = (String) response.get("name");

        return userRepository.findByemail(email)
                .map(user -> {
                    user.setName(name);
                    return userRepository.save(user);
                })
                .orElseGet(() -> {
                    Users newUser = new Users();
                    newUser.setEmail(email);
                    newUser.setName(name);
                    newUser.setProvider("naver");
                    return userRepository.save(newUser);
                });
    }
}

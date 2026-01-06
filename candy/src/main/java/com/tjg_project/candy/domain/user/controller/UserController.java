package com.tjg_project.candy.domain.user.controller;

import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/member")
public class UserController {
    private final UsersService usersService;

    @Autowired
    public UserController(UsersService usersService) {
        this.usersService = usersService;
    }

    @PostMapping("/signup")
    public boolean signup (@RequestBody Users users) {
        return usersService.signup(users);
    }

    @PostMapping("/idcheck")
    public boolean idcheck (@RequestBody Users users) {
        return usersService.idcheck(users);
    }

    // 로그인
    @PostMapping("/login")
    public Users login(@RequestBody Users users) {
        return usersService.login(users.getUserId(), users.getPassword());
    }

    // 아이디 찾기
    @GetMapping("/find-user-id")
    public List<String> findUserId(@RequestParam String query) {
        System.out.println("query = " + query);
        return usersService.findUserId(query); // ✅ 항상 List 반환
    }


//    // 비밀번호 찾기
//    @GetMapping("/find-password")
//    public String findPassword(@RequestParam String id, @RequestParam String query) {
//        String password = usersService.findPassword(id, query);
//        return password != null ? password : "일치하는 회원이 없습니다.";
//    }

}

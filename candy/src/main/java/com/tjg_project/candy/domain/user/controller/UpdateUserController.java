package com.tjg_project.candy.domain.user.controller;

import com.tjg_project.candy.domain.user.entity.UpdateUserDto;
import com.tjg_project.candy.domain.user.entity.Users;
import com.tjg_project.candy.domain.user.service.UpdateUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/userI" +
        "nfo")
@RequiredArgsConstructor
public class UpdateUserController {

    private final UpdateUserService updateUserService;

    /** 사용자 정보 조회 */
    @GetMapping("/{id}")
    public ResponseEntity<Users> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(updateUserService.getUser(id));
    }

    /** 사용자 정보 수정 */
    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateUser(
            @PathVariable Long id,
            @RequestBody UpdateUserDto dto
    ) {
        try {
            Users updatedUser = updateUserService.updateUser(id, dto);
            return ResponseEntity.ok(updatedUser);

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}


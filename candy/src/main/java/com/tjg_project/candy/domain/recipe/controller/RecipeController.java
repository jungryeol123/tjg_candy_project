package com.tjg_project.candy.domain.recipe.controller;

import com.tjg_project.candy.domain.recipe.entity.Recipe;
import com.tjg_project.candy.domain.recipe.repository.RecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/recipes")
@RequiredArgsConstructor
public class RecipeController {

    private final RecipeRepository recipeRepository;

    @GetMapping("/today")
    public ResponseEntity<?> getTodayRecipes() {
        List<Recipe> list = recipeRepository.findRandomRecipes(10);
        return ResponseEntity.ok(list);
    }
}

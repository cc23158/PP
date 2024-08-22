package com.example.SF.DAL;

import com.example.SF.BLL.RecipeService;
import com.example.SF.DTO.Recipe;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/recipe")
public class RecipeController {

    private final RecipeService recipeService;

    public RecipeController(RecipeService recipeService){
        this.recipeService = recipeService;
    }

    @GetMapping("/getAllRecipes")
    public List<Recipe> getAll(){
        return recipeService.getAll();
    }

}

package com.example.SF.DAL;

import com.example.SF.BLL.RecipeService;
import com.example.SF.DTO.Recipe;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/recipe")
public class RecipeController {
    private final RecipeService recipeService;

    public RecipeController(RecipeService recipeService) {
        this.recipeService = recipeService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Recipe> getAll() {
        try {
            return recipeService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Recipe insert(@RequestParam("clientId") Integer clientId, @RequestParam("exerciseId") Integer exerciseId, @RequestParam("weight") Double weight) {
        try {
            return recipeService.insert(clientId, exerciseId, weight);
        }

        catch (Exception e) {
            return null;
        }
    }

    @CrossOrigin
    @PutMapping("/update")
    public ResponseEntity<String> update(@RequestParam("id") Integer id, @RequestParam("weight") Double weight) {
        try {
            recipeService.update(id, weight);
            return ResponseEntity.ok("Recipe updated");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot change recipe's weight");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            recipeService.delete(id);
            return ResponseEntity.ok("Recipe deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete recipe");
        }
    }
}

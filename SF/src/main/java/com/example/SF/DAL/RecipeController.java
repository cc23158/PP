package com.example.SF.DAL;

import com.example.SF.BLL.RecipeService;
import com.example.SF.DTO.Recipe;
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
    @GetMapping("/getByTraining")
    public List<Recipe> getByTraining(@RequestParam("trainingId") Integer training) {
        try {
            return recipeService.getByTraining(training);
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Recipe insert(@RequestParam("trainingId") Integer training, @RequestParam("exerciseId") Integer exercise, @RequestParam("weight") String weight, @RequestParam("reps") String reps, @RequestParam("sets") Integer sets) {
        return recipeService.insert(training, exercise, weight, reps, sets);
    }

    @CrossOrigin
    @PostMapping("/copy")
    public ResponseEntity<String> copy(@RequestParam("clientId") Integer client, @RequestParam("trainingId") Integer training) {
        try {
            recipeService.copy(client, training);
            return ResponseEntity.ok("Training copied");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot copy training");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("trainingId") Integer trainingId, @RequestBody List<Recipe> recipes) {
        try {
            recipeService.delete(trainingId, recipes);
            return ResponseEntity.ok("Recipes deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete recipes");
        }
    }
}

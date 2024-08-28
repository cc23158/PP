package com.example.SF.DAL;

import com.example.SF.BLL.RecipeService;
import com.example.SF.DTO.Recipe;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/postRecipe/{clientId}/{exerciseId}/{weight}")
    public ResponseEntity<String> postRecipe(@PathVariable Integer clientId, @PathVariable Integer exerciseId, @PathVariable Double weight){
        try{
            recipeService.postRecipe(clientId, exerciseId, weight);
            return ResponseEntity.ok().body("Recipe inserted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateRecipe/{id}/{weight}")
    public ResponseEntity<String> updateRecipe(@PathVariable Integer id, @PathVariable Double weight){
        try{
            recipeService.updateRecipe(id, weight);
            return ResponseEntity.ok().body("Recipe updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

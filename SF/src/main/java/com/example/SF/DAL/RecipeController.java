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

    public RecipeController(RecipeService recipeService){
        this.recipeService = recipeService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Recipe> getAll(){
        return recipeService.getAll();
    }

    @CrossOrigin
    @PostMapping("/insertRecipe/{clientId}/{exerciseId}/{weight}")
    public ResponseEntity<String> insertRecipe(@PathVariable Integer clientId, @PathVariable Integer exerciseId, @PathVariable Double weight
    ){
        try{
            recipeService.insertRecipe(clientId, exerciseId, weight);
            return ResponseEntity.ok().body("Recipe inserted");
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Recipe cannot be inserted"); }
    }

    @CrossOrigin
    @PutMapping("/updateRecipe/{id}/{weight}")
    public ResponseEntity<String> updateRecipe(@PathVariable Integer id, @PathVariable Double weight){
        try{
            recipeService.updateRecipe(id, weight);
            return ResponseEntity.ok().body("Recipe updated");
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Recipe's weight cannot be change"); }
    }
}

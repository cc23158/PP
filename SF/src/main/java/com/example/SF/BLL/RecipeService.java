package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.Recipe;
import com.example.SF.BLL.ClientService;
import com.example.SF.BLL.ExerciseService;
import com.example.SF.Repository.IRecipe;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecipeService {
    private final IRecipe iRecipe;
    private final ClientService clientService;
    private final ExerciseService exerciseService;

    @Autowired
    public RecipeService(IRecipe iRecipe, ClientService clientService, ExerciseService exerciseService){
        this.iRecipe = iRecipe;
        this.clientService = clientService;
        this.exerciseService = exerciseService;
    }

    public List<Recipe> getAll(){
        return iRecipe.findAll();
    }

    public Recipe getById(Integer id){
        try{
            return iRecipe.findById(id).orElse(null);
        }

        catch (Exception e){
            System.out.println("Cannot find recipe for ID: " + id);
            return null;
        }
    }
    
    public Recipe insert(Integer clientId, Integer exerciseId, Double weight){
        if (clientId == null || exerciseId == null){
            System.out.println("ClientId or exerciseId must not be empty");
            return null;
        }

        try{
            Recipe recipe = new Recipe();
            recipe.setRecipe_weight(weight);
            
            Client client = clientService.getById(clientId);
            if (client == null){
                System.out.println("Client not found for ID: " + clientId);
                return null;
            }

            Exercise exercise = exerciseService.getById(exerciseId);
            if (exercise == null){
                System.out.println("Exercise not found for ID: " + exerciseId);
                return null;
            }

            recipe.setRecipe_client(client);
            recipe.setRecipe_exercise(exercise);
            
            return iRecipe.save(recipe);
        }

        catch (Exception e){
            System.out.println("Cannot insert recipe: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void update(Integer id, Double weight){
        try{
            iRecipe.updateRecipe(id, weight);
        }

        catch (Exception e){
            System.out.println("Cannot change recipe's weight: " + e.getMessage());
        }
    }

    public void delete(Integer id){
        try{
            iRecipe.deleteById(id);
        }

        catch (Exception e){
            System.out.println("Cannot delete recipe: " + e.getMessage());
        }
    }
}

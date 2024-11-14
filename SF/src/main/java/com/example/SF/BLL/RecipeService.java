package com.example.SF.BLL;

import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.Recipe;
import com.example.SF.DTO.Training;
import com.example.SF.Repository.IRecipe;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecipeService {
    private final IRecipe iRecipe;
    private final TrainingService trainingService;
    private final ExerciseService exerciseService;

    @Autowired
    public RecipeService(IRecipe iRecipe, TrainingService trainingService, ExerciseService exerciseService) {
        this.iRecipe = iRecipe;
        this.trainingService = trainingService;
        this.exerciseService = exerciseService;
    }

    public Recipe getById(Integer id) {
        return iRecipe.findById(id).orElse(null);
    }

    public List<Recipe> getByTraining(Integer trainingId) {
        try {
            return iRecipe.getByTraining(trainingId);
        }

        catch (Exception e) {
            System.out.println("Cannot find exercises by training ID: " + e.getMessage());
            return List.of();
        }
    }

    @Transactional
    public Recipe insert(Integer trainingId, Integer exerciseId, String weight, String reps, Integer sets) {
        if (trainingId == null || exerciseId == null) {
            System.out.println("TrainingId, exerciseId must be not null");
            return null;
        }

        try {
            Recipe recipe = new Recipe();

            Training training = trainingService.getById(trainingId);
            if (training == null) {
                System.out.println("Cannot find training by ID: " + trainingId);
                return null;
            }

            Exercise exercise = exerciseService.getById(exerciseId);
            if (exercise == null) {
                System.out.println("Cannot find exercise by ID: " + exerciseId);
                return null;
            }

            recipe.setRecipe_training(training);
            recipe.setRecipe_exercise(exercise);
            recipe.setRecipe_weight(weight);
            recipe.setRecipe_reps(reps);
            recipe.setRecipe_sets(sets);
            return iRecipe.save(recipe);
        }

        catch (Exception e) {
            System.out.println("Cannot insert recipe: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void copy(Integer clientId, Integer trainingId) {
        if (clientId == null || trainingId == null) {
            System.out.println("ClientId, trainingId must be not null");
            return;
        }

        try {
            Training training = trainingService.getById(trainingId);
            if (training == null) {
                System.out.println("Cannot find training by ID: " + trainingId);
                return;
            }

            List<Recipe> recipes = iRecipe.getByTraining(trainingId);
            if (recipes.isEmpty()) {
                System.out.println("Cannot find recipes by ID: " + trainingId);
                return;
            }

            Training copied = trainingService.insert(training.getTraining_name(), training.getTraining_category(), clientId);

            for (Recipe originalRecipe : recipes) {
                Recipe newRecipe = new Recipe();

                newRecipe.setRecipe_training(copied);
                newRecipe.setRecipe_exercise(originalRecipe.getRecipe_exercise());
                newRecipe.setRecipe_weight(originalRecipe.getRecipe_weight());
                newRecipe.setRecipe_reps(originalRecipe.getRecipe_reps());
                newRecipe.setRecipe_sets(originalRecipe.getRecipe_sets());
                iRecipe.save(newRecipe);
            }
            System.out.println("Recipes copied");
        }

        catch (Exception e) {

        }
    }

    @Transactional
    public void delete(Integer training, List<Recipe> recipes) {
        try {
            iRecipe.delete(training);

            for(int i = 0; i < recipes.size(); i++) {
                Recipe recipe = recipes.get(i);
                insert(recipe.getRecipe_training().getTraining_id(), recipe.getRecipe_exercise().getExercise_id(), recipe.getRecipe_weight(), recipe.getRecipe_reps(), recipe.getRecipe_sets());
            }
        }

        catch (Exception e) {
            System.out.println("Cannot delete recipes: " + e.getMessage());
        }
    }
}

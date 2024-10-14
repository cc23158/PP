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
    public Recipe insert(Integer trainingId, Integer exerciseId, Double weight) {
        if (trainingId == null || exerciseId == null || weight == null) {
            System.out.println("TrainingId, exerciseId and weight must be not null");
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
            return iRecipe.save(recipe);
        }

        catch (Exception e) {
            System.out.println("Cannot insert recipe: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void update(Integer id, Double weight) {
        try {
            iRecipe.update(id, weight);
        }

        catch (Exception e) {
            System.out.println("Cannot change recipe's weight: " + e.getMessage());
        }
    }

    @Transactional
    public void delete(Integer id) {
        try {
            iRecipe.deleteById(id);
        }

        catch (Exception e) {
            System.out.println("Cannot delete recipe: " + e.getMessage());
        }
    }
}

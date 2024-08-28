package com.example.SF.Repository;

import com.example.SF.DTO.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface IRecipe extends JpaRepository<Recipe, Integer> {

    @Procedure(procedureName = "SF.POST_Recipe")
    void postRecipe(
            @Param("recipeClient") Integer clientId,
            @Param("recipeExercise") Integer exerciseId,
            @Param("recipeWeight") Double weight
    );

    @Procedure(procedureName = "SF.UPDATE_Recipe")
    void updateRecipe(
            @Param("recipeId") Integer id,
            @Param("recipeWeight") Double weight
    );

}

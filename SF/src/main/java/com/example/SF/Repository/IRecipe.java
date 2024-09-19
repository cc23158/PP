package com.example.SF.Repository;

import com.example.SF.DTO.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IRecipe extends JpaRepository<Recipe, Integer> {
    @Modifying
    @Query("INSERT INTO Recipe(recipe_client, recipe_exercise, recipe_weight) VALUES(:recipeClient, :recipeExercise, recipeWeight)")
    void insertRecipe(
            @Param("recipeClient") Integer clientId,
            @Param("recipeExercise") Integer exerciseId,
            @Param("recipeWeight") Double weight
    );

    @Modifying
    @Query("UPDATE Recipe SET recipe_weight = :recipeWeight WHERE recipe_id = :recipeId")
    void updateRecipe(
            @Param("recipeId") Integer id,
            @Param("recipeWeight") Double weight
    );
}

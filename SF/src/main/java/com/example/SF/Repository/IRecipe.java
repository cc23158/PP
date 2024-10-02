package com.example.SF.Repository;

import com.example.SF.DTO.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IRecipe extends JpaRepository<Recipe, Integer> {
    @Modifying
    @Query("UPDATE Recipe SET recipe_weight = :recipeWeight WHERE recipe_id = :recipeId")
    void updateRecipe(
            @Param("recipeId") Integer id,
            @Param("recipeWeight") Double weight
    );
}

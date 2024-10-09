package com.example.SF.Repository;

import com.example.SF.DTO.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IRecipe extends JpaRepository<Recipe, Integer> {
    @Modifying
    @Query("UPDATE Recipe SET recipe_weight = :weight WHERE recipe_id = :id")
    void updateRecipe(
            @Param("id") Integer id,
            @Param("weight") Double weight
    );
}

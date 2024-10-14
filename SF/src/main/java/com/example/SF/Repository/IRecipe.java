package com.example.SF.Repository;

import com.example.SF.DTO.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IRecipe extends JpaRepository<Recipe, Integer> {
    @Query(value = "SELECT * FROM SF.GET_Recipe(:training)", nativeQuery = true)
    List<Recipe> getByTraining(@Param("training") Integer training);

    @Modifying
    @Query("UPDATE Recipe SET recipe_weight = :weight WHERE recipe_id = :id")
    void update(
            @Param("id") Integer id,
            @Param("weight") Double weight
    );
}

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
    @Query(value = "DELETE FROM SF.Recipe WHERE recipe_training = :training", nativeQuery = true)
    void delete(@Param("training") Integer training);
}

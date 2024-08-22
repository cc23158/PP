package com.example.SF.Repository;

import com.example.SF.DTO.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IRecipe extends JpaRepository<Recipe, Integer> {
}

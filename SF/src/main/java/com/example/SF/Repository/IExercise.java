package com.example.SF.Repository;

import com.example.SF.DTO.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IExercise extends JpaRepository<Exercise, Integer> {
}

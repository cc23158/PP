package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IExercise extends JpaRepository<Exercise, Integer> {
    @Query(value = "SELECT * FROM SF.GET_Exercise(:muscleId)", nativeQuery = true)
    List<Exercise> getByMuscle(@Param("muscleId") Integer id);

    @Query(value = "SELECT * FROM SF.Exercise WHERE exercise_image = :exerciseImage", nativeQuery = true)
    List<Exercise> findByImage(@Param("exerciseImage") String image);
}

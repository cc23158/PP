package com.example.SF.Repository;

import com.example.SF.DTO.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IExercise extends JpaRepository<Exercise, Integer> {

    @Procedure(procedureName = "SF.GET_Exercise")
    List<Exercise> getExercise(Integer muscleId);

    @Procedure(procedureName = "SF.POST_Exercise")
    void postExercise(
            @Param("exerciseName") String name,
            @Param("exercisePath") String path,
            @Param("exerciseMuscle") Integer muscleId);

    @Procedure(procedureName = "SF.UPDATE_Exercise")
    void updateExercise(
            @Param("exerciseId") Integer id,
            @Param("exercisePath") String path);

    @Procedure(procedureName = "SF.DELETE_Exercise")
    void deleteExercise(@Param("exerciseId") Integer id);
}

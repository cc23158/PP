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
    List<Client> getExerciseByMuscle(@Param("muscleId") Integer id);

    @Modifying
    @Query("INSERT INTO Exercise(exercise_name, exercise_image, exercise_path, exercise_muscle, exercise_active) VALUES(:exerciseName, :exerciseImage, :exercisePath, :exerciseMuscle, TRUE)")
    void insertExercise(
            @Param("exerciseName") String name,
            @Param("exerciseImage") byte[] image,
            @Param("exercisePath") String path,
            @Param("exerciseMuscle") Integer muscleId
    );

    @Modifying
    @Query("UPDATE Exercise SET exercise_image = :exerciseImage WHERE exercise_id = :exerciseId")
    void updateExerciseImage(
            @Param("exerciseId") Integer id,
            @Param("exerciseImage") byte[] image
    );

    @Modifying
    @Query("UPDATE Exercise SET exercise_path = :exercisePath WHERE exercise_id = :exerciseId")
    void updateExercisePath(
            @Param("exerciseId") Integer id,
            @Param("exercisePath") String path
    );

    @Modifying
    @Query("UDPATE Exercise SET exercise_active = FALSE WHERE exercise_id = :exerciseId")
    void deleteExercise(@Param("exerciseId") Integer id);
}

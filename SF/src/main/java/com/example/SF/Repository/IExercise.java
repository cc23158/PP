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
    List<Client> getByMuscle(@Param("muscleId") Integer id);

    @Modifying
    @Query("UPDATE Exercise SET exercise_image = :exerciseImage WHERE exercise_id = :exerciseId")
    void updateImage(
            @Param("exerciseId") Integer id,
            @Param("exerciseImage") String image
    );

    @Modifying
    @Query("UPDATE Exercise SET exercise_path = :exercisePath WHERE exercise_id = :exerciseId")
    void updatePath(
            @Param("exerciseId") Integer id,
            @Param("exercisePath") String path
    );

    @Modifying
    @Query("UPDATE Exercise SET exercise_active = FALSE WHERE exercise_id = :exerciseId")
    void delete(@Param("exerciseId") Integer id);
}

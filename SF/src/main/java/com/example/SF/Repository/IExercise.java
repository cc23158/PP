package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.Muscle;
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

    @Modifying
    @Query("UPDATE Exercise SET exercise_name = :name, exercise_image = :image, exercise_path = :path, exercise_muscle = :muscle WHERE exercise_id = :id")
    void update(
            @Param("id") Integer id,
            @Param("name") String name,
            @Param("image") String image,
            @Param("path") String path,
            @Param("muscle") Muscle muscle
    );
}

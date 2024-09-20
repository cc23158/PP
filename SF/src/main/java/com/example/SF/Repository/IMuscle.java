package com.example.SF.Repository;

import com.example.SF.DTO.Muscle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IMuscle extends JpaRepository<Muscle, Integer> {
    @Modifying
    @Query("INSERT INTO Muscle(muscle_name) VALUES(:muscleName)")
    void insertMuscle(@Param("muscleName") String name);
}

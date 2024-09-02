package com.example.SF.Repository;

import com.example.SF.DTO.Muscle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface IMuscle extends JpaRepository<Muscle, Integer> {

    @Procedure(procedureName = "SF.POST_Muscle")
    void postMuscle(@Param("muscleName") String name);

}
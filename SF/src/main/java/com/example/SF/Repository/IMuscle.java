package com.example.SF.Repository;

import com.example.SF.DTO.Muscle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface IMuscle extends JpaRepository<Muscle, Integer> {
    @Query(value = "SELECT * FROM V_MuscleOrder", nativeQuery = true)
    List<Muscle> getAllOrder();
}

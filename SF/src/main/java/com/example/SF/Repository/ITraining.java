package com.example.SF.Repository;

import com.example.SF.DTO.Training;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ITraining extends JpaRepository<Training, Integer> {
    @Query(value = "SELECT * FROM V_TrainingOrder", nativeQuery = true)
    List<Training> getAllOrder();

    @Query(value = "SELECT * FROM SF.GET_TrainingByClient(:client)", nativeQuery = true)
    List<Training> getByClient(@Param("client") Integer id);

    @Query(value = "SELECT * FROM SF.GET_TrainingByCategory(:client, :category)", nativeQuery = true)
    List<Training> getByCategory(
            @Param("client") Integer client,
            @Param("category") Integer category
    );

    @Modifying
    @Query("UPDATE Training SET training_name = :name WHERE training_id = :id")
    void update(
            @Param("id") Integer id,
            @Param("name") String name
    );

    @Modifying
    @Query("DELETE Training WHERE training_id = :id")
    void delete(@Param("id") Integer id);
}

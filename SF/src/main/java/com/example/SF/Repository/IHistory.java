package com.example.SF.Repository;

import com.example.SF.DTO.History;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface IHistory extends JpaRepository<History, Integer> {
    @Query(value = "SELECT * FROM SF.GET_HistoryByClient(:client)", nativeQuery = true)
    List<History> getByClientNoDate(@Param("client") Integer client);

    @Query(value = "SELECT * FROM SF.GET_History(:client, :date)", nativeQuery = true)
    List<History> getByClient(@Param("client") Integer client, @Param("date") LocalDate date);
}

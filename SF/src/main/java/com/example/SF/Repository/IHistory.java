package com.example.SF.Repository;

import com.example.SF.DTO.History;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IHistory extends JpaRepository<History, Integer> {
    @Query(value = "SELECT * FROM SF.GET_History(:clientId)", nativeQuery = true)
    public List<History> getByClient(@Param("clientId") Integer clientId);
}

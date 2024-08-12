package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface IClient extends JpaRepository<Client, Integer> {

    @Procedure
    Client getByName(@Param("clientName") String name);

}

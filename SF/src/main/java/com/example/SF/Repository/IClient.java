package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface IClient extends JpaRepository<Client, Integer> {

    @Procedure(procedureName = "SF.GET_Client")
    Client getByName(
            @Param("clientName") String name,
            @Param("clientSurname") String surname
    );

    @Procedure(procedureName = "SF.POST_Client")
    void postClient(
            @Param("clientName") String name,
            @Param("clientSurname") String surname,
            @Param("clientAge") Integer age,
            @Param("clientGender") Character gender,
            @Param("clientHeight") Double height,
            @Param("clientWeight") Double weight,
            @Param("clientPassword") String password
    );

    @Procedure(procedureName = "SF.DELETE_Client")
    void deleteClient(
            @Param("clientId") Integer id
    );

}
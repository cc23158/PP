package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;

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
            @Param("clientEmail") String email,
            @Param("clientAge") Integer age,
            @Param("clientBirthday") LocalDate birthday,
            @Param("clientGender") Character gender,
            @Param("clientHeight") Double height,
            @Param("clientWeight") Double weight,
            @Param("clientPassword") String password
    );

    @Procedure(procedureName = "SF.UPDATE_ClientData")
    void updateClientData(
            @Param("clientId") Integer id,
            @Param("clientAge") Integer age,
            @Param("clientHeight") Double height,
            @Param("clientWeight") Double weight
    );

    @Procedure(procedureName = "SF.UPDATE_ClientPassword")
    void updateClientPassword(
            @Param("clientId") Integer id,
            @Param("clientPassword") String password
    );

    @Procedure(procedureName = "SF.DELETE_Client")
    void deleteClient(
            @Param("clientId") Integer id
    );

    Client getByEmail(String email);

}

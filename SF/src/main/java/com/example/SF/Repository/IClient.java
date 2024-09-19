package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;

public interface IClient extends JpaRepository<Client, Integer> {
    @Query(value = "SELECT * FROM SF.GET_ClientByName(:clientName)", nativeQuery = true)
    Client getByName(@Param("clientName") String name);


    @Query(value = "SELECT * FROM SF.GET_ClientByEmail(:clientEmail)", nativeQuery = true)
    Client getByEmail(@Param("clientEmail") String email);


    @Modifying
    @Query("INSERT INTO Client(client_name, client_email, client_birthday, client_gender, client_weight, client_password, client_active) VALUES(:clientName, :clientEmail, :clientBirthday, :clientGender, :clientWeight, :clientPassword, TRUE)")
    void insertClient(
            @Param("clientName") String name,
            @Param("clientEmail") String email,
            @Param("clientBirthday") LocalDate birthday,
            @Param("clientGender") Character gender,
            @Param("clientWeight") Double weight,
            @Param("clientPassword") String password
    );

    @Modifying
    @Query("UPDATE Client SET client_weight = :clientWeight WHERE client_id = :clientId")
    void updateClientData(
            @Param("clientId") Integer id,
            @Param("clientWeight") Double weight
    );

    @Modifying
    @Query("UPDATE Client SET client_password = :clientPassword WHERE client_id = :clientId")
    void updateClientPassword(
            @Param("clientId") Integer id,
            @Param("clientPassword") String password
    );

    @Modifying
    @Query("UPDATE Client SET client_active = FALSE WHERE client_id = :clientId")
    void deleteClient(@Param("clientId") Integer id);
}

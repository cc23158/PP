package com.example.SF.Repository;

import com.example.SF.DTO.Adm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IAdm extends JpaRepository<Adm, Integer> {
    @Query("SELECT SF.GET_Adm(:admEmail, :admPassword)")
    boolean verify(
            @Param("admEmail") String email,
            @Param("admPassword") String password
    );

    @Modifying
    @Query("INSERT INTO Adm(adm_email, adm_password, adm_salary, adm_active) VALUES (:admEmail, :admPassword, :admSalary, TRUE)")
    void insertAdm(
            @Param("admEmail") String email,
            @Param("admPassword") String password,
            @Param("admSalary") Double salary
    );

    @Modifying
    @Query("UPDATE Adm SET adm_salary = :admSalary WHERE adm_id = :admId")
    void updateAdmSalary(
            @Param("admId") Integer id,
            @Param("admSalary") Double salary
    );

    @Modifying
    @Query("UPDATE Adm SET adm_password = :admPassword WHERE adm_id = :admId")
    void updateAdmPassword(
            @Param("admId") Integer id,
            @Param("admPassword") String password
    );

    @Modifying
    @Query("UPDATE Adm SET adm_active = FALSE WHERE adm_id = :admId")
    void deleteAdm(@Param("admId") Integer id);
}

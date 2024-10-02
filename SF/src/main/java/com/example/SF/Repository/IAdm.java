package com.example.SF.Repository;

import com.example.SF.DTO.Adm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IAdm extends JpaRepository<Adm, Integer> {
    @Query(value = "SELECT SF.GET_Adm(:admEmail, :admPassword)", nativeQuery = true)
    boolean verify(
            @Param("admEmail") String email,
            @Param("admPassword") String password
    );

    @Modifying
    @Query("UPDATE Adm SET adm_salary = :admSalary WHERE adm_id = :admId")
    void updateSalary(
            @Param("admId") Integer id,
            @Param("admSalary") Double salary
    );

    @Modifying
    @Query("UPDATE Adm SET adm_password = :admPassword WHERE adm_id = :admId")
    void updatePassword(
            @Param("admId") Integer id,
            @Param("admPassword") String password
    );

    @Modifying
    @Query("UPDATE Adm SET adm_active = FALSE WHERE adm_id = :admId")
    void delete(@Param("admId") Integer id);
}

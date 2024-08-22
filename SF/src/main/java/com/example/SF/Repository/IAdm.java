package com.example.SF.Repository;

import com.example.SF.DTO.Adm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface IAdm extends JpaRepository<Adm, Integer> {

    @Procedure(procedureName = "SF.GET_Adm")
    boolean verify(
            @Param("admEmail") String email,
            @Param("admPassword") String password
    );

    @Procedure(procedureName = "SF.POST_Adm")
    void postAdm(
            @Param("admEmail") String email,
            @Param("admPassword") String password,
            @Param("admSalary") Double salary
    );

    @Procedure(procedureName = "SF.UPDATE_AdmSalary")
    void updateAdmSalary(
            @Param("admId") Integer id,
            @Param("admSalary") Double salary
    );

    @Procedure(procedureName = "SF.UPDATE_AdmPassword")
    void updateAdmPassword(
            @Param("admId") Integer id,
            @Param("admPassword") String password
    );

    @Procedure(procedureName = "SF.DELETE_Adm")
    void deleteAdm(
            @Param("admId") Integer id
    );

}

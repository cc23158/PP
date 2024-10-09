package com.example.SF.Repository;

import com.example.SF.DTO.Adm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IAdm extends JpaRepository<Adm, Integer> {
    @Query(value = "SELECT * FROM V_AdmOrder", nativeQuery = true)
    List<Adm> getAllOrder();

    @Query(value = "SELECT SF.GET_Adm(:email, :password)", nativeQuery = true)
    boolean verify(
            @Param("email") String email,
            @Param("password") String password
    );

    @Modifying
    @Query("UPDATE Adm SET adm_salary = :salary WHERE adm_id = :id")
    void updateSalary(
            @Param("id") Integer id,
            @Param("salary") Double salary
    );

    @Modifying
    @Query("UPDATE Adm SET adm_password = :password WHERE adm_id = :id")
    void updatePassword(
            @Param("id") Integer id,
            @Param("password") String password
    );

    @Modifying
    @Query("UPDATE Adm SET adm_active = FALSE WHERE adm_id = :id")
    void delete(@Param("id") Integer id);
}

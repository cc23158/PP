package com.example.SF.DTO;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "adm", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Adm {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "adm_id")
    private Integer adm_id;

    @Column(name = "adm_email")
    private String adm_email;

    @Column(name = "adm_password")
    private String adm_password;

    @Column(name = "adm_salary")
    private Double adm_salary;

    @Column(name = "adm_active")
    private Boolean adm_active;
}

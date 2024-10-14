package com.example.SF.DTO;

import jakarta.persistence.*;
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
    @Column(name = "adm_id", nullable = false)
    private Integer adm_id;

    @Column(name = "adm_email", nullable = false)
    private String adm_email;

    @Column(name = "adm_password", nullable = false)
    private String adm_password;

    @Column(name = "adm_salary", nullable = false)
    private Double adm_salary;

    @Column(name = "adm_active", nullable = false)
    private Boolean adm_active;
}

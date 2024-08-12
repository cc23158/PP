package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Adm", schema = "SF")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Adm {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "adm_id")
    private Integer adm_id;

    @Column(name = "adm_user")
    private String adm_user;

    @Column(name = "adm_password")
    private String adm_password;

}

package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "Client", schema = "SF")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Client {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer client_id;

    @Column(name = "client_name")
    private String client_name;

    @Column(name = "client_email")
    private String client_email;

    @Column(name = "client_birthday")
    private LocalDate client_birthday;

    @Column(name = "client_gender")
    private Character client_gender;

    @Column(name = "client_weight")
    private Double client_weight;

    @Column(name = "client_password")
    private String client_password;

    @Column(name = "client_active")
    private Boolean client_active;

}

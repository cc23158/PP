package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "client", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Client {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "client_id", nullable = false)
    private Integer client_id;

    @Column(name = "client_name", nullable = false)
    private String client_name;

    @Column(name = "client_email", nullable = false)
    private String client_email;

    @Column(name = "client_birthday", nullable = false)
    private LocalDate client_birthday;

    @Column(name = "client_gender", nullable = false)
    private Character client_gender;

    @Column(name = "client_weight", nullable = false)
    private Double client_weight;

    @Column(name = "client_password", nullable = false)
    private String client_password;

    @Column(name = "client_active", nullable = false)
    private Boolean client_active;
}

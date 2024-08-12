package com.example.SF.DTO;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

    @Column(name = "client_age")
    private Integer client_age;

    @Column(name = "client_gender")
    private Character client_gender;

    @Column(name = "client_height")
    private Double client_height;

    @Column(name = "client_weight")
    private Double client_weight;

    @Column(name = "client_password")
    private String client_password;

}

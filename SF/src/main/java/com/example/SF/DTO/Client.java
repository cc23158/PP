package com.example.SF.DTO;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "client")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Client {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "client_id")
    private Integer client_id;

    @Column(name = "client_name", nullable = false, length = 30)
    private String client_name;

    @Column(name = "client_age")
    @NotNull(message = "Age cannot be null")
    @Min(value = 1, message = "Age must be greater than 0")
    @Max(value = 116, message = "Age must be less than 117")
    private Integer client_age;

    @Column(name = "client_gender")
    @NotNull(message = "Gender cannot be null")
    @Pattern(regexp = "^[MF]$", message = "Gender must be either M or F")
    private Character client_gender;

    @Column(name = "client_height")
    @NotNull(message = "Height cannot be null")
    @DecimalMin(value = "0.5", message = "Height must be greater than 0.5 meters")
    @DecimalMax(value = "2.5", message = "Height must be less than 2.5 meters")
    private Double client_height;

    @Column(name = "client_weight")
    @NotNull(message = "Weight cannot be null")
    @DecimalMin(value = "0.0", message = "Weight must be greater than 0.0 kg")
    @DecimalMax(value = "600", message = "Weight must be less than 600 kg")
    private Double client_weight;

    @Column(name = "client_password", nullable = false, length = 60)
    private String client_password;

}

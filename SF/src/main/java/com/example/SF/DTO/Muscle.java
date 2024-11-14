package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "muscle", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Muscle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "muscle_id", nullable = false)
    private Integer muscle_id;

    @Column(name = "muscle_name", nullable = false)
    private String muscle_name;
}

package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Muscle", schema = "SF")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Muscle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "muscle_id")
    private Integer muscle_id;

    @Column(name = "muscle_name")
    private String muscle_name;
}

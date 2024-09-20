package com.example.SF.DTO;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.Exercise;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "recipe", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Recipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer recipe_id;

    @ManyToOne
    @JoinColumn(name = "recipe_client", referencedColumnName = "client_id", nullable = false)
    private Client recipe_client;

    @ManyToOne
    @JoinColumn(name = "recipe_exercise", referencedColumnName = "exercise_id", nullable = false)
    private Exercise recipe_exercise;

    @Column(name = "recipe_weight", nullable = true)
    private Double recipe_weight;
}

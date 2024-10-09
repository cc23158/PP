package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
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

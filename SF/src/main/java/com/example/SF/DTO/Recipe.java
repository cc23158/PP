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
    @Column(name = "recipe_id", nullable = false)
    private Integer recipe_id;

    @ManyToOne
    @JoinColumn(name = "recipe_training", referencedColumnName = "training_id", nullable = false)
    private Training recipe_training;

    @ManyToOne
    @JoinColumn(name = "recipe_exercise", referencedColumnName = "exercise_id", nullable = false)
    private Exercise recipe_exercise;

    @Column(name = "recipe_weight", nullable = true)
    private String recipe_weight;

    @Column(name = "recipe_reps", nullable = true)
    private String recipe_reps;

    @Column(name = "recipe_sets", nullable = true)
    private Integer recipe_sets;
}

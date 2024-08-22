package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Recipe", schema = "SF")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Recipe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "recipe_id")
    private Integer recipe_id;

    @ManyToOne
    @JoinColumn(name = "recipe_client", referencedColumnName = "client_id")
    private Client recipe_client;

    @ManyToOne
    @JoinColumn(name = "recipe_exercise", referencedColumnName = "exercise_id")
    private Exercise recipe_exercise;

    @Column(name = "recipe_weight")
    private Double recipe_weight;

}

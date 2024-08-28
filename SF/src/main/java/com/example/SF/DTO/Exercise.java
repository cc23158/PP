package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Exercise", schema = "SF")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Exercise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "exercise_id")
    private Integer exercise_id;

    @Column(name = "exercise_name")
    private String exercise_name;

    @Column(name = "exercise_path")
    private String exercise_path;

    @ManyToOne
    @JoinColumn(name = "exercise_muscle", referencedColumnName = "muscle_id")
    private Muscle exercise_muscle;

    @Column(name = "exercise_active")
    private Boolean exercise_active;

}

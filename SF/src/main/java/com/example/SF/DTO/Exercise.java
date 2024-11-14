package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "exercise", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Exercise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "exercise_id", nullable = false)
    private Integer exercise_id;

    @Column(name = "exercise_name", nullable = false)
    private String exercise_name;

    @Column(name = "exercise_image", nullable = false)
    private String exercise_image;

    @Column(name = "exercise_path", nullable = false)
    private String exercise_path;

    @ManyToOne
    @JoinColumn(name = "exercise_muscle", referencedColumnName = "muscle_id", nullable = false)
    private Muscle exercise_muscle;
}

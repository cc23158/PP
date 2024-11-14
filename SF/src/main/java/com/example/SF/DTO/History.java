package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "history", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class History {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "history_id", nullable = false)
    private Integer history_id;

    @ManyToOne
    @JoinColumn(name = "history_client", referencedColumnName = "client_id", nullable = false)
    private Client history_client;

    @ManyToOne
    @JoinColumn(name = "history_exercise", referencedColumnName = "exercise_id", nullable = false)
    private Exercise history_exercise;

    @Column(name = "history_weight", nullable = true)
    private String history_weight;

    @Column(name = "history_reps", nullable = true)
    private String history_reps;

    @Column(name = "history_sets", nullable = true)
    private Integer history_sets;

    @Column(name = "history_date", nullable = true)
    private LocalDate history_date;
}
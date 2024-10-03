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
    @JoinColumn(name = "history_recipe", referencedColumnName = "recipe_id", nullable = false)
    private Recipe history_recipe;

    @Column(name = "history_date", nullable = false)
    private LocalDate history_date;

    @Column(name = "history_time", nullable = true)
    private LocalTime history_time;
}

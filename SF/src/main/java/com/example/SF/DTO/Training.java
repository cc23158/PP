package com.example.SF.DTO;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "training", schema = "sf")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Training {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "training_id", nullable = false)
    private Integer training_id;

    @Column(name = "training_name", nullable = false)
    private String training_name;

    @Column(name = "training_category", nullable = false)
    private Integer training_category;

    @ManyToOne
    @JoinColumn(name = "training_client", nullable = false)
    private Client training_client;
}

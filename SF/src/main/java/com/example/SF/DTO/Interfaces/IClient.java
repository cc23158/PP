package com.example.SF.DTO.Interfaces;

import com.example.SF.DTO.Classes.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.JpaParameters;

public interface IClient extends JpaRepository<Client, Integer> {
}

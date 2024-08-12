package com.example.SF.Repository;

import com.example.SF.DTO.Client;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IClient extends JpaRepository<Client, Integer> {
}

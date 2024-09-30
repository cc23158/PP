package com.example.SF.Repository;

import com.example.SF.DTO.History;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IHistory extends JpaRepository<History, Integer> {
}

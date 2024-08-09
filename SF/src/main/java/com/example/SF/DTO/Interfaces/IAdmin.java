package com.example.SF.DTO.Interfaces;

import com.example.SF.DTO.Classes.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IAdmin extends JpaRepository<Admin, Integer> {
}

package com.example.SF.Repository;

import com.example.SF.DTO.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IAdmin extends JpaRepository<Admin, Integer> {
}

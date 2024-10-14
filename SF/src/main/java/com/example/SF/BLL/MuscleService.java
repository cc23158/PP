package com.example.SF.BLL;

import com.example.SF.DTO.Muscle;
import com.example.SF.Repository.IMuscle;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MuscleService {
    private final IMuscle iMuscle;

    @Autowired
    public MuscleService(IMuscle iMuscle) {
        this.iMuscle = iMuscle;
    }

    public List<Muscle> getAll() {
        try {
            return iMuscle.getAllOrder();
        }

        catch (Exception e) {
            System.out.println("Cannot get muscles: " + e.getMessage());
            return List.of();
        }
    }

    public Muscle getById(Integer id) {
        return iMuscle.findById(id).orElse(null);
    }

    @Transactional
    public Muscle insert(String name) {
        try {
            Muscle muscle = new Muscle();
            muscle.setMuscle_name(name);

            return iMuscle.save(muscle);
        }

        catch (Exception e) {
            System.out.println("Cannot insert muscle: " + e.getMessage());
            return null;
        }
    }

    public void delete(Integer id) {
        try {
            iMuscle.deleteById(id);
        }

        catch (Exception e) {
            System.out.println("Cannot delete muscle: " + e.getMessage());
        }
    }
}

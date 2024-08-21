package com.example.SF.BLL;

import com.example.SF.DTO.Exercise;
import com.example.SF.Repository.IExercise;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExerciseService {

    private final IExercise iExercise;

    @Autowired
    public ExerciseService(IExercise iExercise){
        this.iExercise = iExercise;
    }

    public List<Exercise> getAll(){
        return iExercise.findAll();
    }

}

package com.example.SF.DAL;

import com.example.SF.BLL.ExerciseService;
import com.example.SF.DTO.Exercise;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/exercise")
public class ExerciseController {

    private final ExerciseService exerciseService;

    public ExerciseController(ExerciseService exerciseService){
        this.exerciseService = exerciseService;
    }

    @GetMapping("/getAllExercises")
    public List<Exercise> getAll(){
        return exerciseService.getAll();
    }



}

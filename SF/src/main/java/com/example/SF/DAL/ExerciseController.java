package com.example.SF.DAL;

import com.example.SF.BLL.ExerciseService;
import com.example.SF.DTO.Exercise;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/getExerciseByMuscle/{muscleId}")
    public List<Exercise> getExercise(@PathVariable Integer muscleId){
        return exerciseService.getExercise(muscleId);
    }

    @PostMapping("/postExercise/{name}/{path}/{muscleId}")
    public ResponseEntity<String> postExercise(@PathVariable  String name, @PathVariable String path, @PathVariable Integer muscleId){
        try{
            exerciseService.postExercise(name, path, muscleId);
            return ResponseEntity.ok().body("Exercise inserted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    @PutMapping("/updateExercise/{id}/{path}")
    public ResponseEntity<String> updateExercise(@PathVariable Integer id, @PathVariable String path){
        try{
            exerciseService.updateExercise(id, path);
            return ResponseEntity.ok().body("Exercise updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    @DeleteMapping("/deleteExercise/{id}")
    public ResponseEntity<String> deleteExercise(@PathVariable Integer id){
        try{
            exerciseService.deleteExercise(id);
            return ResponseEntity.ok().body("Exercise deleted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

}

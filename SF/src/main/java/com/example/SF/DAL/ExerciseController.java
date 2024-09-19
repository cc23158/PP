package com.example.SF.DAL;

import com.example.SF.BLL.ExerciseService;
import com.example.SF.DTO.Exercise;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/exercise")
public class ExerciseController {
    private final ExerciseService exerciseService;

    public ExerciseController(ExerciseService exerciseService){
        this.exerciseService = exerciseService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Exercise> getAll(){
        return exerciseService.getAll();
    }

    @CrossOrigin
    @PostMapping("/insertExercise/{muscleId}/{name}")
    public ResponseEntity<String> insertExercise(
            @PathVariable Integer muscleId,
            @PathVariable String name,
            @RequestParam MultipartFile image,
            @RequestParam String path
    ){
        try {
            byte[] imageBytes = image.getBytes();
            exerciseService.insertExercise(name, imageBytes, path, muscleId);
            return ResponseEntity.ok().body("Exercise inserted");
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Exercise cannot be inserted"); }
    }

    @CrossOrigin
    @PutMapping("/updateExerciseImage/{id}")
    public ResponseEntity<String> updateExerciseImage(
            @PathVariable Integer id,
            @RequestParam MultipartFile image
    ){
        try {
            byte[] imageBytes = image.getBytes();
            exerciseService.updateExerciseImage(id, imageBytes);
            return ResponseEntity.ok().body("Exercise updated");
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Exercise's image cannot be changed"); }
    }

    @CrossOrigin
    @PutMapping("/updateExercisePath/{id}")
    public ResponseEntity<String> updateExerciseImage(
            @PathVariable Integer id,
            @RequestParam String path
    ){
        try {
            exerciseService.updateExercisePath(id, path);
            return ResponseEntity.ok().body("Exercise updated");
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Exercise's path cannot be changed"); }
    }

    @CrossOrigin
    @DeleteMapping("/deleteExercise/{id}")
    public ResponseEntity<String> deleteExercise(
            @PathVariable Integer id
    ){
        try {
            exerciseService.deleteExercise(id);
            return ResponseEntity.ok().body("Exercise deleted");
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Exercise cannot be deleted"); }
    }
}

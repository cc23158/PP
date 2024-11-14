package com.example.SF.DAL;

import com.example.SF.BLL.ExerciseService;
import com.example.SF.DTO.Exercise;
import com.example.SF.ImageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/exercise")
public class ExerciseController {
    private final ExerciseService exerciseService;
    private final ImageService imageService;

    public ExerciseController(ExerciseService exerciseService, ImageService imageService) {
        this.exerciseService = exerciseService;
        this.imageService = imageService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Exercise> getAll() {
        try {
            return exerciseService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/getByMuscle")
    public List<Exercise> getByMuscle(@RequestParam("muscleId") Integer muscleId) {
        try {
            return exerciseService.getByMuscle(muscleId);
        }

        catch (Exception e) {
            return null;
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Exercise insert(@RequestParam("muscleId") Integer muscleId, @RequestParam("name") String name, @RequestParam("image") MultipartFile image, @RequestParam("path") String path) {
        String imageUrl = imageService.uploadImage(image);
        return exerciseService.insert(name, imageUrl, path, muscleId);
    }

    @CrossOrigin
    @PutMapping("/update")
    public ResponseEntity<String> update(@RequestParam("id") Integer id, @RequestParam("muscleId") Integer muscleId, @RequestParam("name") String name, @RequestParam(value = "image", required = false) MultipartFile image, @RequestParam("path") String path) {
        try {
            String imageUrl = null;

            if (image != null && !image.isEmpty()) {
                imageUrl = imageService.uploadImage(image);
            }

            exerciseService.update(id, name, imageUrl, path, muscleId);
            return ResponseEntity.ok("Exercises synchronized successfully");
        }

        catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error synchronizing exercises");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            exerciseService.delete(id);
            return ResponseEntity.ok().body("Exercise deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete exercise");
        }
    }
}
package com.example.SF.DAL;

import com.example.SF.BLL.TrainingService;
import com.example.SF.DTO.Training;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/training")
public class TrainingController {
    private final TrainingService trainingService;

    public TrainingController(TrainingService trainingService) {
        this.trainingService = trainingService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Training> getAll() {
        try {
            return trainingService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/getByClient")
    public List<Training> getByClient(@RequestParam("clientId") Integer clientId) {
        try {
            return trainingService.getByClient(clientId);
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/getByCategory")
    public List<Training> getByCategory(@RequestParam("clientId") Integer clientId, @RequestParam("category") Integer category) {
        try {
            return trainingService.getByCategory(clientId, category);
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Integer insert(@RequestParam("name") String name, @RequestParam("category") Integer category, @RequestParam("clientId") Integer clientId) {
        Training training = trainingService.insert(name, category, clientId);
        return training.getTraining_id();
    }

    @CrossOrigin
    @PutMapping("/update")
    public ResponseEntity<String> update(@RequestParam("id") Integer id, @RequestParam("name") String name) {
        try {
            trainingService.update(id, name);
            return ResponseEntity.ok("Training's name changed");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot change training's name");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            trainingService.delete(id);
            return ResponseEntity.ok("Training deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete training");
        }
    }
}

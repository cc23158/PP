package com.example.SF.DAL;

import com.example.SF.BLL.MuscleService;
import com.example.SF.DTO.Muscle;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/muscle")
public class MuscleController {
    private final MuscleService muscleService;

    public MuscleController(MuscleService muscleService) {
        this.muscleService = muscleService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Muscle> getAll() {
        try {
            return muscleService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Muscle insert(@RequestParam("name") String name) {
        return muscleService.insert(name);
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            muscleService.delete(id);
            return ResponseEntity.ok("Muscle deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete muscle");
        }
    }
}

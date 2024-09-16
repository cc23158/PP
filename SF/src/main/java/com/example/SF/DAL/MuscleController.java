package com.example.SF.DAL;

import com.example.SF.BLL.MuscleService;
import com.example.SF.DTO.Muscle;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/muscle")
public class MuscleController {

    private final MuscleService muscleService;

    public MuscleController(MuscleService muscleService){
        this.muscleService = muscleService;
    }

    @CrossOrigin
    @GetMapping("/getAllMuscles")
    public List<Muscle> getAll(){
        return muscleService.getAll();
    }

    @PostMapping("/postMuscle/{name}")
    public ResponseEntity<String> postMuscle(@PathVariable String name){
        try{
            muscleService.postMuscle(name);
            return ResponseEntity.ok().body("Muscle inserted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

package com.example.SF.DAL;

import com.example.SF.BLL.MuscleService;
import com.example.SF.DTO.Muscle;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
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
    @GetMapping("/getAll")
    public List<Muscle> getAll(){
        return muscleService.getAll();
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Muscle insert(@RequestParam("name") String name){
        try{
            return muscleService.insert(name);
        }

        catch (Exception e){
            return null;
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id){
        try{
            muscleService.delete(id);
            return ResponseEntity.ok("Muscle deleted");
        }

        catch (Exception e){
            return ResponseEntity.badRequest().body("Cannot delete muscle");
        }
    }
}

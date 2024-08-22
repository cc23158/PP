package com.example.SF.DAL;

import com.example.SF.BLL.AdmService;
import com.example.SF.DTO.Adm;
import jakarta.persistence.EntityNotFoundException;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/adm")
public class AdmController {

    private final AdmService admService;

    public AdmController(AdmService admService){
        this.admService = admService;
    }

    @GetMapping("/getAllAdms")
    public List<Adm> getAll(){
        return admService.getAll();
    }

    @GetMapping("/verify/{email}/{password}")
    public ResponseEntity<String> verify(@PathVariable String email, @PathVariable String password) {
        try {
            boolean exists = admService.verify(email, password);
            if (exists) {
                return ResponseEntity.ok().body("Account verified");
            }

            else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
            }
        }

        catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    @PostMapping("/postAdm/{email}/{password}/{salary}")
    public ResponseEntity<String> postAdm(@PathVariable String email, @PathVariable String password, @PathVariable String salary){
        try{
            Double doubleSalary = Double.parseDouble(salary);
            admService.postAdm(email, password, doubleSalary);
            return ResponseEntity.ok().body("Adm inserted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateAdmSalary/{id}/{salary}")
    public ResponseEntity<String> updateAdmSalary(@PathVariable String id, @PathVariable String salary){
        try{
            Integer integerId = Integer.valueOf(id);
            Double doubleSalary = Double.parseDouble(salary);
            admService.updateAdmSalary(integerId, doubleSalary);
            return ResponseEntity.ok().body("Adm updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateAdmPassword/{id}/{password}")
    public ResponseEntity<String> updateAdmPassword(@PathVariable String id, @PathVariable String password){
        try{
            Integer integerId = Integer.valueOf(id);
            admService.updateAdmPassword(integerId, password);
            return ResponseEntity.ok().body("Adm updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @DeleteMapping("/deleteAdm/{id}")
    public ResponseEntity<String> deleteAdm(@PathVariable String id){
        try{
            Integer integerId = Integer.valueOf(id);
            admService.deleteAdm(integerId);
            return ResponseEntity.ok().body("Adm deleted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

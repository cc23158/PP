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

    @GetMapping("/verify/{user}/{password}")
    public ResponseEntity<String> verify(@PathVariable String user, @PathVariable String password) {
        try {
            boolean exists = admService.verify(user, password);
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

    @PostMapping("/postAdm/{user}/{password}")
    public ResponseEntity<String> postAdm(@PathVariable String user, @PathVariable String password){
        try{
            admService.postAdm(user, password);
            return ResponseEntity.ok().body("Adm inserted");
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

    // @GetMapping("/verifyAccount")

}

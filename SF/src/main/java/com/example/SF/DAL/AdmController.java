package com.example.SF.DAL;

import com.example.SF.BLL.AdmService;
import com.example.SF.DTO.Adm;
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
    // http://localhost:8080/adm/getAllAdms
    public List<Adm> getAll(){
        return admService.getAll();
    }

    @GetMapping("/verify/{email}/{password}")
    // http://localhost:8080/adm/verify/adm1@gmail.com/password1
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
    // http://localhost:8080/adm/postAdm/adm3@gmail.com/password3/1250
    public ResponseEntity<String> postAdm(@PathVariable String email, @PathVariable String password, @PathVariable Double salary){
        try{
            admService.postAdm(email, password, salary);
            return ResponseEntity.ok().body("Adm inserted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateAdmSalary/{id}/{salary}")
    // http://localhost:8080/adm/updateAdmSalary/1/5000.0
    public ResponseEntity<String> updateAdmSalary(@PathVariable Integer id, @PathVariable Double salary){
        try{
            admService.updateAdmSalary(id, salary);
            return ResponseEntity.ok().body("Adm updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateAdmPassword/{id}/{password}")
    // http://localhost:8080/adm/updateAdmPassword/1/newPassCode
    public ResponseEntity<String> updateAdmPassword(@PathVariable Integer id, @PathVariable String password){
        try{
            admService.updateAdmPassword(id, password);
            return ResponseEntity.ok().body("Adm updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @DeleteMapping("/deleteAdm/{id}")
    // http://localhost:8080/adm/deleteAdm/1
    public ResponseEntity<String> deleteAdm(@PathVariable Integer id){
        try{
            admService.deleteAdm(id);
            return ResponseEntity.ok().body("Adm deleted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

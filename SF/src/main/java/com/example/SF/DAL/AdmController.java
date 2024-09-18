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

    @CrossOrigin
    @GetMapping("/getAll")
    // http://localhost:8080/adm/getAll
    public List<Adm> getAll(){
        return admService.getAll();
    }

    @CrossOrigin
    @GetMapping("/verify/{email}/{password}")
    // http://localhost:8080/adm/verify/testeA@gmail.com/senhaNova
    public ResponseEntity<String> verify(@PathVariable String email, @PathVariable String password) {
        try {
            boolean exists = admService.verify(email, password);
            if (exists) { return ResponseEntity.ok().body("Account verified"); }

            else { return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials"); }
        }

        catch (Exception e) { return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred"); }
    }

    @CrossOrigin
    @PostMapping("/postAdm/{email}/{password}/{salary}")
    // http://localhost:8080/adm/postAdm/adm1@gmail.com/senha1/1250
    public ResponseEntity<String> postAdm(@PathVariable String email, @PathVariable String password, @PathVariable Double salary){
        try{
            admService.insertAdm(email, password, salary);
            return ResponseEntity.ok().body("Adm inserted");
        }

        catch (Exception e){ return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Adm cannot be inserted"); }
    }

    @CrossOrigin
    @PutMapping("/updateAdmSalary/{id}/{salary}")
    // http://localhost:8080/adm/updateAdmSalary/1/5000.0
    public ResponseEntity<String> updateAdmSalary(@PathVariable Integer id, @PathVariable Double salary){
        try{
            admService.updateAdmSalary(id, salary);
            return ResponseEntity.ok().body("Adm updated");
        }

        catch (Exception e){ return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Adm's salary cannot be changed"); }
    }

    @CrossOrigin
    @PutMapping("/updateAdmPassword/{id}/{password}")
    // http://localhost:8080/adm/updateAdmPassword/1/newPassCode
    public ResponseEntity<String> updateAdmPassword(@PathVariable Integer id, @PathVariable String password){
        try{
            admService.updateAdmPassword(id, password);
            return ResponseEntity.ok().body("Adm updated");
        }

        catch (Exception e){ return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Adm's password cannot be changed"); }
    }

    @CrossOrigin
    @DeleteMapping("/deleteAdm/{id}")
    // http://localhost:8080/adm/deleteAdm/1
    public ResponseEntity<String> deleteAdm(@PathVariable Integer id){
        try{
            admService.deleteAdm(id);
            return ResponseEntity.ok().body("Adm deleted");
        }

        catch (Exception e){ return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Adm cannot be deleted"); }
    }
}

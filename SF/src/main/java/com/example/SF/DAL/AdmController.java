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

    public AdmController(AdmService admService) {
        this.admService = admService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Adm> getAll() {
        try {
            return admService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/verify")
    public ResponseEntity<String> verify(@RequestParam("email") String email, @RequestParam("password") String password) {
        try {
            boolean exists = admService.verify(email, password);
            if (exists) {
                return ResponseEntity.ok("Account verified");
            }

            else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
            }
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot verify adm");
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Adm insert(@RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("salary") Double salary) {
        return admService.insert(email, password, salary);
    }

    @CrossOrigin
    @PutMapping("/updateSalary")
    public ResponseEntity<String> updateSalary(@RequestParam("id") Integer id, @RequestParam("salary") Double salary) {
        try {
            admService.updateSalary(id, salary);
            return ResponseEntity.ok("Adm updated");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Adm's salary cannot be changed");
        }
    }

    @CrossOrigin
    @PutMapping("/updatePassword")
    public ResponseEntity<String> updatePassword(@RequestParam("id") Integer id, @RequestParam("password") String password) {
        try {
            admService.updatePassword(id, password);
            return ResponseEntity.ok("Adm updated");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Adm's password cannot be changed");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            admService.delete(id);
            return ResponseEntity.ok("Adm deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Adm cannot be deleted");
        }
    }
}

package com.example.SF.DAL;

import com.example.SF.BLL.AdmService;
import com.example.SF.DTO.Adm;
import jakarta.persistence.EntityNotFoundException;
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

    @DeleteMapping("/deleteAdm/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id){
        try{
            Integer integerId = Integer.valueOf(id);
            admService.delete(integerId);
            return ResponseEntity.ok("Adm deleted");
        }

        catch(NumberFormatException e){
            return ResponseEntity.badRequest().body("Invalid id");
        }

        catch(EntityNotFoundException e){
            return ResponseEntity.badRequest().body("Adm not founded");
        }

        catch(Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    // @GetMapping("/verifyAccount")

}

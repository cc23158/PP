package com.example.SF.DAL;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.SF.BLL.ClientService;
import com.example.SF.DTO.Client;

@RestController
@RequestMapping("/client")
public class ClientController {
    private final ClientService clientService;

    public ClientController(ClientService clientService){
        this.clientService = clientService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Client> getAll(){
        return clientService.getAll();
    }

    @CrossOrigin
    @GetMapping("/getByName")
    public Client getByName(@RequestParam("name") String name){
        return clientService.getByName(name);
    }

    @CrossOrigin
    @GetMapping("/getByEmail")
    public Client getByEmail(@RequestParam("email") String email){
        Client client = clientService.getByEmail(email);
        if (client != null){
            return client;
        }

        else{
            return null;
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Client insert(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("birthday") String birthday,
            @RequestParam("gender") Character gender,
            @RequestParam("weight") Double weight,
            @RequestParam("password") String password
    ){
        LocalDate dateBirthday = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("dd-MM-yyyy"));
        return clientService.save(name, email, dateBirthday, gender, weight, password);
    }

    @CrossOrigin
    @PutMapping("/updateData")
    public ResponseEntity<String> updateData(@RequestParam("id") Integer id, @RequestParam("weight") Double weight){
        try{
            clientService.updateData(id, weight);
            return ResponseEntity.ok("Client's data changed");
        }

        catch (Exception e){
            return ResponseEntity.badRequest().body("Cannot change client's data");
        }
    }

    @CrossOrigin
    @PutMapping("/updatePassword")
    public ResponseEntity<String> updatePassword(@RequestParam("id") Integer id, @RequestParam("password") String password){
        try{
            clientService.updatePassword(id, password);
            return ResponseEntity.ok("Client's password changed");
        }

        catch (Exception e){
            return ResponseEntity.badRequest().body("Cannot change client's password");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id){
        try{
            clientService.delete(id);
            return ResponseEntity.ok("Client deleted");
        }

        catch (Exception e){
            return ResponseEntity.badRequest().body("Cannot delete client");
        }
    }
}

package com.example.SF.DAL;

import com.example.SF.BLL.ClientService;
import com.example.SF.DTO.Client;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/client")
public class ClientController {

    private final ClientService clientService;

    public ClientController(ClientService clientService){
        this.clientService = clientService;
    }

    @GetMapping("/getAllClients")
    // http://localhost:8080/client/getAllClients
    public List<Client> getAll(){
        return clientService.getAll();
    }

    @GetMapping("/getClientByName/{name}")
    // http://localhost:8080/client/getClientByName/Roberto
    public Client getByName(@PathVariable String name){
        return clientService.getByName(name);
    }

    
    @GetMapping("/getClientByEmail/{email}")
    // http://localhost:8080/client/getClientByEmail/roberto.martins@example.com
    public Client getByEmail(@PathVariable String email){
        return clientService.getByEmail(email);
    }

    @PostMapping("/insertClient/{name}/{email}/{birthday}/{gender}/{weight}/{password}")
    // http://localhost:8080/client/insertClient/Giovane/giovane.lidorio@example.com/15-11-1999/M/83/senha002
    public ResponseEntity<String> insertClient(@PathVariable String name, @PathVariable String email, @PathVariable String birthday, @PathVariable Character gender, @PathVariable Double weight, @PathVariable String password){
        try{
            LocalDate dateBirthday = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("dd-MM-yyyy"));

            clientService.insertClient(name, email, dateBirthday, gender, weight, password);
            return ResponseEntity.ok("Client inserted");
        }

        catch(Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateClientData/{id}/{weight}")
    // http://localhost:8080/client/updateClientData/18/84
    public ResponseEntity<String> updateClientData(@PathVariable Integer id, @PathVariable Double weight){
        try{
            clientService.updateClientData(id, weight);
            return ResponseEntity.ok().body("Client updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error ocurred");
        }
    }

    @PutMapping("/updateClientPassword/{id}/{password}")
    // http://localhost:8080/client/updateClientPassword/18/passCode
    public ResponseEntity<String> updateClientPassword(@PathVariable Integer id, @PathVariable String password){
        try{
            clientService.updateClientPassword(id, password);
            return ResponseEntity.ok().body("Client updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @DeleteMapping("/deleteClient/{id}")
    // http://localhost:8080/client/deleteClient/17
    public ResponseEntity<String> deleteClient(@PathVariable Integer id){
        try{
            clientService.deleteClient(id);
            return ResponseEntity.ok("Client deleted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

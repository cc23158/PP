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

    @CrossOrigin
    @GetMapping("/getAll")
    // http://localhost:8080/client/getAll
    public List<Client> getAll(){
        return clientService.getAll();
    }

    @CrossOrigin
    @GetMapping("/getByName/{name}")
    // http://localhost:8080/client/getClientByName/Teste A
    public Client getByName(@PathVariable String name){
        return clientService.getByName(name);
    }

    @CrossOrigin
    @GetMapping("/getByEmail/{email}")
    // http://localhost:8080/client/getClientByEmail/testeA@gmail.com
    public Client getByEmail(@PathVariable String email){
        Client client = clientService.getByEmail(email);
        if (client != null){ return client; }

        else { return null; }
    }

    @CrossOrigin
    @PostMapping("/insert/{name}/{email}/{birthday}/{gender}/{weight}/{password}")
    // http://localhost:8080/client/insertClient/Lucas/lucas@gmail.com/2010-10-10/M/70/lucas123
    public ResponseEntity<String> insertClient(@PathVariable String name, @PathVariable String email, @PathVariable String birthday, @PathVariable Character gender, @PathVariable Double weight, @PathVariable String password){
        try{
            LocalDate dateBirthday = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            clientService.insertClient(name, email, dateBirthday, gender, weight, password);
            return ResponseEntity.ok("Client inserted");
        }

        catch(Exception e){ return ResponseEntity.badRequest().body("Client cannot be inserted"); }
    }

    @CrossOrigin
    @PutMapping("/updateClientData/{id}/{weight}")
    // http://localhost:8080/client/updateClientData/1/80
    public ResponseEntity<String> updateClientData(@PathVariable Integer id, @PathVariable Double weight){
        try{
            clientService.updateClientData(id, weight);
            return ResponseEntity.ok().body("Client updated");
        }

        catch (Exception e){ return ResponseEntity.badRequest().body("Client's data cannot be changed"); }
    }

    @CrossOrigin
    @PutMapping("/updateClientPassword/{id}/{password}")
    // http://localhost:8080/client/updateClientPassword/6/lucas312
    public ResponseEntity<String> updateClientPassword(@PathVariable Integer id, @PathVariable String password){
        try{
            clientService.updateClientPassword(id, password);
            return ResponseEntity.ok().body("Client updated");
        }

        catch (Exception e){ return ResponseEntity.badRequest().body("Client's password cannot be changed"); }
    }

    @CrossOrigin
    @DeleteMapping("/delete/{id}")
    // http://localhost:8080/client/deleteClient/6
    public ResponseEntity<String> deleteClient(@PathVariable Integer id){
        try{
            clientService.deleteClient(id);
            return ResponseEntity.ok("Client deleted");
        }

        catch (Exception e){ return ResponseEntity.badRequest().body("Client cannot be deleted"); }
    }
}

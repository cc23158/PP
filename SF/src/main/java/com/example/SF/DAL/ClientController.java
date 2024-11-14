package com.example.SF.DAL;

import com.example.SF.BLL.ClientService;
import com.example.SF.DTO.Client;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/client")
public class ClientController {
    private final ClientService clientService;

    public ClientController(ClientService clientService) {
        this.clientService = clientService;
    }

    @CrossOrigin
    @GetMapping("/getAll")
    public List<Client> getAll() {
        try {
            return clientService.getAll();
        }

        catch (Exception e) {
            return List.of();
        }
    }

    @CrossOrigin
    @GetMapping("/getById")
    public Client getById(@RequestParam("clientId") Integer clientId) {
        try {
            return clientService.getById(clientId);
        }

        catch (Exception e) {
            return null;
        }
    }

    @CrossOrigin
    @GetMapping("/getByName")
    public Client getByName(@RequestParam("name") String name) {
        try {
            return clientService.getByName(name);
        }

        catch (Exception e) {
            return null;
        }
    }

    @CrossOrigin
    @GetMapping("/getByEmail")
    public Client getByEmail(@RequestParam("email") String email) {
        try {
            Client client = clientService.getByEmail(email);
            if (client != null) {
                return client;
            }

            else {
                return null;
            }
        }

        catch (Exception e) {
            return null;
        }
    }

    @CrossOrigin
    @PostMapping("/insert")
    public Integer insert(@RequestParam("name") String name, @RequestParam("email") String email, @RequestParam("birthday") String birthday, @RequestParam("gender") Character gender, @RequestParam("weight") Double weight, @RequestParam("password") String password) {
        LocalDate dateBirthday = LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        Client client = clientService.insert(name, email, dateBirthday, gender, weight, password);
        return client.getClient_id();
    }

    @CrossOrigin
    @PutMapping("/updateData")
    public ResponseEntity<String> updateData(@RequestParam("id") Integer id, @RequestParam("weight") Double weight) {
        try {
            clientService.updateData(id, weight);
            return ResponseEntity.ok("Client's data changed");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot change client's data");
        }
    }

    @CrossOrigin
    @PutMapping("/updatePassword")
    public ResponseEntity<String> updatePassword(@RequestParam("id") Integer id, @RequestParam("password") String password) {
        try {
            clientService.updatePassword(id, password);
            return ResponseEntity.ok("Client's password changed");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot change client's password");
        }
    }

    @CrossOrigin
    @DeleteMapping("/delete")
    public ResponseEntity<String> delete(@RequestParam("id") Integer id) {
        try {
            clientService.delete(id);
            return ResponseEntity.ok("Client deleted");
        }

        catch (Exception e) {
            return ResponseEntity.badRequest().body("Cannot delete client");
        }
    }
}

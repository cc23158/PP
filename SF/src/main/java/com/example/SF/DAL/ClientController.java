package com.example.SF.DAL;

import com.example.SF.BLL.ClientService;
import com.example.SF.DTO.Client;
import jakarta.persistence.Convert;
import jakarta.persistence.EntityNotFoundException;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/client")
public class ClientController {

    private final ClientService clientService;

    public ClientController(ClientService clientService){
        this.clientService = clientService;
    }

    @GetMapping("/getAllClients")
    public List<Client> getAll(){
        return clientService.getAll();
    }

    @GetMapping("/getClientByName/{name}/{surname}")
    // ex: http://localhost:8080/client/getClientByName/Alice/Johnson
    public Client getByName(@PathVariable String name, @PathVariable String surname){
        return clientService.getByName(name, surname);
    }

    @DeleteMapping("/deleteClient/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id){
        try{
            Integer integerId = Integer.valueOf(id);
            clientService.delete(integerId);
            return ResponseEntity.ok("Client deleted");
        }

        catch(NumberFormatException e){
            return ResponseEntity.badRequest().body("Invalid id");
        }

        catch(EntityNotFoundException e){
            return ResponseEntity.badRequest().body("Client not founded");
        }

        catch(Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

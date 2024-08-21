package com.example.SF.DAL;

import com.example.SF.BLL.ClientService;
import com.example.SF.DTO.Client;
import jakarta.persistence.Convert;
import jakarta.persistence.EntityNotFoundException;
import org.apache.catalina.connector.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
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

    @PostMapping("/postClient/{name}/{surname}/{age}/{birthday}/{gender}/{height}/{weight}/{password}")
    public ResponseEntity<String> postClient(
            @PathVariable String name,
            @PathVariable String surname,
            @PathVariable String age,
            @PathVariable String birthday,
            @PathVariable Character gender,
            @PathVariable String height,
            @PathVariable String weight,
            @PathVariable String password
            ){
        try{
            Integer integerAge = Integer.valueOf(age);
            Date dateBirthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthday);
            Double doubleHeight = Double.parseDouble(height);
            Double doubleWeight = Double.parseDouble(weight);

            clientService.postClient(name, surname, integerAge, dateBirthday, gender, doubleHeight, doubleWeight, password);
            return ResponseEntity.ok("Client inserted");
        }

        catch(Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @PutMapping("/updateClientData/{id}/{age}/{height}/{weight}")
    public ResponseEntity<String> updateClientData(
            @PathVariable String id,
            @PathVariable String age,
            @PathVariable String height,
            @PathVariable String weight
    ){
        try{
            Integer integerId = Integer.valueOf(id);
            Integer integerAge = Integer.valueOf(age);
            Double doubleHeight = Double.parseDouble(height);
            Double doubleWeight = Double.parseDouble(weight);
            clientService.updateClientData(integerId, integerAge, doubleHeight, doubleWeight);
            return ResponseEntity.ok().body("Client updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error ocurred");
        }
    }

    @PutMapping("/updateClientPassword/{id}/{password}")
    public ResponseEntity<String> updateClientPassword(@PathVariable String id, @PathVariable String password){
        try{
            Integer integerId = Integer.valueOf(id);
            clientService.updateClientPassword(integerId, password);
            return ResponseEntity.ok().body("Client updated");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

    @DeleteMapping("/deleteClient/{id}")
    public ResponseEntity<String> deleteClient(@PathVariable String id){
        try{
            Integer integerId = Integer.valueOf(id);
            clientService.deleteClient(integerId);
            return ResponseEntity.ok("Client deleted");
        }

        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occured");
        }
    }

}

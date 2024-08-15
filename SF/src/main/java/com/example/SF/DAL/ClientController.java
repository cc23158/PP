package com.example.SF.DAL;

import com.example.SF.BLL.ClientService;
import com.example.SF.DTO.Client;
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

    @GetMapping("/getClientByName")
    public Client getByName(@PathVariable String name){
        return clientService.getByName(name);
    }

}

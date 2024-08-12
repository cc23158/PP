package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.Repository.IClient;
import jdk.jshell.spi.ExecutionControl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpServerErrorException;

import java.util.List;

@Service
public class ClientService {

    private final IClient iClient;

    @Autowired
    public ClientService(IClient iClient){
        this.iClient = iClient;
    }

    public List<Client> getAll(){
        return iClient.findAll();
    }

    public Client save(Client client){
        return iClient.save(client);
    }

    /* Customizes methods */
    /*
    public Client getByName(String name){

    }

    public Client delete(String username){

    }

    */
}

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

    public Client getByName(String name){
        return iClient.getByName(name);
    }

    /* Customizes methods */
    /*

    public Client delete(String username){

    }

    */

}

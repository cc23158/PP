package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.Repository.IClient;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
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

    public void delete(Integer id) {
        if(iClient.existsById(id)){
            iClient.deleteById(id);
        }

        else{
            throw new EntityNotFoundException("Client not founded");
        }
    }

    @Transactional
    public Client getByName(String name, String surname){
        return iClient.getByName(name, surname);
    }

    /* Customizes methods */
    /*

    public Client delete(String username){

    }

    */

}

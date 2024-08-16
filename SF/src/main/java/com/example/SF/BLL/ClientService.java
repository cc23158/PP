package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.Repository.IClient;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import jdk.jshell.spi.ExecutionControl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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

    @Transactional
    public Client getByName(String name, String surname){
        return iClient.getByName(name, surname);
    }

    @Transactional
    public void postClient(
            String name,
            String surname,
            Integer age,
            Character gender,
            Double height,
            Double weight,
            String password
    ) throws Exception {
        try{
            iClient.postClient(name, surname, age, gender, height, weight, password);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void deleteClient(Integer id){
        iClient.deleteClient(id);
    }

}

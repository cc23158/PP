package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.Repository.IClient;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
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

    @Transactional
    public Client getByName(String name){
        return iClient.getByName(name);
    }

    @Transactional
    public void postClient(
            String name,
            String email,
            LocalDate birthday,
            Character gender,
            Double weight,
            String password
    ) throws Exception {
        try{
            iClient.postClient(name, email, birthday, gender, weight, password);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void updateClientData(
            Integer id,
            Double weight
    ) throws Exception{
        try{
            iClient.updateClientData(id, weight);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void updateClientPassword(Integer id, String password) throws Exception{
        try {
            iClient.updateClientPassword(id, password);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void deleteClient(Integer id){
        iClient.deleteClient(id);
    }

    @Transactional
    public Client getByEmail(String email) {
        return iClient.getByEmail(email);
    }

}

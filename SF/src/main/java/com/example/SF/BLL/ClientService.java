package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.Repository.IClient;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
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
        try{
            return  iClient.findAll();
        }

        catch (Exception e){
            System.out.println("Cannot get clients: " + e.getMessage());
            return List.of();
        }
    }

    public Client save(String name, String email, LocalDate birthday, Character gender, Double weight, String password){
        try{
            Client client = new Client();
            client.setClient_name(name);
            client.setClient_email(email);
            client.setClient_birthday(birthday);
            client.setClient_gender(gender);
            client.setClient_weight(weight);
            client.setClient_password(password);
            client.setClient_active(true);

            return iClient.save(client);
        }

        catch (DataIntegrityViolationException e){
            System.out.println("Email already exists");
            return null;
        }

        catch (Exception e){
            System.out.println("Cannot insert client: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public Client getByName(String name){
        try{
            return iClient.getByName(name);
        }

        catch (Exception e) {
            System.out.println("Cannot get client: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public Client getByEmail(String email){
        try{
            return iClient.getByEmail(email);
        }

        catch (Exception e) {
            System.out.println("Cannot get client: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void updateData(Integer id, Double weight){
        try{
            iClient.updateData(id, weight);
        }

        catch (Exception e){
            System.out.println("Cannot change client's data: " + e.getMessage());
        }
    }

    @Transactional
    public void updatePassword(Integer id, String password){
        try{
            iClient.updatePassword(id, password);
        }

        catch (Exception e){
            System.out.println("Cannot change client's password: " + e.getMessage());
        }
    }

    @Transactional
    public void delete(Integer id) {
        try {
            iClient.delete(id);
        }

        catch (Exception e){
            System.out.println("Cannot delete client: " + e.getMessage());
        }
    }
}

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
            System.out.println("Não foi possível pegar os dados dos clientes: " + e.getMessage());
            return List.of();
        }
    }

    @Transactional
    public Client getByName(String name){
        try{
            return iClient.getByName(name);
        }

        catch (Exception e) {
            System.out.println("Não foi possível pegar os dados do cliente: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public Client getByEmail(String email){
        try{
            return iClient.getByEmail(email);
        }

        catch (Exception e) {
            System.out.println("Não foi possível pegar os dados do cliente: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void insertClient(String name, String email, LocalDate birthday, Character gender, Double weight, String password){
        try{
            iClient.insertClient(name, email, birthday, gender, weight, password);
        }

        catch (DataIntegrityViolationException e){
            System.out.println("Erro: O email já está cadastrado");
        }

        catch (Exception e){
            System.out.println("Erro ao inserir cliente: " + e.getMessage());
        }
    }

    @Transactional
    public void updateClientData(Integer id, Double weight){
        try{
            iClient.updateClientData(id, weight);
        }

        catch (Exception e){
            System.out.println("Erro ao atualizar dados do cliente: " + e.getMessage());
        }
    }

    @Transactional
    public void updateClientPassword(Integer id, String password){
        try{
            iClient.updateClientPassword(id, password);
        }

        catch (Exception e){
            System.out.println("Erro ao atualizar dados do cliente: " + e.getMessage());
        }
    }

    @Transactional
    public void deleteClient(Integer id) {
        try {
            iClient.deleteClient(id);
        }

        catch (Exception e){
            System.out.println("Erro ao deletar cliente: " + e.getMessage());
        }
    }
}

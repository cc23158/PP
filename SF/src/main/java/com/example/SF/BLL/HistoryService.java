package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.History;
import com.example.SF.DTO.Recipe;
import com.example.SF.Repository.IHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
public class HistoryService {
    private final IHistory iHistory;
    private final ClientService clientService;
    private final RecipeService recipeService;

    @Autowired
    public HistoryService(IHistory iHistory, ClientService clientService, RecipeService recipeService){
        this.iHistory = iHistory;
        this.clientService = clientService;
        this.recipeService = recipeService;
    }

    public List<History> getAll(){
        try{
            return iHistory.findAll();
        }

        catch (Exception e){
            System.out.println();
            return List.of();
        }
    }

    public List<History> getByClient(Integer clientId){
        try{
            return iHistory.getByClient(clientId);
        }

        catch (Exception e){
            System.out.println("Cannot get histories for client: " + clientId);
            return List.of();
        }
    }

    public History insert(Integer clientId, Integer recipeId, LocalTime time){
        if (clientId == null || recipeId == null || time == null){
            System.out.println("ClientId, recipeId and time must not be empty");
            return null;
        }

        try{
            History history = new History();
            Client client = clientService.getById(clientId);
            Recipe recipe = recipeService.getById(recipeId);

            if (client == null || recipe == null){
                System.out.println("Client or Recipe not found for ID: " + clientId + " or " + recipeId);
                return null;
            }

            history.setHistory_client(client);
            history.setHistory_recipe(recipe);
            history.setHistory_date(LocalDate.now());
            history.setHistory_time(time);

            return iHistory.save(history);
        }

        catch (Exception e){
            System.out.println("Cannot insert history: " + e.getMessage());
            return null;
        }
    }

    public void delete(Integer id){
        try{
            iHistory.deleteById(id);
        }

        catch (Exception e){
            System.out.println("Cannot delete history: " + e.getMessage());
        }
    }
}

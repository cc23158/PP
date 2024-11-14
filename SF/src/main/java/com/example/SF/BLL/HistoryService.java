package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.Exercise;
import com.example.SF.DTO.History;
import com.example.SF.DTO.Recipe;
import com.example.SF.Repository.IHistory;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
public class HistoryService {
    private final IHistory iHistory;
    private final ClientService clientService;
    private final ExerciseService exerciseService;

    @Autowired
    public HistoryService(IHistory iHistory, ClientService clientService, ExerciseService exerciseService) {
        this.iHistory = iHistory;
        this.clientService = clientService;
        this.exerciseService = exerciseService;
    }

    public List<History> getAll() {
        try {
            return iHistory.findAll();
        }

        catch (Exception e) {
            System.out.println("Cannot find histories" + e.getMessage());
            return List.of();
        }
    }

    public List<History> getByClientNoDate(Integer clientId) {
        try {
            return iHistory.getByClientNoDate(clientId);
        }

        catch (Exception e) {
            System.out.println("Cannot find history of client by ID: " + clientId);
            return List.of();
        }
    }

    public List<History> getByClient(Integer clientId, LocalDate date) {
        try {
            return iHistory.getByClient(clientId, date);
        }

        catch (Exception e) {
            System.out.println("Cannot find history of client by ID: " + clientId);
            return List.of();
        }
    }

    @Transactional
    public void insert(Integer clientId, List<Recipe> recipes) {
        if (clientId == null || recipes.isEmpty()) {
            System.out.println("ClientId and exercise's list must be not null");
            return;
        }

        try {
            Client client = clientService.getById(clientId);
            if (client == null) {
                System.out.println("Cannot find client by ID: " + clientId);
                return;
            }

            for (Recipe recipe : recipes) {
                if (recipe != null) {
                    History history = new History();
                    history.setHistory_client(client);
                    history.setHistory_exercise(recipe.getRecipe_exercise());
                    history.setHistory_date(LocalDate.now());
                    history.setHistory_weight(recipe.getRecipe_weight());
                    history.setHistory_reps(recipe.getRecipe_reps());
                    history.setHistory_sets(recipe.getRecipe_sets());
                    iHistory.save(history);
                }
            }
        }

        catch (Exception e) {
            System.out.println("Cannot insert histories: " + e.getMessage());
            return;
        }
    }

    @Transactional
    public void delete(Integer id) {
        try {
            iHistory.deleteById(id);
        }

        catch (Exception e) {
            System.out.println("Cannot delete history: " + e.getMessage());
        }
    }
}

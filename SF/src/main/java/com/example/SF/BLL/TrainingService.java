package com.example.SF.BLL;

import com.example.SF.DTO.Client;
import com.example.SF.DTO.Training;
import com.example.SF.Repository.IClient;
import com.example.SF.Repository.ITraining;
import io.micrometer.common.util.StringUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainingService {
    private final ITraining iTraining;
    private final ClientService clientService;

    @Autowired
    public TrainingService(ITraining iTraining, ClientService clientService) {
        this.iTraining = iTraining;
        this.clientService = clientService;
    }

    public List<Training> getAll() {
        try {
            return iTraining.getAllOrder();
        }

        catch (Exception e) {
            System.out.println("Cannot get trainings: " + e.getMessage());
            return List.of();
        }
    }

    public Training getById(Integer id) {
        return iTraining.findById(id).orElse(null);
    }

    public List<Training> getByClient(Integer clientId) {
        try {
            return iTraining.getByClient(clientId);
        }

        catch (Exception e) {
            System.out.println("Cannot find trainings by client ID: " + clientId);
            return List.of();
        }
    }

    public List<Training> getByCategory(Integer clientId, Integer category) {
        try {
            return iTraining.getByCategory(clientId, category);
        }

        catch (Exception e) {
            System.out.println("Cannot find trainings by client ID: " + clientId + " and category ID: " + category);
            return List.of();
        }
    }

    @Transactional
    public Training insert(String name, Integer category, Integer clientId) {
        if (StringUtils.isEmpty(name) || category == null || clientId == null) {
            System.out.println("Name, category and clientId must not be empty");
            return null;
        }

        try {
            Training training = new Training();
            training.setTraining_name(name);
            training.setTraining_category(category);

            Client client = clientService.getById(clientId);
            if (client == null) {
                System.out.println("Client not found for ID: " + clientId);
                return null;
            }

            training.setTraining_client(client);
            return iTraining.save(training);
        }

        catch (Exception e) {
            System.out.println("Cannot insert training: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void update(Integer id, String name) {
        try {
            iTraining.update(id, name);
        }

        catch (Exception e) {
            System.out.println("Cannot change training's name: " + e.getMessage());
        }
    }

    @Transactional
    public void delete(Integer id) {
        try {
            iTraining.delete(id);
        }

        catch (Exception e) {
            System.out.println("Cannot delete training: " + e.getMessage());
        }
    }
}

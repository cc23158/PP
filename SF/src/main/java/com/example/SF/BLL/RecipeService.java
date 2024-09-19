package com.example.SF.BLL;

import com.example.SF.DTO.Recipe;
import com.example.SF.Repository.IRecipe;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecipeService {
    private final IRecipe iRecipe;

    @Autowired
    public RecipeService(IRecipe iRecipe){
        this.iRecipe = iRecipe;
    }

    public List<Recipe> getAll(){
        return iRecipe.findAll();
    }

    @Transactional
    public void insertRecipe(Integer clientId, Integer exerciseId, Double weight) throws Exception{
        try { iRecipe.insertRecipe(clientId, exerciseId, weight); }

        catch (Exception e) { throw new Exception(e); }
    }

    @Transactional
    public void updateRecipe(Integer id, Double weight) throws Exception{
        try { iRecipe.updateRecipe(id, weight); }

        catch (Exception e){ throw new Exception(e); }
    }
}

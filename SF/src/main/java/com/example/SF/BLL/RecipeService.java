package com.example.SF.BLL;

import com.example.SF.DTO.Recipe;
import com.example.SF.Repository.IRecipe;
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

}

package com.example.SF.BLL;

import com.example.SF.DTO.Exercise;
import com.example.SF.Repository.IExercise;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExerciseService {

    private final IExercise iExercise;

    @Autowired
    public ExerciseService(IExercise iExercise){
        this.iExercise = iExercise;
    }

    public List<Exercise> getAll(){
        return iExercise.findAll();
    }

    @Transactional
    public List<Exercise> getExercise(Integer muscleId){
        return iExercise.getExercise(muscleId);
    }

    @Transactional
    public void postExercise(String name, String path, Integer muscleId) throws Exception{
        try{
            iExercise.postExercise(name, path, muscleId);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void updateExercise(Integer id, String path) throws Exception{
        try{
            iExercise.updateExercise(id, path);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void deleteExercise(Integer id){
        iExercise.deleteExercise(id);
    }

}

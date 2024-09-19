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
    public void insertExercise(String name, byte[] image, String path, Integer muscleId) throws Exception{
        try{ iExercise.insertExercise(name, image, path, muscleId); }

        catch (Exception e){ throw new Exception(e); }
    }

    @Transactional
    public void updateExerciseImage(Integer id, byte[] image) throws Exception{
        try { iExercise.updateExerciseImage(id, image); }

        catch (Exception e){ throw new Exception(e); }
    }

    @Transactional
    public void updateExercisePath(Integer id, String path) throws Exception{
        try { iExercise.updateExercisePath(id, path); }

        catch (Exception e) { throw new Exception(e); }
    }

    @Transactional
    public void deleteExercise(Integer id) throws Exception{
        try { iExercise.deleteExercise(id); }

        catch (Exception e) { throw new Exception(e); }
    }
}

package com.example.SF.BLL;

import com.example.SF.DTO.Muscle;
import com.example.SF.Repository.IMuscle;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MuscleService {

    private final IMuscle iMuscle;

    @Autowired
    public MuscleService(IMuscle iMuscle){
        this.iMuscle = iMuscle;
    }

    public List<Muscle> getAll(){
        return iMuscle.findAll();
    }

    @Transactional
    public void postMuscle(String name) throws Exception{
        try{
            iMuscle.postMuscle(name);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

}

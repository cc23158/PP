package com.example.SF.BLL;

import com.example.SF.DTO.Muscle;
import com.example.SF.Repository.IMuscle;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MuscleService {
    private IMuscle iMuscle;

    @Autowired
    public MuscleService(IMuscle iMuscle){
        this.iMuscle = iMuscle;
    }

    public List<Muscle> getAll(){
        return iMuscle.findAll();
    }

    @Transactional
    public void insertMuscle(String name) throws Exception{
        try{ iMuscle.insertMuscle(name); }

        catch (Exception e) { throw new Exception(e); }
    }
}

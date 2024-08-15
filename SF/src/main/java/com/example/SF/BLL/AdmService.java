package com.example.SF.BLL;

import com.example.SF.DTO.Adm;
import com.example.SF.Repository.IAdm;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdmService {

    private final IAdm iAdm;

    @Autowired
    public AdmService(IAdm iAdm){
        this.iAdm = iAdm;
    }

    public List<Adm> getAll(){
        return iAdm.findAll();
    }

    public Adm save(Adm adm){
        return iAdm.save(adm);
    }

    public void delete(Integer id){
        if(iAdm.existsById(id)){
            iAdm.deleteById(id);
        }

        else{
            throw new EntityNotFoundException("Adm not founded");
        }
    }

    /* Customizes methods */
    /*
    public Adm verifyAccount(String username, String password){

    }

    public Adm delete(String username){

    }

    */

}

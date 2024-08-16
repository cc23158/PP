package com.example.SF.BLL;

import com.example.SF.DTO.Adm;
import com.example.SF.Repository.IAdm;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
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

    @Transactional
    public boolean verify(String user, String password){
        return iAdm.verify(user, password);
    }

    @Transactional
    public void postAdm(String user, String password){
        iAdm.postAdm(user, password);
    }

    @Transactional
    public void deleteAdm(Integer id){
        iAdm.deleteAdm(id);
    }

}

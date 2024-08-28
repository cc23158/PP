package com.example.SF.BLL;

import com.example.SF.DTO.Adm;
import com.example.SF.Repository.IAdm;
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

    @Transactional
    public boolean verify(String email, String password){
        return iAdm.verify(email, password);
    }

    @Transactional
    public void postAdm(String email, String password, Double salary) throws Exception{
        try {
            iAdm.postAdm(email, password, salary);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void updateAdmSalary(Integer id, Double salary) throws Exception{
        try{
            iAdm.updateAdmSalary(id, salary);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }
    
    @Transactional
    public void updateAdmPassword(Integer id, String password) throws Exception{
        try{
            iAdm.updateAdmPassword(id, password);
        }

        catch (Exception e){
            throw new Exception(e);
        }
    }

    @Transactional
    public void deleteAdm(Integer id){
        iAdm.deleteAdm(id);
    }

}

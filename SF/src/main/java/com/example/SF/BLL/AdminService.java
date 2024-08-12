package com.example.SF.BLL;

import com.example.SF.DTO.Admin;
import com.example.SF.Repository.IAdmin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    private final IAdmin iAdmin;

    @Autowired
    public AdminService(IAdmin iAdmin){
        this.iAdmin = iAdmin;
    }

    public List<Admin> getAll(){
        return iAdmin.findAll();
    }

    public Admin save(Admin admin){
        return iAdmin.save(admin);
    }

    /* Customizes methods */
    /*
    public Admin verifyAccount(String username, String password){

    }

    public Admin delete(String username){

    }

    */

}

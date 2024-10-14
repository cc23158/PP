package com.example.SF.BLL;

import com.example.SF.DTO.Adm;
import com.example.SF.Repository.IAdm;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdmService {
    private final IAdm iAdm;

    @Autowired
    public AdmService(IAdm iAdm) {
        this.iAdm = iAdm;
    }

    public List<Adm> getAll() {
        try {
            return iAdm.getAllOrder();
        }

        catch (Exception e) {
            System.out.println("Cannot get adms: " + e.getMessage());
            return List.of();
        }
    }

    public boolean verify(String email, String password) {
        try {
            return iAdm.verify(email, password);
        }

        catch (Exception e) {
            System.out.println("Cannot verify adm: " + e.getMessage());
            return false;
        }
    }

    @Transactional
    public Adm insert(String email, String password, Double salary) {
        try {
            Adm adm = new Adm();
            adm.setAdm_email(email);
            adm.setAdm_password(password);
            adm.setAdm_salary(salary);
            adm.setAdm_active(true);

            return iAdm.save(adm);
        }

        catch (DataIntegrityViolationException e) {
            System.out.println("Email already exists");
            return null;
        }

        catch (Exception e) {
            System.out.println("Cannot insert adm: " + e.getMessage());
            return null;
        }
    }

    @Transactional
    public void updateSalary(Integer id, Double salary) {
        try {
            iAdm.updateSalary(id, salary);
        }

        catch (Exception e) {
            System.out.println("Cannot change adm's salary: " + e.getMessage());
        }
    }

    @Transactional
    public void updatePassword(Integer id, String password) {
        try {
            iAdm.updatePassword(id, password);
        }

        catch (Exception e) {
            System.out.println("Cannot change adm's password: " + e.getMessage());
        }
    }

    @Transactional
    public void delete(Integer id) {
        try {
            iAdm.delete(id);
        }

        catch (Exception e) {
            System.out.println("Cannot delete adm: " + e.getMessage());
        }
    }
}

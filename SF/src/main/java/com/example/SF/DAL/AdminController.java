package com.example.SF.DAL;

import com.example.SF.BLL.AdminService;
import com.example.SF.DTO.Admin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService){
        this.adminService = adminService;
    }

    @GetMapping("/getAllAdmins")
    public List<Admin> getAll(){
        return adminService.getAll();
    }



    // @GetMapping("/verifyAccount")

}

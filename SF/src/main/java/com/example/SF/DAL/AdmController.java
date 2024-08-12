package com.example.SF.DAL;

import com.example.SF.BLL.AdmService;
import com.example.SF.DTO.Adm;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/adm")
public class AdmController {

    private final AdmService admService;

    public AdmController(AdmService admService){
        this.admService = admService;
    }

    @GetMapping("/getAllAdms")
    public List<Adm> getAll(){
        return admService.getAll();
    }



    // @GetMapping("/verifyAccount")

}

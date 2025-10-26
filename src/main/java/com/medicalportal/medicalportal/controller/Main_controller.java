package com.medicalportal.medicalportal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Main_controller {
    
    @GetMapping({"/", "/home"})
    public String home() {
        return "home";
    }
    
    @GetMapping("/laboratory-services")
    public String laboratoryServices() {
        return "LabTech_Pharmacist/laboratory-services";
    }
    
    @GetMapping("/pharmacy-home")
    public String pharmacyHome() {
        return "LabTech_Pharmacist/pharmacy-home";
    }
}
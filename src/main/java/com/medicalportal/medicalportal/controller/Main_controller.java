package com.medicalportal.medicalportal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Main_controller {
    @GetMapping({"/", "/home"})
    public String home() {
        return "home"; // Maps to index.jsp
    }
    @GetMapping("/laboratory-services")
    public String laboratoryServices() {
        return "laboratory-services"; //
    }
    @GetMapping("/pharmacy-home")
    public String pharmacyHome() {
        return "pharmacy-home";
    }
    @GetMapping("/pharmacist-dashboard")
    public String pharmacyDashboard() {
        return "pharmacist-dashboard";
    }

    @GetMapping("/labtechnician-dashboard")
    public String labTechnicianDashboard() {
        return "lab-technician-dashboard";
    }

}
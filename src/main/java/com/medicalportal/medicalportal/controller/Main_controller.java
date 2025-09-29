package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Employee;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
public class Main_controller {
    
    @GetMapping({"/", "/home"})
    public String home() {
        return "home"; // Maps to home.jsp
    }
    
    @GetMapping("/laboratory-services")
    public String laboratoryServices() {
        return "laboratory-services";
    }
    
    @GetMapping("/pharmacy-home")
    public String pharmacyHome() {
        return "pharmacy-home";
    }
    
    // Authentication route redirects
    @GetMapping("/login")
    public String defaultLogin() {
        return "redirect:/auth/login?role=pharmacist";
    }
    
    @GetMapping("/register")
    public String defaultRegister() {
        return "redirect:/auth/register?role=pharmacist";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        String employeeName = (String) session.getAttribute("employeeName");
        
        // Clear session
        session.invalidate();
        
        redirectAttributes.addFlashAttribute("successMessage", 
            "You have been successfully logged out. Thank you for using Medisphere!");
        return "redirect:/";
    }
    
    // Dashboard routes with session protection
    @GetMapping("/pharmacist-dashboard")
    public String pharmacyDashboard(HttpSession session, RedirectAttributes redirectAttributes) {
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        String role = (String) session.getAttribute("employeeRole");
        
        if (employee == null) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Please log in to access the pharmacist dashboard.");
            return "redirect:/auth/login?role=pharmacist";
        }
        
        if (!"pharmacist".equalsIgnoreCase(role)) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Access denied. You need pharmacist privileges to access this page.");
            return "redirect:/auth/login?role=pharmacist";
        }
        
        return "redirect:/pharmacist";
    }

    @GetMapping("/labtechnician-dashboard")
    public String labTechnicianDashboard(HttpSession session, RedirectAttributes redirectAttributes) {
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        String role = (String) session.getAttribute("employeeRole");
        
        if (employee == null) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Please log in to access the lab technician dashboard.");
            return "redirect:/auth/login?role=lab-technician";
        }
        
        if (!"lab-technician".equalsIgnoreCase(role)) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Access denied. You need lab technician privileges to access this page.");
            return "redirect:/auth/login?role=lab-technician";
        }
        
        return "redirect:/lab-technician";
    }
    
    // Quick login routes for convenience
    @GetMapping("/pharmacist-login")
    public String pharmacistLogin() {
        return "redirect:/auth/login?role=pharmacist";
    }
    
    @GetMapping("/lab-technician-login")
    public String labTechnicianLogin() {
        return "redirect:/auth/login?role=lab-technician";
    }
    
    @GetMapping("/pharmacist-register")
    public String pharmacistRegister() {
        return "redirect:/auth/register?role=pharmacist";
    }
    
    @GetMapping("/lab-technician-register")
    public String labTechnicianRegister() {
        return "redirect:/auth/register?role=lab-technician";
    }
}
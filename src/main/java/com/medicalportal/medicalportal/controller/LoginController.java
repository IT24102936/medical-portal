package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient;
import com.medicalportal.medicalportal.service.PatientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private PatientService patientService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "PatientLogin";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        HttpSession session, Model model) {
        Patient patient = patientService.authenticate(username, password);
        if (patient != null) {
            session.setAttribute("loggedInPatient", patient);
            return "redirect:/patient/dashboard";
        } else {
            model.addAttribute("error", "Invalid Email or Password");
            return "PatientLogin";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
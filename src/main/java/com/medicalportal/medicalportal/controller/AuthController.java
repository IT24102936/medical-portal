
package com.medicalportal.medicalportal.controller;


import com.medicalportal.medicalportal.repository.DoctorRepository;
import jakarta.validation.Valid;
import jakarta.servlet.http.HttpSession;
import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Optional;


@Controller
public class AuthController {

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, Model model) {
        try {
            Optional<Doctor> doctorOpt = doctorService.getDoctorByUsername(username);

            if (doctorOpt.isPresent()) {
                Doctor doctor = doctorOpt.get();
                if (passwordEncoder.matches(password, doctor.getPassword())) {
                    session.setAttribute("doctor", doctor);
                    System.out.println("DEBUG: Doctor set in session: " + doctor.getUsername());
                    return "redirect:/doctor/" + doctor.getId() + "/dashboard";
                }
            }

            model.addAttribute("error", "Invalid username or password");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Login failed: " + e.getMessage());
            return "login";
        }
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("doctor", new Doctor());
        return "registration";
    }

    @PostMapping("/register")
    public String register(
            @Valid @ModelAttribute("doctor") Doctor doctor,
            BindingResult result,
            @RequestParam("confirmPassword") String confirmPassword,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            model.addAttribute("doctor", doctor);
            return "registration";
        }

        // ADD THIS: Check if username is null or empty
        if (doctor.getUsername() == null || doctor.getUsername().trim().isEmpty()) {
            model.addAttribute("doctor", doctor);
            model.addAttribute("error", "Username is required!");
            return "registration";
        }

        if (!doctor.getPassword().equals(confirmPassword)) {
            model.addAttribute("doctor", doctor);
            model.addAttribute("error", "Passwords do not match!");
            return "registration";
        }

        if (doctorService.getDoctorByUsername(doctor.getUsername()).isPresent()) {
            model.addAttribute("doctor", doctor);
            model.addAttribute("error", "Username already exists!");
            return "registration";
        }

        if (doctorRepository.findByEmail(doctor.getEmail()).isPresent()) {
            model.addAttribute("doctor", doctor);
            model.addAttribute("error", "Email already exists!");
            return "registration";
        }

        try {
            String hashedPassword = passwordEncoder.encode(doctor.getPassword());
            doctor.setPassword(hashedPassword);
            doctor.setEmployeeType("DOCTOR");

            Doctor savedDoctor = doctorService.registerDoctor(doctor); // FIXED: consistent variable name


            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("doctor", doctor);
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "registration";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
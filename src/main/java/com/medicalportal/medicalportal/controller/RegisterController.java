package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient;
import com.medicalportal.medicalportal.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private PatientService patientService;

    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s]+$");

    @GetMapping
    public String showRegistrationForm(Model model) {
        model.addAttribute("patient", new Patient());
        return "PatientRegister";
    }

    @PostMapping
    public String registerPatient(
            @RequestParam String first_name,
            @RequestParam String last_name,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String dob,
            @RequestParam String nationalID,
            @RequestParam String gender,
            @RequestParam(required = false) String address,
            @RequestParam String phone1,
            @RequestParam(required = false) String phone2,
            Model model) {

        try {
            // Name validation
            if (!isValidName(first_name)) {
                model.addAttribute("error", "First name must contain only letters and spaces");
                return "PatientRegister";
            }

            if (!isValidName(last_name)) {
                model.addAttribute("error", "Last name must contain only letters and spaces");
                return "PatientRegister";
            }

            // Password validation
            if (!password.equals(confirmPassword)) {
                model.addAttribute("error", "Passwords do not match");
                return "PatientRegister";
            }

            // Phone number validation
            if (!isValidPhoneNumber(phone1)) {
                model.addAttribute("error", "Phone Number 1 must be exactly 10 digits");
                return "PatientRegister";
            }

            if (phone2 != null && !phone2.trim().isEmpty() && !isValidPhoneNumber(phone2)) {
                model.addAttribute("error", "Phone Number 2 must be exactly 10 digits");
                return "PatientRegister";
            }

            Patient patient = new Patient();
            patient.setFirstName(first_name.trim());
            patient.setLastName(last_name.trim());
            patient.setEmail(email);
            patient.setPassword(password);
            patient.setNationalId(nationalID);
            patient.setGender(gender);
            patient.setAddress(address);

            try {
                patient.setDob(LocalDate.parse(dob));
            } catch (DateTimeParseException e) {
                model.addAttribute("error", "Invalid date of birth");
                return "PatientRegister";
            }

            // Use the helper method to add phone numbers
            if (phone1 != null && !phone1.trim().isEmpty()) {
                patient.addPhoneNumber(phone1);
            }
            if (phone2 != null && !phone2.trim().isEmpty()) {
                patient.addPhoneNumber(phone2);
            }

            patientService.createPatient(patient);
            model.addAttribute("success", "Registration successful! Please login.");
            return "PatientRegister";

        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "PatientRegister";
        }
    }

    private boolean isValidPhoneNumber(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        // Remove any spaces or special characters
        String cleanPhone = phone.replaceAll("[^\\d]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }

    private boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return NAME_PATTERN.matcher(name.trim()).matches();
    }
}
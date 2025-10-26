package com.medicalportal.medicalportal.controller.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.service.Patient.Patient_PatientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

// NOTE: This controller is no longer used for login/logout
// Login and logout are now handled by the main LoginController
// which serves both employees and patients
@Controller
public class Patient_LoginController {

    @Autowired
    private Patient_PatientService patientService;

    // Removed duplicate mappings for /login and /logout
    // These are now handled by the main LoginController at root level
}

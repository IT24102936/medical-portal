package com.medicalportal.medicalportal.controller.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Appointment;
import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.service.Patient.Patient_AppointmentService;
import com.medicalportal.medicalportal.service.Patient.Patient_PatientService;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class PatientDashboardController {

    private static final Logger logger = LoggerFactory.getLogger(PatientDashboardController.class);

    @Autowired
    private Patient_PatientService patientService;

    @Autowired
    private Patient_AppointmentService appointmentService;

    @GetMapping("/patient/dashboard")
    public String showDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        logger.info("Accessing patient dashboard");

        // Check if logged in via main login controller
        String userType = (String) session.getAttribute("userType");
        Patient_Patient patient = null;
        
        if ("patient".equals(userType)) {
            // User logged in via main LoginController
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId != null) {
                patient = patientService.getPatientById(userId);
            }
        } else {
            // Check old session attribute for backward compatibility
            patient = (Patient_Patient) session.getAttribute("loggedInPatient");
        }
        
        if (patient == null) {
            logger.warn("No patient found in session, redirecting to login");
            redirectAttributes.addFlashAttribute("error", "Please login to access your dashboard.");
            return "redirect:/login";
        }

        logger.info("Patient found in session: {}", patient.getEmail());

        try {
            Patient_Patient fresh = patientService.getPatientById(patient.getId());
            session.setAttribute("user", fresh);
            session.setAttribute("userType", "patient");
            session.setAttribute("userId", fresh.getId());
            model.addAttribute("patient", fresh);

            // Fetch upcoming appointments for this patient
            List<Patient_Appointment> upcomingAppointments = appointmentService.getAppointmentsByPatientId(fresh.getId());
            model.addAttribute("upcomingAppointments", upcomingAppointments);

            logger.info("Dashboard loaded successfully for patient: {}", fresh.getEmail());
            return "patient/PatientDashBoard";
        } catch (Exception e) {
            logger.error("Error loading dashboard for patient {}: {}", patient.getId(), e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Error loading dashboard: " + e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/patient/profile")
    public String showProfile(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        logger.info("Accessing patient profile");

        // Check if logged in via main login controller
        String userType = (String) session.getAttribute("userType");
        Patient_Patient patient = null;
        
        if ("patient".equals(userType)) {
            // User logged in via main LoginController
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId != null) {
                patient = patientService.getPatientById(userId);
            }
        } else {
            // Check old session attribute for backward compatibility
            patient = (Patient_Patient) session.getAttribute("loggedInPatient");
        }
        
        if (patient == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to access your profile.");
            return "redirect:/login";
        }

        Patient_Patient fresh = patientService.getPatientById(patient.getId());
        session.setAttribute("user", fresh);
        session.setAttribute("userType", "patient");
        session.setAttribute("userId", fresh.getId());
        model.addAttribute("patient", fresh);

        logger.info("Profile loaded successfully for patient: {}", fresh.getEmail());
        return "patient/PatientProfile";
    }
}
package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Patient_entites.Appointment;
import com.medicalportal.medicalportal.entity.Patient_entites.Patient;
import com.medicalportal.medicalportal.service.AppointmentService;
import com.medicalportal.medicalportal.service.PatientService;
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
    private PatientService patientService;

    @Autowired
    private AppointmentService appointmentService;

    @GetMapping("/patient/dashboard")
    public String showDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        logger.info("Accessing patient dashboard");

        Patient patient = (Patient) session.getAttribute("loggedInPatient");
        if (patient == null) {
            logger.warn("No patient found in session, redirecting to login");
            redirectAttributes.addFlashAttribute("error", "Please login to access your dashboard.");
            return "redirect:/login";
        }

        logger.info("Patient found in session: {}", patient.getEmail());

        try {
            Patient fresh = patientService.getPatientById(patient.getId());
            session.setAttribute("loggedInPatient", fresh);
            model.addAttribute("patient", fresh);

            // Fetch upcoming appointments for this patient
            List<Appointment> upcomingAppointments = appointmentService.getAppointmentsByPatientId(fresh.getId());
            model.addAttribute("upcomingAppointments", upcomingAppointments);

            logger.info("Dashboard loaded successfully for patient: {}", fresh.getEmail());
            return "PatientDashBoard";
        } catch (Exception e) {
            logger.error("Error loading dashboard for patient {}: {}", patient.getId(), e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Error loading dashboard: " + e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/patient/profile")
    public String showProfile(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        logger.info("Accessing patient profile");

        Patient patient = (Patient) session.getAttribute("loggedInPatient");
        if (patient == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to access your profile.");
            return "redirect:/login";
        }

        Patient fresh = patientService.getPatientById(patient.getId());
        session.setAttribute("loggedInPatient", fresh);
        model.addAttribute("patient", fresh);

        logger.info("Profile loaded successfully for patient: {}", fresh.getEmail());
        return "PatientProfile";
    }
}
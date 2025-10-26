package com.medicalportal.medicalportal.controller.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Doctor;
import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.service.Patient.Patient_DoctorService;
import com.medicalportal.medicalportal.service.Patient.Patient_PatientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class AppointmentBookingController {

    @Autowired
    private Patient_PatientService patientService;

    @Autowired
    private Patient_DoctorService doctorService;

    @GetMapping("/patient/appointment")
    public String showAppointmentBookingPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        // Check if patient is logged in
        String userType = (String) session.getAttribute("userType");
        Patient_Patient patient = null;
        
        if ("patient".equals(userType)) {
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId != null) {
                patient = patientService.getPatientById(userId);
            }
        } else {
            patient = (Patient_Patient) session.getAttribute("loggedInPatient");
        }
        
        if (patient == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to book an appointment.");
            return "redirect:/login";
        }

        try {
            // Refresh patient data from database with phone numbers
            Patient_Patient freshPatient = patientService.getPatientByIdWithPhones(patient.getId());
            session.setAttribute("user", freshPatient);
            session.setAttribute("userType", "patient");
            session.setAttribute("userId", freshPatient.getId());
            model.addAttribute("patient", freshPatient);

            // Fetch all doctors from database
            List<Patient_Doctor> doctors = doctorService.getAllDoctors();
            model.addAttribute("doctors", doctors);

            return "patient/PatientAppointment"; // This should match your JSP file name
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading appointment page: " + e.getMessage());
            return "redirect:/patient/dashboard";
        }
    }

    @GetMapping("/patient/appointments")
    public String showAppointmentsPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        // Check if patient is logged in
        String userType = (String) session.getAttribute("userType");
        Patient_Patient patient = null;
        
        if ("patient".equals(userType)) {
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId != null) {
                patient = patientService.getPatientById(userId);
            }
        } else {
            patient = (Patient_Patient) session.getAttribute("loggedInPatient");
        }
        
        if (patient == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to view appointments.");
            return "redirect:/login";
        }

        try {
            // Refresh patient data from database with phone numbers
            Patient_Patient freshPatient = patientService.getPatientByIdWithPhones(patient.getId());
            session.setAttribute("user", freshPatient);
            session.setAttribute("userType", "patient");
            session.setAttribute("userId", freshPatient.getId());
            model.addAttribute("patient", freshPatient);

            // Fetch all doctors from database
            List<Patient_Doctor> doctors = doctorService.getAllDoctors();
            model.addAttribute("doctors", doctors);

            return "patient/PatientAppointment"; // This will show the appointment booking page
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading appointments page: " + e.getMessage());
            return "redirect:/patient/dashboard";
        }
    }
}
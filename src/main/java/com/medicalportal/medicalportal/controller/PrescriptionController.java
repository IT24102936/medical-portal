package com.medicalportal.medicalportal.controller;

import  com.medicalportal.medicalportal.entity.Prescription;
import com.medicalportal.medicalportal.entity.*;
import com.medicalportal.medicalportal.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.util.List;
import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@RequestMapping("/doctor/{id}/prescriptions")
public class PrescriptionController {

    @Autowired
    private DoctorService doctorService;

    // View all prescriptions
    @GetMapping
    public String viewPrescriptions(@PathVariable Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        if (doctor.isEmpty()) {
            return "redirect:/error";
        }

        List<Prescription> prescriptions = doctorService.getDoctorPrescriptions(id);

        model.addAttribute("doctor", doctor.get());
        model.addAttribute("prescriptions", prescriptions);
        return "prescriptions";
    }

    // Show create prescription form
    @GetMapping("/create")
    public String showCreatePrescriptionForm(@PathVariable Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        if (doctor.isEmpty()) {
            return "redirect:/error";
        }

        Prescription prescription = new Prescription();
        prescription.setDoctor(doctor.get());
        prescription.setIssueDate(LocalDate.now());

        model.addAttribute("doctor", doctor.get());
        model.addAttribute("prescription", prescription);
        return "create-prescription";
    }

    // Create new prescription
    @PostMapping("/create")
    public String createPrescription(@PathVariable Long id,
                                     @ModelAttribute Prescription prescription,
                                     @RequestParam Long patientId,
                                     RedirectAttributes redirectAttributes,
                                     HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        try {
            // Set patient information
            prescription.setPatientId(patientId);
            prescription.setDoctorId(id);

            // Basic validation
            if (patientId == null || patientId <= 0) {
                redirectAttributes.addFlashAttribute("error", "Valid Patient ID is required");
                return "redirect:/doctor/" + id + "/prescriptions/create";
            }

            if (prescription.getDescription() == null || prescription.getDescription().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Description is required");
                return "redirect:/doctor/" + id + "/prescriptions/create";
            }

            if (prescription.getDescription().trim().length() < 10) {
                redirectAttributes.addFlashAttribute("error", "Description must be at least 10 characters");
                return "redirect:/doctor/" + id + "/prescriptions/create";
            }


            // Verify patient exists before creating prescription
            if (!doctorService.verifyPatientExists(patientId)) {
                redirectAttributes.addFlashAttribute("error", "Patient with ID " + patientId + " not found");
                return "redirect:/doctor/" + id + "/prescriptions/create";
            }

            // Create prescription
            Prescription savedPrescription = doctorService.createPrescription(prescription);

            redirectAttributes.addFlashAttribute("success", "Prescription created successfully!");
            return "redirect:/doctor/" + id + "/prescriptions";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create prescription: " + e.getMessage());
            return "redirect:/doctor/" + id + "/prescriptions/create";
        }
    }

    // View single prescription details
    @GetMapping("/{prescriptionId}")
    public String viewPrescriptionDetails(@PathVariable Long id,
                                          @PathVariable Long prescriptionId,
                                          Model model, HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        Optional<Prescription> prescription = doctorService.getPrescriptionById(prescriptionId, id);

        if (doctor.isEmpty() || prescription.isEmpty()) {
            return "redirect:/error";
        }

        model.addAttribute("doctor", doctor.get());
        model.addAttribute("prescription", prescription.get());
        return "prescription-details";
    }

    // Helper method to check if user is logged in
    private boolean isLoggedIn(HttpSession session, Long doctorId) {
        Doctor sessionDoctor = (Doctor) session.getAttribute("doctor");
        return sessionDoctor != null && sessionDoctor.getId().equals(doctorId);
    }
}
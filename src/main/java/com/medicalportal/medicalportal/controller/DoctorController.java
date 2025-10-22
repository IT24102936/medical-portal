package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.entity.Appointment;
import com.medicalportal.medicalportal.repository.AppointmentRepository;
import com.medicalportal.medicalportal.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    // Check if doctor is logged in
    private boolean isLoggedIn(HttpSession session, Long doctorId) {
        Doctor sessionDoctor = (Doctor) session.getAttribute("doctor");
        return sessionDoctor != null && sessionDoctor.getId().equals(doctorId);
    }

    // Show dashboard
    @GetMapping("/{id}/dashboard")
    public String showDashboard(@PathVariable Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        if (doctor.isPresent()) {
            List<Appointment> todayAppointments = doctorService.getDoctorAppointmentsByDate(id, LocalDate.now().toString());
            model.addAttribute("doctor", doctor.get());
            model.addAttribute("todayAppointments", todayAppointments);
            return "dashboard";
        } else {
            return "redirect:/error";
        }
    }

    // Show profile
    @GetMapping("/{id}/profile")
    public String showProfile(@PathVariable Long id, Model model, HttpSession session) {
        Doctor sessionDoctor = (Doctor) session.getAttribute("doctor");
        if (sessionDoctor == null || !sessionDoctor.getId().equals(id)) {
            return "redirect:/login";
        }

        // Always fetch fresh data from DB
        Optional<Doctor> freshDoctor = doctorService.getDoctorById(id);
        if (freshDoctor.isPresent()) {
            Doctor doctor = freshDoctor.get();
            session.setAttribute("doctor", doctor);
            model.addAttribute("doctor", doctor);
        } else {
            model.addAttribute("doctor", sessionDoctor);
        }

        return "profile";
    }

    // Show edit profile form
    @GetMapping("/{id}/edit-profile")
    public String showEditProfileForm(@PathVariable Long id, Model model, HttpSession session) {
        Doctor sessionDoctor = (Doctor) session.getAttribute("doctor");
        if (sessionDoctor == null || !sessionDoctor.getId().equals(id)) {
            return "redirect:/login";
        }

        model.addAttribute("doctor", sessionDoctor);
        return "edit-profile";
    }

    // Update profile (fixed password encoding)
    @PostMapping("/{id}/update-profile")
    public String updateProfile(@PathVariable Long id,
                                @ModelAttribute Doctor updatedDoctor,
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        try {
            Optional<Doctor> existingDoctorOpt = doctorService.getDoctorById(id);
            if (existingDoctorOpt.isPresent()) {
                Doctor existingDoctor = existingDoctorOpt.get();

                // Update editable fields
                existingDoctor.setFirstName(updatedDoctor.getFirstName());
                existingDoctor.setLastName(updatedDoctor.getLastName());
                existingDoctor.setEmail(updatedDoctor.getEmail());
                existingDoctor.setSpecialization(updatedDoctor.getSpecialization());
                existingDoctor.setNationalId(updatedDoctor.getNationalId());
                existingDoctor.setGender(updatedDoctor.getGender());
                existingDoctor.setDateOfBirth(updatedDoctor.getDateOfBirth());
                existingDoctor.setSalary(updatedDoctor.getSalary());

                // Only update password if provided (with encryption)
                if (updatedDoctor.getPassword() != null && !updatedDoctor.getPassword().trim().isEmpty()) {
                    String hashedPassword = passwordEncoder.encode(updatedDoctor.getPassword());
                    existingDoctor.setPassword(hashedPassword);
                }

                // Save updates
                Doctor savedDoctor = doctorService.updateDoctor(existingDoctor);

                // Refresh session with updated doctor
                session.setAttribute("doctor", savedDoctor);
                redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
            }

            return "redirect:/doctor/" + id + "/profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile: " + e.getMessage());
            return "redirect:/doctor/" + id + "/edit-profile";
        }
    }

    // Delete profile
    @PostMapping("/{id}/delete-profile")
    public String deleteProfile(@PathVariable Long id, RedirectAttributes redirectAttributes, HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }
        try {
            doctorService.deleteDoctor(id);
            session.invalidate();
            redirectAttributes.addFlashAttribute("success", "Your profile has been deleted successfully.");
            return "redirect:/";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete profile: " + e.getMessage());
            return "redirect:/doctor/" + id + "/profile";
        }
    }

    // View appointments
    @GetMapping("/{id}/appointments")
    public String viewAppointments(@PathVariable Long id,
                                   @RequestParam(value = "view", defaultValue = "day") String view,
                                   @RequestParam(value = "date", required = false) String date,
                                   Model model, HttpSession session) {
        if (!isLoggedIn(session, id)) {
            return "redirect:/login";
        }

        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        if (doctor.isPresent()) {
            List<Appointment> appointments;
            LocalDate selectedDate;

            try {
                selectedDate = (date != null && !date.trim().isEmpty())
                        ? LocalDate.parse(date)
                        : LocalDate.now();
            } catch (Exception e) {
                selectedDate = LocalDate.now();
            }

            String displayDate = selectedDate.toString();

            if ("week".equals(view)) {
                appointments = doctorService.getDoctorAppointmentsByWeek(id, displayDate);
                model.addAttribute("viewType", "week");
            } else {
                appointments = doctorService.getDoctorAppointmentsByDate(id, displayDate);
                model.addAttribute("viewType", "day");
            }

            model.addAttribute("doctor", doctor.get());
            model.addAttribute("appointments", appointments);
            model.addAttribute("selectedDate", displayDate);

            // Get upcoming appointments
            List<Appointment> upcomingAppointments = getUpcomingAppointments(id, selectedDate, view);
            model.addAttribute("upcomingAppointments", upcomingAppointments);

            return "appointments";
        } else {
            return "redirect:/error";
        }
    }


    // Helper: Get upcoming appointments (next 7 days)
    private List<Appointment> getUpcomingAppointments(Long doctorId, LocalDate selectedDate, String viewType) {
        LocalDate startDate = LocalDate.now().plusDays(1);
        LocalDate endDate = startDate.plusDays(7);

        return appointmentRepository.findByDoctorIdAndAppointmentDateBetweenAndStatus(
                doctorId, startDate, endDate, "Scheduled");
    }



}




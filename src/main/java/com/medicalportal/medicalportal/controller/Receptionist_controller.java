package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Appointment;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Doctor;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Patient;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Receptionist;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Employee;
import com.medicalportal.medicalportal.service.receptionist.receptionist_AppointmentService;
import com.medicalportal.medicalportal.service.receptionist.receptionist_DoctorService;
import com.medicalportal.medicalportal.service.receptionist.receptionist_PatientService;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_ReceptionistRepository;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Receptionist_controller {
    
    @Autowired
    private receptionist_PatientService patientService;
    
    @Autowired
    private receptionist_DoctorService doctorService;
    
    @Autowired
    private receptionist_AppointmentService appointmentService;
    
    @Autowired
    private receptionist_ReceptionistRepository receptionistRepository;
    
    @Autowired
    private receptionist_EmployeeRepository employeeRepository;
    
    // Helper method to check if user is logged in as receptionist
    private boolean isReceptionistLoggedIn(HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        return "employee".equals(userType) && "Receptionist".equals(role);
    }
    
    // Helper method to check receptionist access and redirect if not authorized
    private String checkReceptionistAccess(HttpSession session) {
        if (!isReceptionistLoggedIn(session)) {
            return "redirect:/login";
        }
        return null;
    }
    
    
    @GetMapping("/bookAppointment")
    public String bookAppointment(Model model, HttpSession session) {
        String redirectUrl = checkReceptionistAccess(session);
        if (redirectUrl != null) return redirectUrl;
        try {
            // Load doctors from database
            List<receptionist_Doctor> doctors = doctorService.getAllDoctors();
            
            // If no doctors exist, create some sample doctors
            if (doctors.isEmpty()) {
                createSampleDoctors();
                doctors = doctorService.getAllDoctors();
            }
            
            model.addAttribute("doctorsList", doctors);
            return "receptionist/bookAppointment"; // Maps to bookAppointment.jsp
        } catch (Exception e) {
            // If database connection fails, return empty list
            model.addAttribute("doctorsList", List.of());
            return "receptionist/bookAppointment";
        }
    }
    
    @PostMapping("/bookAppointment")
    public String processAppointment(@RequestParam String patientId,
                                   @RequestParam String receptionistId,
                                   @RequestParam String doctorId,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        String redirectUrl = checkReceptionistAccess(session);
        if (redirectUrl != null) return redirectUrl;
        try {
            // Basic validation
            if (patientId == null || patientId.trim().isEmpty() ||
                receptionistId == null || receptionistId.trim().isEmpty() ||
                doctorId == null || doctorId.trim().isEmpty()) {
                
                redirectAttributes.addFlashAttribute("error", "All required fields must be filled");
                return "redirect:/bookAppointment";
            }
            
            // Get patient and doctor from database
            receptionist_Patient patient = patientService.getPatientById(Integer.parseInt(patientId)).orElse(null);
            receptionist_Doctor doctor = doctorService.getDoctorById(Integer.parseInt(doctorId)).orElse(null);
            
            if (patient == null) {
                redirectAttributes.addFlashAttribute("error", "Patient not found with ID: " + patientId);
                return "redirect:/bookAppointment";
            }
            
            if (doctor == null) {
                redirectAttributes.addFlashAttribute("error", "Doctor not found with ID: " + doctorId);
                return "redirect:/bookAppointment";
            }
            
            // Use current timestamp for appointment
            LocalDateTime appointmentDateTime = LocalDateTime.now();
            
            // Create and save appointment with proper relationships
            receptionist_Appointment appointment = appointmentService.createAppointmentWithRelationships(
                patient, doctor, appointmentDateTime, Integer.parseInt(receptionistId)
            );
            
            redirectAttributes.addFlashAttribute("success", "Appointment booked successfully! Appointment ID: " + appointment.getId());
            return "redirect:/receptionist/dashboard";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error booking appointment: " + e.getMessage());
            return "redirect:/bookAppointment";
        }
    }
    
    @GetMapping("/receptionist/dashboard")
    public String receptionistDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        String redirectUrl = checkReceptionistAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        // Get employee details from session
        Integer employeeId = (Integer) session.getAttribute("userId");
        if (employeeId != null) {
            try {
                receptionist_Receptionist receptionist = receptionistRepository.findById(employeeId).orElse(null);
                if (receptionist != null && receptionist.getEmployee() != null) {
                    receptionist_Employee employee = receptionist.getEmployee();
                    model.addAttribute("employeeFirstName", employee.getFirstName());
                    model.addAttribute("employeeLastName", employee.getLastName());
                    model.addAttribute("employeeName", employee.getFirstName() + " " + employee.getLastName());
                    model.addAttribute("employeeId", employee.getId());
                    model.addAttribute("employeeEmail", employee.getEmail());
                }
            } catch (Exception e) {
                model.addAttribute("employeeName", "Receptionist");
            }
        }
        
        try {
            // Load appointments from database
            List<receptionist_Appointment> upcomingAppointments = appointmentService.getUpcomingAppointments();
            List<receptionist_Appointment> pastAppointments = appointmentService.getPastAppointments();
            List<receptionist_Appointment> canceledAppointments = appointmentService.getAppointmentsByStatus("Canceled");
            
            // Get today's appointments
            LocalDate today = LocalDate.now();
            List<receptionist_Appointment> todaysAppointments = appointmentService.getAppointmentsByDate(today);
            
            // Create stats object
            Map<String, Object> stats = new HashMap<>();
            stats.put("todayAppointments", todaysAppointments.size());
            stats.put("upcomingAppointments", upcomingAppointments.size());
            stats.put("totalPatients", patientService.getAllPatients().size());
            stats.put("totalDoctors", doctorService.getAllDoctors().size());
            
            // Create receptionist object with dynamic name
            String receptionistName = (String) model.getAttribute("employeeName");
            if (receptionistName == null) {
                receptionistName = "Receptionist";
            }
            Map<String, Object> receptionist = new HashMap<>();
            receptionist.put("name", receptionistName);
            
            // Create recent activities from actual data
            List<Map<String, String>> recentActivities = new ArrayList<>();
            if (!todaysAppointments.isEmpty()) {
                for (int i = 0; i < Math.min(3, todaysAppointments.size()); i++) {
                    receptionist_Appointment apt = todaysAppointments.get(i);
                    recentActivities.add(Map.of(
                        "description", "Appointment #" + apt.getId() + " scheduled",
                        "time", "Just now"
                    ));
                }
            } else {
                recentActivities.add(Map.of("description", "No recent activities", "time", ""));
            }
            
            // Add data to model
            model.addAttribute("upcomingAppointments", upcomingAppointments);
            model.addAttribute("pastAppointments", pastAppointments);
            model.addAttribute("canceledAppointments", canceledAppointments);
            model.addAttribute("todaysAppointments", todaysAppointments);
            model.addAttribute("stats", stats);
            model.addAttribute("receptionist", receptionist);
            model.addAttribute("recentActivities", recentActivities);
            
            return "receptionist/receptionist_dashboard"; // Maps to receptionist_dashboard.jsp
        } catch (Exception e) {
            // If database connection fails, return empty lists
            model.addAttribute("upcomingAppointments", List.of());
            model.addAttribute("pastAppointments", List.of());
            model.addAttribute("canceledAppointments", List.of());
            model.addAttribute("todaysAppointments", List.of());
            model.addAttribute("stats", Map.of(
                "todayAppointments", 0, 
                "upcomingAppointments", 0, 
                "totalPatients", 0, 
                "totalDoctors", 0
            ));
            model.addAttribute("receptionist", Map.of("name", "User"));
            model.addAttribute("recentActivities", List.of());
            return "receptionist/receptionist_dashboard";
        }
    }
    
    // Method to create sample doctors
    private void createSampleDoctors() {
        try {
            // Create sample doctors
            receptionist_Doctor doctor1 = new receptionist_Doctor();
            doctor1.setEid(1001);
            doctor1.setSpecialization("Cardiology");
            doctor1.setAvailable(true);
            
            receptionist_Doctor doctor2 = new receptionist_Doctor();
            doctor2.setEid(1002);
            doctor2.setSpecialization("Neurology");
            doctor2.setAvailable(true);
            
            receptionist_Doctor doctor3 = new receptionist_Doctor();
            doctor3.setEid(1003);
            doctor3.setSpecialization("Orthopedics");
            doctor3.setAvailable(true);
            
            receptionist_Doctor doctor4 = new receptionist_Doctor();
            doctor4.setEid(1004);
            doctor4.setSpecialization("Pediatrics");
            doctor4.setAvailable(true);
            
            receptionist_Doctor doctor5 = new receptionist_Doctor();
            doctor5.setEid(1005);
            doctor5.setSpecialization("Dermatology");
            doctor5.setAvailable(true);
            
            receptionist_Doctor doctor6 = new receptionist_Doctor();
            doctor6.setEid(1006);
            doctor6.setSpecialization("General Medicine");
            doctor6.setAvailable(true);
            
            // Save doctors to database
            doctorService.saveDoctor(doctor1);
            doctorService.saveDoctor(doctor2);
            doctorService.saveDoctor(doctor3);
            doctorService.saveDoctor(doctor4);
            doctorService.saveDoctor(doctor5);
            doctorService.saveDoctor(doctor6);
            
        } catch (Exception e) {
            // Log error but don't throw exception
            System.err.println("Error creating sample doctors: " + e.getMessage());
        }
    }
}
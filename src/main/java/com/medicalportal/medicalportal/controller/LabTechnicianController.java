package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.*;
import com.medicalportal.medicalportal.service.LabTechnicianService;
import com.medicalportal.medicalportal.service.MedicalReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/lab-technician")
public class LabTechnicianController {

    @Autowired
    private LabTechnicianService labTechnicianService;

    @Autowired
    private MedicalReportService medicalReportService;

    @GetMapping
    public String showDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        // Check authentication
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        String role = (String) session.getAttribute("employeeRole");
        
        if (employee == null) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Please log in to access the lab technician dashboard.");
            return "redirect:/auth/login?role=lab-technician";
        }
        
        if (!"lab-technician".equalsIgnoreCase(role)) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Access denied. You need lab technician privileges to access this page.");
            return "redirect:/auth/login?role=lab-technician";
        }
        
        // Add employee info to model
        model.addAttribute("currentEmployee", employee);
        model.addAttribute("employeeName", employee.getFirstName() + " " + employee.getLastName());
        
        // Initialize sample data if database is empty
        if (labTechnicianService.getTotalPendingOrders() == 0) {
            initializeSampleData();
        }

        List<DoctorIssuesLabOrder> doctorOrders = labTechnicianService.getAllDoctorOrders();
        List<Doctor> doctors = labTechnicianService.getAllDoctors();
        List<Patient> patients = labTechnicianService.getAllPatients();
        List<LabOrder> labOrders = labTechnicianService.getAllLabOrders();
        List<MedicalReport> medicalReports = medicalReportService.getAllReports();

        // Add null safety
        model.addAttribute("doctorOrders", doctorOrders != null ? doctorOrders : new ArrayList<>());
        model.addAttribute("doctors", doctors != null ? doctors : new ArrayList<>());
        model.addAttribute("patients", patients != null ? patients : new ArrayList<>());
        model.addAttribute("labOrders", labOrders != null ? labOrders : new ArrayList<>());
        model.addAttribute("medicalReports", medicalReports != null ? medicalReports : new ArrayList<>());

        // Statistics for dashboard
        model.addAttribute("totalPendingOrders", labTechnicianService.getTotalPendingOrders());
        model.addAttribute("totalOrdersToday", labTechnicianService.getTotalOrdersToday());
        model.addAttribute("totalOrdersThisWeek", labTechnicianService.getTotalOrdersThisWeek());
        model.addAttribute("totalReports", medicalReportService.getTotalReportsCount());
        model.addAttribute("reportsToday", medicalReportService.getReportsCountToday());

        return "lab-technician-dashboard";
    }

    @GetMapping("/dashboard")
    public String showLabTechnicianDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        return showDashboard(model, session, redirectAttributes);
    }

    // Accept/Process doctor order
    @PostMapping("/order/accept")
    public String acceptOrder(@RequestParam Integer doctorEid,
                             @RequestParam Integer labOrderId,
                             @RequestParam Integer patientId,
                             RedirectAttributes redirectAttributes) {
        try {
            boolean accepted = labTechnicianService.acceptOrder(doctorEid, labOrderId, patientId);
            if (accepted) {
                redirectAttributes.addFlashAttribute("successMessage",
                        "Order accepted successfully and is now in progress.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Order not found or could not be accepted.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to accept order: " + e.getMessage());
        }
        return "redirect:/lab-technician";
    }

    // Submit results for an order
    @PostMapping("/order/submit-results")
    public String submitResults(@RequestParam Integer doctorEid,
                               @RequestParam Integer labOrderId,
                               @RequestParam Integer patientId,
                               @RequestParam(required = false) String results,
                               RedirectAttributes redirectAttributes) {
        try {
            // In a real application, you would save the results to a separate results table
            // For now, we'll just show a success message
            redirectAttributes.addFlashAttribute("successMessage",
                    "Lab results submitted successfully for order ID: " + labOrderId);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to submit results: " + e.getMessage());
        }
        return "redirect:/lab-technician";
    }

    // Get doctor orders by date range (AJAX endpoint)
    @GetMapping("/orders/by-date")
    @ResponseBody
    public List<DoctorIssuesLabOrder> getOrdersByDateRange(@RequestParam String startDate,
                                                           @RequestParam String endDate) {
        try {
            LocalDate start = LocalDate.parse(startDate);
            LocalDate end = LocalDate.parse(endDate);
            return labTechnicianService.getDoctorOrdersByDateRange(start, end);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    // Get orders by patient (AJAX endpoint)
    @GetMapping("/orders/by-patient/{patientId}")
    @ResponseBody
    public List<DoctorIssuesLabOrder> getOrdersByPatient(@PathVariable Integer patientId) {
        return labTechnicianService.getOrdersByPatient(patientId);
    }

    // Get orders by doctor (AJAX endpoint)
    @GetMapping("/orders/by-doctor/{doctorId}")
    @ResponseBody
    public List<DoctorIssuesLabOrder> getOrdersByDoctor(@PathVariable Integer doctorId) {
        return labTechnicianService.getOrdersByDoctor(doctorId);
    }

    // Update lab technician profile
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String firstName,
                               @RequestParam String lastName,
                               @RequestParam String address,
                               @RequestParam String contactNumber,
                               RedirectAttributes redirectAttributes) {
        try {
            // Here you would typically update the lab technician's profile in the database
            // For now, we'll just show a success message
            redirectAttributes.addFlashAttribute("successMessage",
                    "Profile updated successfully! Name: " + firstName + " " + lastName);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to update profile: " + e.getMessage());
        }
        return "redirect:/lab-technician";
    }

    // Submit medical report with drive link
    @PostMapping("/medical-report/submit")
    public String submitMedicalReport(@RequestParam String reportType,
                                     @RequestParam String documentPath,
                                     @RequestParam Integer patientId,
                                     RedirectAttributes redirectAttributes) {
        try {
            // Validate drive link format
            if (!medicalReportService.isValidDriveLink(documentPath)) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Invalid drive link format. Please provide a valid Google Drive or HTTPS link.");
                return "redirect:/lab-technician";
            }

            MedicalReport report = medicalReportService.createMedicalReport(reportType, documentPath, patientId);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Medical report submitted successfully! Report ID: " + report.getId());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to submit medical report: " + e.getMessage());
        }
        return "redirect:/lab-technician";
    }

    // Delete medical report
    @PostMapping("/medical-report/delete/{id}")
    public String deleteMedicalReport(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            boolean deleted = medicalReportService.deleteMedicalReport(id);
            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage",
                        "Medical report deleted successfully.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Medical report not found or could not be deleted.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to delete medical report: " + e.getMessage());
        }
        return "redirect:/lab-technician";
    }

    // Get medical report by ID (AJAX endpoint)
    @GetMapping("/medical-report/{id}")
    @ResponseBody
    public MedicalReport getMedicalReport(@PathVariable Integer id) {
        return medicalReportService.getReportById(id).orElse(null);
    }

    // Get medical reports by patient (AJAX endpoint)
    @GetMapping("/medical-reports/by-patient/{patientId}")
    @ResponseBody
    public List<MedicalReport> getMedicalReportsByPatient(@PathVariable Integer patientId) {
        return medicalReportService.getReportsByPatient(patientId);
    }

    // Initialize sample data for demonstration
    private void initializeSampleData() {
        try {
            // Create sample lab orders if they don't exist
            if (labTechnicianService.getAllLabOrders().isEmpty()) {
                labTechnicianService.createLabOrder("Complete Blood Count (CBC)");
                labTechnicianService.createLabOrder("Urine Analysis");
                labTechnicianService.createLabOrder("Lipid Panel");
                labTechnicianService.createLabOrder("Thyroid Function Test");
                labTechnicianService.createLabOrder("Blood Glucose Test");
            }
        } catch (Exception e) {
            System.err.println("Error initializing sample data: " + e.getMessage());
        }
    }
}
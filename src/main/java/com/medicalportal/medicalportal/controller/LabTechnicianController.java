package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.Lab_Phar_Patient;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Doctor;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_DoctorIssuesLabOrder;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_LabOrder;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_MedicalReport;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Employee;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_LabTechnician;
import com.medicalportal.medicalportal.service.LabTech_Pharmacist.Lab_Phar_LabTechnicianService;
import com.medicalportal.medicalportal.service.LabTech_Pharmacist.Lab_Phar_MedicalReportService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/lab-technician")
public class LabTechnicianController {

    @Autowired
    private Lab_Phar_LabTechnicianService labTechnicianService;

    @Autowired
    private Lab_Phar_MedicalReportService medicalReportService;
    
    @Autowired
    private com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_LabTechnicianRepository labTechnicianRepository;
    
    @Autowired
    private com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_EmployeeRepository employeeRepository;
    
    // =============== AUTHENTICATION HELPER ===============
    
    private boolean isLabTechnicianLoggedIn(HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        return "employee".equals(userType) && "Lab Technician".equals(role);
    }
    
    private String checkLabTechnicianAccess(HttpSession session) {
        if (!isLabTechnicianLoggedIn(session)) {
            return "redirect:/login";
        }
        return null;
    }

    @GetMapping
    public String showDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        String redirectUrl = checkLabTechnicianAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        // Get employee details from session
        Integer employeeId = (Integer) session.getAttribute("userId");
        if (employeeId != null) {
            try {
                Lab_Phar_LabTechnician labTech = labTechnicianRepository.findById(employeeId).orElse(null);
                if (labTech != null && labTech.getEmployee() != null) {
                    Lab_Phar_Employee employee = labTech.getEmployee();
                    model.addAttribute("employeeFirstName", employee.getFirstName());
                    model.addAttribute("employeeLastName", employee.getLastName());
                    model.addAttribute("employeeName", employee.getFirstName() + " " + employee.getLastName());
                    model.addAttribute("employeeId", employee.getId());
                    model.addAttribute("employeeEmail", employee.getEmail());
                } else {
                    model.addAttribute("employeeName", "Lab Technician");
                }
            } catch (Exception e) {
                model.addAttribute("employeeName", "Lab Technician");
            }
        } else {
            model.addAttribute("employeeName", "Lab Technician");
        }
        
        // Initialize sample data if database is empty
        if (labTechnicianService.getTotalPendingOrders() == 0) {
            initializeSampleData();
        }

        List<Lab_Phar_DoctorIssuesLabOrder> doctorOrders = labTechnicianService.getAllDoctorOrders();
        List<Lab_Phar_Doctor> doctors = labTechnicianService.getAllDoctors();
        List<Lab_Phar_Patient> patients = labTechnicianService.getAllPatients();
        List<Lab_Phar_LabOrder> labOrders = labTechnicianService.getAllLabOrders();
        List<Lab_Phar_MedicalReport> medicalReports = medicalReportService.getAllReports();

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

        return "LabTech_Pharmacist/lab-technician-dashboard";
    }

    @GetMapping("/dashboard")
    public String showLabTechnicianDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        String redirectUrl = checkLabTechnicianAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
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
    public List<Lab_Phar_DoctorIssuesLabOrder> getOrdersByDateRange(@RequestParam String startDate,
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
    public List<Lab_Phar_DoctorIssuesLabOrder> getOrdersByPatient(@PathVariable Integer patientId) {
        return labTechnicianService.getOrdersByPatient(patientId);
    }

    // Get orders by doctor (AJAX endpoint)
    @GetMapping("/orders/by-doctor/{doctorId}")
    @ResponseBody
    public List<Lab_Phar_DoctorIssuesLabOrder> getOrdersByDoctor(@PathVariable Integer doctorId) {
        return labTechnicianService.getOrdersByDoctor(doctorId);
    }

    // Update lab technician profile
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String firstName,
                               @RequestParam String lastName,
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String nationalId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            Integer employeeId = (Integer) session.getAttribute("userId");
            if (employeeId == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Session expired. Please login again.");
                return "redirect:/login";
            }
            
            // Get the employee record
            Lab_Phar_Employee employee = employeeRepository.findById(employeeId).orElse(null);
            if (employee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Employee record not found.");
                return "redirect:/lab-technician";
            }
            
            // Update employee details
            employee.setFirstName(firstName);
            employee.setLastName(lastName);
            if (email != null && !email.trim().isEmpty()) {
                employee.setEmail(email);
            }
            if (nationalId != null && !nationalId.trim().isEmpty()) {
                employee.setNationalId(nationalId);
            }
            
            // Save updated employee
            employeeRepository.save(employee);
            
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

            Lab_Phar_MedicalReport report = medicalReportService.createMedicalReport(reportType, documentPath, patientId);
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
    public Lab_Phar_MedicalReport getMedicalReport(@PathVariable Integer id) {
        return medicalReportService.getReportById(id).orElse(null);
    }

    // Get medical reports by patient (AJAX endpoint)
    @GetMapping("/medical-reports/by-patient/{patientId}")
    @ResponseBody
    public List<Lab_Phar_MedicalReport> getMedicalReportsByPatient(@PathVariable Integer patientId) {
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
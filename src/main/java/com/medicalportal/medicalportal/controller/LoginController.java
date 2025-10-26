package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.admin.Admin_Employee;
import com.medicalportal.medicalportal.entity.admin.Admin_Patient;
import com.medicalportal.medicalportal.entity.admin.Admin_Doctor;
import com.medicalportal.medicalportal.repository.admin.Admin_EmployeeRepository;
import com.medicalportal.medicalportal.repository.admin.Admin_PatientRepository;
import com.medicalportal.medicalportal.repository.admin.Admin_DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.transaction.annotation.Transactional;
import com.medicalportal.medicalportal.util.PasswordUtil;

import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;

@Controller
public class LoginController {

    @Autowired
    private Admin_EmployeeRepository employeeRepository;

    @Autowired
    private Admin_PatientRepository patientRepository;
    
    @Autowired
    private Admin_DoctorRepository doctorRepository;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, 
                        @RequestParam String password, 
                        HttpSession session, 
                        Model model) {
        try {
            // First, check if the user is an employee
            Admin_Employee employee = employeeRepository.findByEmail(username);
            if (employee != null) {
                // Check if password matches (hashed or legacy plaintext)
                if (PasswordUtil.matches(password, employee.getPassword())) {
                    // Check if employee is active
                    if ("ACTIVE".equals(employee.getStatus())) {
                        // Migrate legacy plaintext password to hashed on successful login
                        if (!PasswordUtil.isHashed(employee.getPassword())) {
                            employeeRepository.updateEmployeePassword(employee.getEid(), PasswordUtil.hash(password));
                        }
                        session.setAttribute("user", employee);
                        session.setAttribute("userType", "employee");
                        session.setAttribute("userId", employee.getEid());
                        
                        // Determine role and redirect accordingly
                        String role = determineEmployeeRole(employee.getEid());
                        session.setAttribute("role", role);
                        
                        if ("Admin".equals(role)) {
                            return "redirect:/admin/dashboard";
                        } else if ("Doctor".equals(role)) {
                            return "redirect:/employee/dashboard";
                        } else if ("Lab Technician".equals(role)) {
                            return "redirect:/lab-technician/dashboard";
                        } else if ("Pharmacist".equals(role)) {
                            return "redirect:/pharmacist/dashboard";
                        } else if ("Receptionist".equals(role)) {
                            return "redirect:/receptionist/dashboard";
                        } else if ("Finance Admin".equals(role)) {
                            return "redirect:/employee/dashboard";
                        } else {
                            return "redirect:/employee/dashboard";
                        }
                    } else {
                        model.addAttribute("error", "Account is disabled. Please contact administrator.");
                        return "login";
                    }
                }
            }
            
            // If not an employee, check if the user is a patient
            Admin_Patient patient = patientRepository.findByEmail(username);
            if (patient != null) {
                // Check if password matches (hashed or legacy plaintext)
                if (PasswordUtil.matches(password, patient.getPassword())) {
                    // Check if patient is active
                    if ("ACTIVE".equals(patient.getStatus())) {
                        // Migrate legacy plaintext password to hashed on successful login
                        if (!PasswordUtil.isHashed(patient.getPassword())) {
                            patientRepository.updatePatientPassword(patient.getPatientId(), PasswordUtil.hash(password));
                        }
                        session.setAttribute("user", patient);
                        session.setAttribute("userType", "patient");
                        session.setAttribute("userId", patient.getPatientId());
                        return "redirect:/patient/dashboard";
                    } else {
                        model.addAttribute("error", "Account is disabled. Please contact administrator.");
                        return "login";
                    }
                }
            }
            
            // If we reach here, authentication failed
            model.addAttribute("error", "Invalid email or password");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred during login. Please try again.");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    private String determineEmployeeRole(Integer eid) {
        // Check if employee is an admin
        if (employeeRepository.isAdmin(eid)) {
            return "Admin";
        }
        // Check if employee is a doctor
        else if (employeeRepository.isDoctor(eid)) {
            return "Doctor";
        }
        // Check if employee is a lab technician
        else if (employeeRepository.countLabTechniciansByEid(eid) > 0) {
            return "Lab Technician";
        }
        // Check if employee is a pharmacist
        else if (employeeRepository.countPharmacistsByEid(eid) > 0) {
            return "Pharmacist";
        }
        // Check if employee is a receptionist
        else if (employeeRepository.countReceptionistsByEid(eid) > 0) {
            return "Receptionist";
        }
        // Check if employee is a finance admin
        else if (employeeRepository.countFinanceAdminsByEid(eid) > 0) {
            return "Finance Admin";
        }
        // For other employees, return generic employee role
        else {
            return "Employee";
        }
    }
    
    @GetMapping("/employee/dashboard")
    public String employeeDashboard() {
        return "employee/dashboard";
    }
    
    // NOTE: /patient/dashboard is handled by PatientDashboardController
    // Removed duplicate mapping to avoid ambiguous mapping error
    
    // =============== REGISTRATION ENDPOINTS ===============
    
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }
    
    @PostMapping("/register")
    @Transactional
    public String register(@RequestParam String firstName,
                          @RequestParam String lastName,
                          @RequestParam String userName,
                          @RequestParam String email,
                          @RequestParam String phone,
                          @RequestParam String nationalId,
                          @RequestParam String dob,
                          @RequestParam String gender,
                          @RequestParam String employeeType,
                          @RequestParam(required = false) String specialization,
                          @RequestParam BigDecimal salary,
                          @RequestParam String password,
                          @RequestParam String confirmPassword,
                          Model model) {
        try {
            // Validate password match
            if (!password.equals(confirmPassword)) {
                model.addAttribute("error", "Passwords do not match");
                return "register";
            }
            
            // Validate password length
            if (password.length() < 6) {
                model.addAttribute("error", "Password must be at least 6 characters long");
                return "register";
            }
            
            // Check if username already exists
            if (employeeRepository.existsByUserName(userName)) {
                model.addAttribute("error", "Username is already taken");
                return "register";
            }
            
            // Check if email already exists
            if (employeeRepository.existsByEmail(email)) {
                model.addAttribute("error", "Email is already registered");
                return "register";
            }
            
            // Get next employee ID
            Integer nextEid = employeeRepository.getNextEmployeeId();
            
            // Parse date of birth
            LocalDate dateOfBirth = LocalDate.parse(dob);
            
            // Server-side validations
            if (salary == null || salary.compareTo(BigDecimal.ZERO) < 0) {
                model.addAttribute("error", "Salary must be a non-negative amount");
                return "register";
            }
            
            // Insert employee record
            employeeRepository.insertEmployee(nextEid, firstName, lastName, email, 
                                            gender, dateOfBirth, salary, nationalId, 
                                            userName, "ACTIVE", PasswordUtil.hash(password));
            
            // Insert phone number
            if (phone != null && !phone.trim().isEmpty()) {
                employeeRepository.insertPhoneNumber(nextEid, phone.trim());
            }
            
            // Insert role-specific record
            switch (employeeType) {
                case "Doctor":
                    if (specialization == null || specialization.trim().isEmpty()) {
                        model.addAttribute("error", "Specialization is required for doctors");
                        // Clean up created employee
                        employeeRepository.deletePhoneNumbersByEid(nextEid);
                        employeeRepository.deleteEmployeeRecord(nextEid);
                        return "register";
                    }
                    doctorRepository.insertDoctor(nextEid, specialization.trim());
                    break;
                case "Receptionist":
                    employeeRepository.insertReceptionist(nextEid);
                    break;
                case "Lab Technician":
                    employeeRepository.insertLabTechnician(nextEid);
                    break;
                case "Pharmacist":
                    employeeRepository.insertPharmacist(nextEid);
                    break;
                case "Finance Admin":
                    employeeRepository.insertFinanceAdmin(nextEid);
                    break;
                default:
                    model.addAttribute("error", "Invalid employee type");
                    // Clean up created employee
                    employeeRepository.deletePhoneNumbersByEid(nextEid);
                    employeeRepository.deleteEmployeeRecord(nextEid);
                    return "register";
            }
            
            // Success - redirect to login page with success message
            return "redirect:/login?registered=true";
            
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "register";
        }
    }
}
package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Employee;
import com.medicalportal.medicalportal.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDate;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    /**
     * Show login page
     */
    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "role", required = false) String role, Model model) {
        model.addAttribute("role", role);
        return "login";
    }

    /**
     * Show registration page
     */
    @GetMapping("/register")
    public String showRegistrationPage(@RequestParam(value = "role", required = false) String role, Model model) {
        model.addAttribute("role", role);
        return "register";
    }

    /**
     * Process login
     */
    @PostMapping("/login")
    public String processLogin(@RequestParam String usernameOrEmail,
                             @RequestParam String password,
                             @RequestParam String role,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        try {
            Employee employee = authService.authenticate(usernameOrEmail, password, role);
            
            if (employee != null) {
                // Store user information in session
                session.setAttribute("loggedInEmployee", employee);
                session.setAttribute("employeeId", employee.getId());
                session.setAttribute("employeeName", employee.getFirstName() + " " + employee.getLastName());
                session.setAttribute("employeeRole", role);
                
                // Redirect to appropriate dashboard
                if ("pharmacist".equalsIgnoreCase(role)) {
                    redirectAttributes.addFlashAttribute("successMessage", 
                        "Welcome back, " + employee.getFirstName() + "! You have successfully logged in.");
                    return "redirect:/pharmacist";
                } else if ("lab-technician".equalsIgnoreCase(role)) {
                    redirectAttributes.addFlashAttribute("successMessage", 
                        "Welcome back, " + employee.getFirstName() + "! You have successfully logged in.");
                    return "redirect:/lab-technician";
                }
            }
            
            // Authentication failed
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Invalid credentials or you don't have " + role + " access. Please check your username/email and password.");
            return "redirect:/auth/login?role=" + role;
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Login failed: " + e.getMessage());
            return "redirect:/auth/login?role=" + role;
        }
    }

    /**
     * Process registration
     */
    @PostMapping("/register")
    public String processRegistration(@RequestParam String firstName,
                                    @RequestParam String lastName,
                                    @RequestParam String nationalId,
                                    @RequestParam String gender,
                                    @RequestParam String dobString,
                                    @RequestParam String email,
                                    @RequestParam String password,
                                    @RequestParam String confirmPassword,
                                    @RequestParam String userName,
                                    @RequestParam String role,
                                    @RequestParam(defaultValue = "50000.00") String salaryString,
                                    RedirectAttributes redirectAttributes) {
        
        try {
            // Basic validation
            if (!password.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
                return "redirect:/auth/register?role=" + role;
            }
            
            // Parse date
            LocalDate dob = LocalDate.parse(dobString);
            
            // Parse salary
            BigDecimal salary = new BigDecimal(salaryString);
            
            // Validate registration data
            String validationError = authService.validateRegistrationData(
                firstName, lastName, nationalId, gender, dob, email, password, userName, role);
            
            if (validationError != null) {
                redirectAttributes.addFlashAttribute("errorMessage", validationError);
                return "redirect:/auth/register?role=" + role;
            }
            
            // Register the employee
            Employee registeredEmployee = authService.registerEmployee(
                firstName, lastName, nationalId, gender, dob, email, password, userName, salary, role);
            
            if (registeredEmployee != null) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Registration successful! Welcome " + firstName + " " + lastName + 
                    ". You can now login with your credentials.");
                return "redirect:/auth/login?role=" + role;
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Registration failed. Please try again.");
                return "redirect:/auth/register?role=" + role;
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Registration failed: " + e.getMessage());
            return "redirect:/auth/register?role=" + role;
        }
    }

    /**
     * Logout
     */
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        String employeeName = (String) session.getAttribute("employeeName");
        
        // Clear session
        session.invalidate();
        
        redirectAttributes.addFlashAttribute("successMessage", 
            "You have been successfully logged out. Thank you for using Medisphere!");
        return "redirect:/";
    }

    /**
     * Check login status (for AJAX calls)
     */
    @GetMapping("/check-login")
    @ResponseBody
    public String checkLogin(HttpSession session) {
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        if (employee != null) {
            return "{\"logged_in\": true, \"employee_id\": " + employee.getId() + 
                   ", \"name\": \"" + employee.getFirstName() + " " + employee.getLastName() + "\"}";
        }
        return "{\"logged_in\": false}";
    }

    /**
     * Get employee profile (for AJAX calls)
     */
    @GetMapping("/profile")
    @ResponseBody
    public Employee getProfile(HttpSession session) {
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        if (employee != null) {
            // Return employee without password for security
            Employee safeEmployee = new Employee();
            safeEmployee.setId(employee.getId());
            safeEmployee.setFirstName(employee.getFirstName());
            safeEmployee.setLastName(employee.getLastName());
            safeEmployee.setEmail(employee.getEmail());
            safeEmployee.setUserName(employee.getUserName());
            safeEmployee.setGender(employee.getGender());
            safeEmployee.setDob(employee.getDob());
            safeEmployee.setNationalId(employee.getNationalId());
            safeEmployee.setSalary(employee.getSalary());
            return safeEmployee;
        }
        return null;
    }

    /**
     * Redirect to appropriate dashboard based on role
     */
    @GetMapping("/dashboard")
    public String redirectToDashboard(HttpSession session) {
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        String role = (String) session.getAttribute("employeeRole");
        
        if (employee != null && role != null) {
            if ("pharmacist".equalsIgnoreCase(role)) {
                return "redirect:/pharmacist";
            } else if ("lab-technician".equalsIgnoreCase(role)) {
                return "redirect:/lab-technician";
            }
        }
        
        return "redirect:/auth/login";
    }

    /**
     * Access denied page
     */
    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }
}
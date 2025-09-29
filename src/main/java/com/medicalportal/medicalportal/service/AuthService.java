package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Employee;
import com.medicalportal.medicalportal.entity.LabTechnician;
import com.medicalportal.medicalportal.entity.Pharmacist;
import com.medicalportal.medicalportal.repository.EmployeeRepository;
import com.medicalportal.medicalportal.repository.LabTechnicianRepository;
import com.medicalportal.medicalportal.repository.PharmacistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private LabTechnicianRepository labTechnicianRepository;

    @Autowired
    private PharmacistRepository pharmacistRepository;

    /**
     * Authenticate user with username/email and password
     * @param usernameOrEmail - can be either username or email
     * @param password - plain text password
     * @param role - expected role (pharmacist or lab-technician)
     * @return Employee if authentication successful, null otherwise
     */
    public Employee authenticate(String usernameOrEmail, String password, String role) {
        Optional<Employee> employee;
        
        // Try to find by username first, then by email
        if (usernameOrEmail.contains("@")) {
            employee = employeeRepository.findByEmailAndPassword(usernameOrEmail, password);
        } else {
            employee = employeeRepository.findByUserNameAndPassword(usernameOrEmail, password);
        }
        
        if (employee.isPresent()) {
            Employee emp = employee.get();
            // Verify the employee has the correct role
            if (hasRole(emp.getId(), role)) {
                return emp;
            }
        }
        
        return null;
    }

    /**
     * Check if employee has the specified role
     */
    private boolean hasRole(Integer employeeId, String role) {
        switch (role.toLowerCase()) {
            case "pharmacist":
                return pharmacistRepository.existsById(employeeId);
            case "lab-technician":
                return labTechnicianRepository.existsById(employeeId);
            default:
                return false;
        }
    }

    /**
     * Register a new employee with specified role
     */
    @Transactional
    public Employee registerEmployee(String firstName, String lastName, String nationalId, 
                                   String gender, LocalDate dob, String email, String password, 
                                   String userName, BigDecimal salary, String role) {
        
        // Check if username, email, or national ID already exists
        if (employeeRepository.existsByUserName(userName)) {
            throw new RuntimeException("Username already exists");
        }
        
        if (employeeRepository.existsByEmail(email)) {
            throw new RuntimeException("Email already exists");
        }
        
        if (employeeRepository.existsByNationalId(nationalId)) {
            throw new RuntimeException("National ID already exists");
        }
        
        try {
            // Create and save employee using standard JPA
            Employee employee = new Employee();
            employee.setFirstName(firstName);
            employee.setLastName(lastName);
            employee.setNationalId(nationalId);
            employee.setGender(gender);
            employee.setDob(dob);
            employee.setEmail(email);
            employee.setPassword(password);
            employee.setUserName(userName);
            employee.setSalary(salary);
            
            // Save the employee first
            Employee savedEmployee = employeeRepository.save(employee);
            Integer employeeId = savedEmployee.getId();
            
            // Create role-specific record using custom queries
            if ("pharmacist".equalsIgnoreCase(role)) {
                pharmacistRepository.savePharmacist(employeeId);
                return savedEmployee;
            } else if ("lab-technician".equalsIgnoreCase(role)) {
                labTechnicianRepository.saveLabTechnician(employeeId);
                return savedEmployee;
            }
            
            throw new RuntimeException("Invalid role specified");
            
        } catch (Exception e) {
            throw new RuntimeException("Registration failed: " + e.getMessage());
        }
    }

    /**
     * Validate registration data
     */
    public String validateRegistrationData(String firstName, String lastName, String nationalId, 
                                         String gender, LocalDate dob, String email, 
                                         String password, String userName, String role) {
        
        if (firstName == null || firstName.trim().isEmpty()) {
            return "First name is required";
        }
        
        if (lastName == null || lastName.trim().isEmpty()) {
            return "Last name is required";
        }
        
        if (nationalId == null || nationalId.trim().isEmpty()) {
            return "National ID is required";
        }
        
        if (gender == null || gender.trim().isEmpty()) {
            return "Gender is required";
        }
        
        if (dob == null) {
            return "Date of birth is required";
        }
        
        if (email == null || email.trim().isEmpty() || !email.contains("@")) {
            return "Valid email is required";
        }
        
        if (password == null || password.length() < 6) {
            return "Password must be at least 6 characters long";
        }
        
        if (userName == null || userName.trim().isEmpty()) {
            return "Username is required";
        }
        
        if (role == null || (!role.equalsIgnoreCase("pharmacist") && !role.equalsIgnoreCase("lab-technician"))) {
            return "Valid role (pharmacist or lab-technician) is required";
        }
        
        // Check age constraints (must be at least 18)
        LocalDate eighteenYearsAgo = LocalDate.now().minusYears(18);
        if (dob.isAfter(eighteenYearsAgo)) {
            return "Must be at least 18 years old";
        }
        
        return null; // No validation errors
    }

    /**
     * Get employee by username
     */
    public Optional<Employee> findByUsername(String username) {
        return employeeRepository.findByUserName(username);
    }

    /**
     * Get employee by email
     */
    public Optional<Employee> findByEmail(String email) {
        return employeeRepository.findByEmail(email);
    }

    /**
     * Check if employee exists by ID
     */
    public boolean employeeExists(Integer id) {
        return employeeRepository.findById(id).isPresent();
    }

    /**
     * Get employee role
     */
    public String getEmployeeRole(Integer employeeId) {
        if (pharmacistRepository.existsById(employeeId)) {
            return "pharmacist";
        } else if (labTechnicianRepository.existsById(employeeId)) {
            return "lab-technician";
        }
        return "unknown";
    }
}
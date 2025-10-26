package com.medicalportal.medicalportal.service.admin;

import com.medicalportal.medicalportal.repository.admin.Admin_EmployeeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class Admin_EmployeeService {
    private static final Logger logger = LoggerFactory.getLogger(Admin_EmployeeService.class);
    private final Admin_EmployeeRepository employeeRepository;

    public Admin_EmployeeService(Admin_EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    public List<Map<String, Object>> getAllEmployees() {
        try {
            return employeeRepository.findAllEmployeesExcludingDoctorsAndAdmins();
        } catch (Exception e) {
            logger.error("Error retrieving employees: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load employees", e);
        }
    }

    public Optional<Map<String, Object>> getEmployeeById(Integer eid) {
        try {
            return employeeRepository.findEmployeeByIdExcludingDoctorsAndAdmins(eid);
        } catch (Exception e) {
            logger.error("Error retrieving employee with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to load employee", e);
        }
    }

    @Transactional
    public void addEmployee(String firstName, String lastName, String email, String gender,
                           LocalDate dob, BigDecimal salary, String phone, String nationalId,
                           String userName, String role, String password) {
        try {
            // Validate unique fields
            if (employeeRepository.existsByUserName(userName)) {
                throw new RuntimeException("Username is already taken");
            }
            
            if (employeeRepository.existsByEmail(email)) {
                throw new RuntimeException("Email is already registered");
            }
            
            // Generate next employee ID
            Integer nextEid = employeeRepository.getNextEmployeeId();
            
            // Insert employee record (store hashed password)
            employeeRepository.insertEmployee(nextEid, firstName, lastName, email, gender, dob, 
                                            salary, nationalId, userName, "ACTIVE", com.medicalportal.medicalportal.util.PasswordUtil.hash(password));
            
            // Insert role-specific record
            insertRoleSpecificRecord(nextEid, role);
            
            // Insert phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                employeeRepository.insertPhoneNumber(nextEid, phone.trim());
            }
            
            logger.info("Added new employee with eid: {} and role: {}", nextEid, role);
        } catch (Exception e) {
            logger.error("Error adding new employee: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to add employee: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void updateEmployee(Integer eid, String firstName, String lastName, String email, String gender,
                              LocalDate dob, BigDecimal salary, String phone, String nationalId, String userName,
                              String status, String newRole, String password) {
        try {
            // Validate unique fields for updates
            if (employeeRepository.existsByUserNameAndEidNot(userName, eid)) {
                throw new RuntimeException("Username is already taken");
            }
            
            if (employeeRepository.existsByEmailAndEidNot(email, eid)) {
                throw new RuntimeException("Email is already registered");
            }
            
            // Get current role
            String currentRole = employeeRepository.getEmployeeRole(eid);
            
            // Update employee information
            employeeRepository.updateEmployee(eid, firstName, lastName, email, gender, dob, 
                                            salary, nationalId, userName, status);
            
            // Update role if changed
            if (!currentRole.equals(newRole)) {
                // Delete old role record
                deleteRoleSpecificRecord(eid, currentRole);
                // Insert new role record
                insertRoleSpecificRecord(eid, newRole);
            }
            
            // Update phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                employeeRepository.deletePhoneNumbersByEid(eid);
                employeeRepository.insertPhoneNumber(eid, phone.trim());
            }
            
            // Update password if provided
            if (password != null && !password.trim().isEmpty()) {
                employeeRepository.updateEmployeePassword(eid, com.medicalportal.medicalportal.util.PasswordUtil.hash(password.trim()));
            }
            
            logger.info("Updated employee with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error updating employee with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to update employee: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void disableEmployee(Integer eid) {
        try {
            employeeRepository.disableEmployee(eid);
            logger.info("Disabled employee with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error disabling employee with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to disable employee", e);
        }
    }

    @Transactional
    public void enableEmployee(Integer eid) {
        try {
            employeeRepository.enableEmployee(eid);
            logger.info("Enabled employee with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error enabling employee with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to enable employee", e);
        }
    }

    @Transactional
    public void deleteEmployee(Integer eid) {
        try {
            // Get current role to delete role-specific record
            String currentRole = employeeRepository.getEmployeeRole(eid);
            
            // Delete role-specific record first
            deleteRoleSpecificRecord(eid, currentRole);
            
            // Delete phone numbers
            employeeRepository.deletePhoneNumbersByEid(eid);
            
            // Delete employee record
            employeeRepository.deleteEmployeeRecord(eid);
            
            logger.info("Successfully deleted employee with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error deleting employee with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to delete employee", e);
        }
    }

    public List<String> getPhoneNumbersByEid(Integer eid) {
        return employeeRepository.findPhoneNumbersByEid(eid);
    }

    private void insertRoleSpecificRecord(Integer eid, String role) {
        switch (role) {
            case "Receptionist":
                employeeRepository.insertReceptionist(eid);
                break;
            case "Lab Technician":
                employeeRepository.insertLabTechnician(eid);
                break;
            case "Pharmacist":
                employeeRepository.insertPharmacist(eid);
                break;
            case "Finance Admin":
                employeeRepository.insertFinanceAdmin(eid);
                break;
            default:
                logger.warn("Unknown role: {}, no role-specific record created", role);
        }
    }

    private void deleteRoleSpecificRecord(Integer eid, String role) {
        switch (role) {
            case "Receptionist":
                employeeRepository.deleteReceptionist(eid);
                break;
            case "Lab Technician":
                employeeRepository.deleteLabTechnician(eid);
                break;
            case "Pharmacist":
                employeeRepository.deletePharmacist(eid);
                break;
            case "Finance Admin":
                employeeRepository.deleteFinanceAdmin(eid);
                break;
            default:
                logger.warn("Unknown role: {}, no role-specific record deleted", role);
        }
    }
}

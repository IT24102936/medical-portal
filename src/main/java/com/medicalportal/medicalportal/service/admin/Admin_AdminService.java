package com.medicalportal.medicalportal.service.admin;

import com.medicalportal.medicalportal.entity.admin.Admin_Doctor;
import com.medicalportal.medicalportal.repository.admin.Admin_DoctorRepository;
import com.medicalportal.medicalportal.repository.admin.Admin_EmployeeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
public class Admin_AdminService {
    private static final Logger logger = LoggerFactory.getLogger(Admin_AdminService.class);
    private final Admin_DoctorRepository doctorRepository;
    private final Admin_EmployeeRepository employeeRepository;

    public Admin_AdminService(Admin_DoctorRepository doctorRepository, Admin_EmployeeRepository employeeRepository) {
        this.doctorRepository = doctorRepository;
        this.employeeRepository = employeeRepository;
    }

    public List<Admin_Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    public Admin_Doctor getDoctorById(Integer eid) {
        return doctorRepository.findById(eid).orElse(null);
    }

    @Transactional
    public void addDoctor(String firstName, String lastName, String email, String gender, LocalDate dob,
                         BigDecimal salary, String phone, String nationalId, String userName, String specialization, String password) {
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
            
            // Insert employee record (no password encoding since we removed Spring Security)
            employeeRepository.insertEmployee(nextEid, firstName, lastName, email, gender, dob, 
                                            salary, nationalId, userName, "ACTIVE", password);
            
            // Insert doctor record
            doctorRepository.insertDoctor(nextEid, specialization);
            
            // Insert phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                employeeRepository.insertPhoneNumber(nextEid, phone.trim());
            }
            
            logger.info("Successfully added new doctor with eid: {}", nextEid);
        } catch (Exception e) {
            logger.error("Error adding doctor: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to add doctor: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void editDoctor(Integer eid, String firstName, String lastName, String email, String gender, LocalDate dob,
                          BigDecimal salary, String phone, String nationalId, String userName, String status, String specialization, String password) {
        try {
            // Validate unique fields for updates
            if (employeeRepository.existsByUserNameAndEidNot(userName, eid)) {
                throw new RuntimeException("Username is already taken");
            }
            
            if (employeeRepository.existsByEmailAndEidNot(email, eid)) {
                throw new RuntimeException("Email is already registered");
            }
            
            // Update employee and doctor information
            doctorRepository.editDoctor(eid, firstName, lastName, email, gender, dob, 
                                       salary, nationalId, userName, status, specialization);
            
            // Update phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                employeeRepository.deletePhoneNumbersByEid(eid);
                employeeRepository.insertPhoneNumber(eid, phone.trim());
            }
            
            // Update password if provided
            if (password != null && !password.trim().isEmpty()) {
                employeeRepository.updateEmployeePassword(eid, password.trim());
            }
            
            logger.info("Successfully updated doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error updating doctor with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to update doctor: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void disableDoctor(Integer eid) {
        try {
            doctorRepository.disableDoctor(eid);
            logger.info("Successfully disabled doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error disabling doctor with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to disable doctor", e);
        }
    }

    @Transactional
    public void enableDoctor(Integer eid) {
        try {
            doctorRepository.enableDoctor(eid);
            logger.info("Successfully enabled doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error enabling doctor with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to enable doctor", e);
        }
    }

    @Transactional
    public void deleteDoctor(Integer eid) {
        try {
            // Delete in order to handle foreign key constraints
            doctorRepository.deleteDoctorPatientCheckup(eid);
            doctorRepository.deleteDoctorIssuesPrescription(eid);
            doctorRepository.deleteDoctorIssuesLabOrder(eid);
            doctorRepository.deleteDoctorViewsAppointment(eid);
            doctorRepository.deleteDoctorViewsReport(eid);
            doctorRepository.deleteDoctorRecord(eid);
            employeeRepository.deletePhoneNumbersByEid(eid);
            employeeRepository.deleteEmployeeRecord(eid);
            
            logger.info("Successfully deleted doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error deleting doctor with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to delete doctor", e);
        }
    }
}

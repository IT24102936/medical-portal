package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.repository.DoctorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
public class AdminService {
    private static final Logger logger = LoggerFactory.getLogger(AdminService.class);
    private final DoctorRepository doctorRepository;
    private final PasswordEncoder passwordEncoder;

    public AdminService(DoctorRepository doctorRepository, PasswordEncoder passwordEncoder) {
        this.doctorRepository = doctorRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public List<Doctor> getAllDoctors() {
        try {
            return doctorRepository.findAll();
        } catch (Exception e) {
            logger.error("Error retrieving doctors: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load doctors", e);
        }
    }

    @Transactional
    public void disableDoctor(Integer eid) {
        try {
            doctorRepository.disableDoctor(eid);
            logger.info("Disabled doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error disabling doctor with eid {}: {}", eid, e.getMessage(), e);
            throw e;
        }
    }

    @Transactional
    public void enableDoctor(Integer eid) {
        try {
            doctorRepository.enableDoctor(eid);
            logger.info("Enabled doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error enabling doctor with eid {}: {}", eid, e.getMessage(), e);
            throw e;
        }
    }

    @Transactional
    public void editDoctor(Integer eid, String firstName, String lastName, String email, String gender,
                           LocalDate dob, BigDecimal salary, String phone, String nationalId, String userName,
                           String status, String specialization, String password) {
        try {
            // Update doctor and employee information
            doctorRepository.editDoctor(eid, firstName, lastName, email, gender, dob, salary, nationalId, userName, status, specialization);

            // Update phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                // Delete existing phone numbers
                doctorRepository.deletePhoneNumbersByEid(eid);
                // Insert new phone number
                doctorRepository.insertPhoneNumber(eid, phone.trim());
            }

            // Update password if provided (encode it before saving)
            if (password != null && !password.trim().isEmpty()) {
                String encodedPassword = passwordEncoder.encode(password.trim());
                doctorRepository.updateEmployeePassword(eid, encodedPassword);
            }

            logger.info("Edited doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error editing doctor with eid {}: {}", eid, e.getMessage(), e);
            throw e;
        }
    }

    @Transactional
    public void deleteDoctor(Integer eid) {
        try {
            // Delete in the correct order to avoid foreign key constraint violations
            // 1. Delete all relationship records first (junction tables)
            doctorRepository.deleteDoctorPatientCheckup(eid);
            doctorRepository.deleteDoctorIssuesPrescription(eid);
            doctorRepository.deleteDoctorIssuesLabOrder(eid);
            doctorRepository.deleteDoctorViewsAppointment(eid);
            doctorRepository.deleteDoctorViewsReport(eid);
            
            // 2. Delete phone numbers (though CASCADE should handle this)
            doctorRepository.deleteEmployeePhones(eid);
            
            // 3. Delete doctor record
            doctorRepository.deleteDoctorRecord(eid);
            
            // 4. Finally delete employee record
            doctorRepository.deleteEmployeeRecord(eid);
            
            logger.info("Successfully deleted doctor with eid: {}", eid);
        } catch (Exception e) {
            logger.error("Error deleting doctor with eid {}: {}", eid, e.getMessage(), e);
            throw new RuntimeException("Failed to delete doctor: " + e.getMessage(), e);
        }
    }

    public List<String> getPhoneNumbersByEid(Integer eid) {
        return doctorRepository.findPhoneNumbersByEid(eid);
    }

    @Transactional
    public void addDoctor(String firstName, String lastName, String email, String gender,
                          LocalDate dob, BigDecimal salary, String phone, String nationalId,
                          String userName, String specialization, String password) {
        try {
            // Generate next employee ID
            Integer nextEid = doctorRepository.getNextEmployeeId();
            
            // Encode password
            String encodedPassword = passwordEncoder.encode(password);
            
            // Insert employee record
            doctorRepository.insertEmployee(nextEid, firstName, lastName, email, gender, dob, 
                                          salary, nationalId, userName, "ACTIVE", encodedPassword);
            
            // Insert doctor record
            doctorRepository.insertDoctor(nextEid, specialization);
            
            // Insert phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                doctorRepository.insertPhoneNumber(nextEid, phone.trim());
            }
            
            logger.info("Added new doctor with eid: {}", nextEid);
        } catch (Exception e) {
            logger.error("Error adding new doctor: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to add doctor", e);
        }
    }
}
package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.repository.PatientRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class PatientService {
    private static final Logger logger = LoggerFactory.getLogger(PatientService.class);
    private final PatientRepository patientRepository;
    private final PasswordEncoder passwordEncoder;

    public PatientService(PatientRepository patientRepository, PasswordEncoder passwordEncoder) {
        this.patientRepository = patientRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public List<Map<String, Object>> getAllPatients() {
        try {
            return patientRepository.findAllPatientsWithPhones();
        } catch (Exception e) {
            logger.error("Error retrieving patients: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load patients", e);
        }
    }

    public Optional<Map<String, Object>> getPatientById(Integer pid) {
        try {
            return patientRepository.findPatientByIdWithPhones(pid);
        } catch (Exception e) {
            logger.error("Error retrieving patient with pid {}: {}", pid, e.getMessage(), e);
            throw new RuntimeException("Failed to load patient", e);
        }
    }

    @Transactional
    public void addPatient(String firstName, String lastName, String email, String gender, 
                          LocalDate dob, String phone, String nationalId, String userName, 
                          String password) {
        try {
            // Validate unique email
            if (patientRepository.existsByEmail(email)) {
                throw new RuntimeException("Email is already registered");
            }
            
            // Get next available patient ID
            Integer nextPid = patientRepository.getNextPatientId();
            
            // Encode password
            String encodedPassword = passwordEncoder.encode(password);
            
            // Insert patient record (note: username is not in the schema, so we're not using it)
            patientRepository.insertPatient(nextPid, firstName, lastName, email, gender, 
                                          dob, nationalId, encodedPassword);
            
            // Insert phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                patientRepository.insertPhoneNumber(nextPid, phone.trim());
            }
            
            logger.info("Successfully added new patient with pid: {}", nextPid);
        } catch (Exception e) {
            logger.error("Error adding patient: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to add patient: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void updatePatient(Integer pid, String firstName, String lastName, String email, 
                            String gender, LocalDate dob, String phone, String nationalId, 
                            String userName) {
        try {
            // Validate unique email for updates
            if (patientRepository.existsByEmailAndPatientIdNot(email, pid)) {
                throw new RuntimeException("Email is already registered");
            }
            
            // Update patient basic information (note: username is not in the schema, so we're not using it)
            patientRepository.updatePatient(pid, firstName, lastName, email, gender, 
                                          dob, nationalId);
            
            // Update phone number if provided
            if (phone != null && !phone.trim().isEmpty()) {
                // Delete existing phone numbers
                patientRepository.deletePatientPhones(pid);
                // Insert new phone number
                patientRepository.insertPhoneNumber(pid, phone.trim());
            }
            
            logger.info("Successfully updated patient with pid: {}", pid);
        } catch (Exception e) {
            logger.error("Error updating patient with pid {}: {}", pid, e.getMessage(), e);
            throw new RuntimeException("Failed to update patient: " + e.getMessage(), e);
        }
    }

    @Transactional
    public void disablePatient(Integer pid) {
        try {
            patientRepository.disablePatient(pid);
            logger.info("Disabled patient with pid: {}", pid);
        } catch (Exception e) {
            logger.error("Error disabling patient with pid {}: {}", pid, e.getMessage(), e);
            throw new RuntimeException("Failed to disable patient", e);
        }
    }

    @Transactional
    public void enablePatient(Integer pid) {
        try {
            patientRepository.enablePatient(pid);
            logger.info("Enabled patient with pid: {}", pid);
        } catch (Exception e) {
            logger.error("Error enabling patient with pid {}: {}", pid, e.getMessage(), e);
            throw new RuntimeException("Failed to enable patient", e);
        }
    }

    @Transactional
    public void deletePatient(Integer pid) {
        try {
            // Delete in order to handle foreign key constraints
            patientRepository.deletePatientCheckups(pid);
            patientRepository.deletePatientPrescriptions(pid);
            patientRepository.deletePatientLabOrders(pid);
            patientRepository.deletePatientReports(pid);
            patientRepository.deletePatientAppointments(pid);
            patientRepository.deletePatientPhones(pid);
            patientRepository.deletePatientRecord(pid);
            
            logger.info("Successfully deleted patient with pid: {}", pid);
        } catch (Exception e) {
            logger.error("Error deleting patient with pid {}: {}", pid, e.getMessage(), e);
            throw new RuntimeException("Failed to delete patient", e);
        }
    }

    public List<String> getPhoneNumbersByPid(Integer pid) {
        try {
            return patientRepository.getPhoneNumbersByPid(pid);
        } catch (Exception e) {
            logger.error("Error retrieving phone numbers for patient with pid {}: {}", pid, e.getMessage(), e);
            throw new RuntimeException("Failed to load phone numbers", e);
        }
    }
}

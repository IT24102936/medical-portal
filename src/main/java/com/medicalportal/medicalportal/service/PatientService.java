package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Patient;
import com.medicalportal.medicalportal.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PatientService {
    
    @Autowired
    private PatientRepository patientRepository;
    
    // Save or update patient
    public Patient savePatient(Patient patient) {
        patient.setLastVisit(LocalDateTime.now());
        return patientRepository.save(patient);
    }
    
    // Get all patients
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }
    
    // Get patient by ID
    public Optional<Patient> getPatientById(Long id) {
        return patientRepository.findById(id);
    }
    
    // Get patient by email
    public Patient getPatientByEmail(String email) {
        return patientRepository.findByEmail(email);
    }
    
    // Get patient by national ID
    public Patient getPatientByNationalId(String nationalId) {
        return patientRepository.findByNationalId(nationalId);
    }
    
    // Search patients by name
    public List<Patient> searchPatientsByName(String name) {
        return patientRepository.findByFullNameContaining(name);
    }
    
    // Search patients by first name
    public List<Patient> searchPatientsByFirstName(String firstName) {
        return patientRepository.findByFirstNameContainingIgnoreCase(firstName);
    }
    
    // Search patients by last name
    public List<Patient> searchPatientsByLastName(String lastName) {
        return patientRepository.findByLastNameContainingIgnoreCase(lastName);
    }
    
    // Get patients by gender
    public List<Patient> getPatientsByGender(String gender) {
        return patientRepository.findByGender(gender);
    }
    
    // Delete patient
    public void deletePatient(Long id) {
        patientRepository.deleteById(id);
    }
    
    // Update patient
    public Patient updatePatient(Patient patient) {
        return patientRepository.save(patient);
    }
    
    // Check if patient exists by email
    public boolean existsByEmail(String email) {
        return patientRepository.findByEmail(email) != null;
    }
    
    // Check if patient exists by national ID
    public boolean existsByNationalId(String nationalId) {
        return patientRepository.findByNationalId(nationalId) != null;
    }
}

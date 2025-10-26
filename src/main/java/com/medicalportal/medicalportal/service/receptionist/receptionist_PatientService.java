package com.medicalportal.medicalportal.service.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Patient;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class receptionist_PatientService {
    
    @Autowired
    private receptionist_PatientRepository patientRepository;
    
    // Save or update patient
    public receptionist_Patient savePatient(receptionist_Patient patient) {
        return patientRepository.save(patient);
    }
    
    // Get all patients
    public List<receptionist_Patient> getAllPatients() {
        return patientRepository.findAll();
    }
    
    // Get patient by ID
    public Optional<receptionist_Patient> getPatientById(Integer id) {
        return patientRepository.findById(id);
    }
    
    // Get patient by email
    public receptionist_Patient getPatientByEmail(String email) {
        return patientRepository.findByEmail(email);
    }
    
    // Get patient by national ID
    public receptionist_Patient getPatientByNationalId(String nationalId) {
        return patientRepository.findByNationalId(nationalId);
    }
    
    // Search patients by name
    public List<receptionist_Patient> searchPatientsByName(String name) {
        return patientRepository.findByFullNameContaining(name);
    }
    
    // Search patients by first name
    public List<receptionist_Patient> searchPatientsByFirstName(String firstName) {
        return patientRepository.findByFirstNameContainingIgnoreCase(firstName);
    }
    
    // Search patients by last name
    public List<receptionist_Patient> searchPatientsByLastName(String lastName) {
        return patientRepository.findByLastNameContainingIgnoreCase(lastName);
    }
    
    // Get patients by gender
    public List<receptionist_Patient> getPatientsByGender(String gender) {
        return patientRepository.findByGender(gender);
    }
    
    // Delete patient
    public void deletePatient(Integer id) {
        patientRepository.deleteById(id);
    }
    
    // Update patient
    public receptionist_Patient updatePatient(receptionist_Patient patient) {
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

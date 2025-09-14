package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
    
    // Find patients by first name (case insensitive)
    List<Patient> findByFirstNameContainingIgnoreCase(String firstName);
    
    // Find patients by last name (case insensitive)
    List<Patient> findByLastNameContainingIgnoreCase(String lastName);
    
    // Find patients by email
    Patient findByEmail(String email);
    
    // Find patients by national ID
    Patient findByNationalId(String nationalId);
    
    // Find patients by full name
    @Query("SELECT p FROM Patient p WHERE CONCAT(p.firstName, ' ', p.lastName) LIKE %:fullName%")
    List<Patient> findByFullNameContaining(String fullName);
    
    // Find patients by gender
    List<Patient> findByGender(String gender);
    
    // Find patients by address containing
    List<Patient> findByAddressContainingIgnoreCase(String address);
}

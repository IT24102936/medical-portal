package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.Lab_Phar_Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_PatientRepository extends JpaRepository<Lab_Phar_Patient, Integer> {
    
    // Find patient by ID
    @Query("SELECT p FROM Lab_Phar_Patient p WHERE p.id = :id")
    Optional<Lab_Phar_Patient> findById(@Param("id") Integer id);
    
    // Find all patients
    @Query("SELECT p FROM Lab_Phar_Patient p ORDER BY p.firstName, p.lastName")
    List<Lab_Phar_Patient> findAll();
    
    // Check if patient exists by ID
    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Lab_Phar_Patient p WHERE p.id = :id")
    boolean existsById(@Param("id") Integer id);
}
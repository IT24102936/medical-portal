package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PatientRepository extends JpaRepository<Patient, Integer> {
    
    // Find patient by ID
    @Query("SELECT p FROM Patient p WHERE p.id = :id")
    Optional<Patient> findById(@Param("id") Integer id);
    
    // Find all patients
    @Query("SELECT p FROM Patient p ORDER BY p.firstName, p.lastName")
    List<Patient> findAll();
    
    // Check if patient exists by ID
    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Patient p WHERE p.id = :id")
    boolean existsById(@Param("id") Integer id);
}
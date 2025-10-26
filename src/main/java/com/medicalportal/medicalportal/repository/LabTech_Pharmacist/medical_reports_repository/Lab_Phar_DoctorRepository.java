package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_DoctorRepository extends JpaRepository<Lab_Phar_Doctor, Integer> {
    
    // Find all doctors
    @Query("SELECT d FROM Lab_Phar_Doctor d ORDER BY d.id")
    List<Lab_Phar_Doctor> findAll();
    
    // Find doctor by ID
    @Query("SELECT d FROM Lab_Phar_Doctor d WHERE d.id = :id")
    Optional<Lab_Phar_Doctor> findById(@Param("id") Integer id);
    
    // Check if doctor exists by ID
    @Query("SELECT CASE WHEN COUNT(d) > 0 THEN true ELSE false END FROM Lab_Phar_Doctor d WHERE d.id = :id")
    boolean existsById(@Param("id") Integer id);
}
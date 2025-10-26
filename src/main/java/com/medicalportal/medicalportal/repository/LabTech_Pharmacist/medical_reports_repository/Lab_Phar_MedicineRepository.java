package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_MedicineRepository extends JpaRepository<Lab_Phar_Medicine, String> {
    
    // Find all medicines
    @Query("SELECT m FROM Lab_Phar_Medicine m ORDER BY m.name")
    List<Lab_Phar_Medicine> findAll();
    
    // Find medicine by code (ID)
    @Query("SELECT m FROM Lab_Phar_Medicine m WHERE m.medicineCode = :medicineCode")
    Optional<Lab_Phar_Medicine> findById(@Param("medicineCode") String medicineCode);
    
    // Check if medicine exists by code
    @Query("SELECT CASE WHEN COUNT(m) > 0 THEN true ELSE false END FROM Lab_Phar_Medicine m WHERE m.medicineCode = :medicineCode")
    boolean existsById(@Param("medicineCode") String medicineCode);
    
    // Find medicine by name (case-insensitive)
    @Query("SELECT m FROM Lab_Phar_Medicine m WHERE LOWER(m.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Lab_Phar_Medicine> findByNameContainingIgnoreCase(@Param("name") String name);
}
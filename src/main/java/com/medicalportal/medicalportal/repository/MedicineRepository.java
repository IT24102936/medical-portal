package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface MedicineRepository extends JpaRepository<Medicine, String> {
    
    // Find all medicines
    @Query("SELECT m FROM Medicine m ORDER BY m.name")
    List<Medicine> findAll();
    
    // Find medicine by code (ID)
    @Query("SELECT m FROM Medicine m WHERE m.medicineCode = :medicineCode")
    Optional<Medicine> findById(@Param("medicineCode") String medicineCode);
    
    // Check if medicine exists by code
    @Query("SELECT CASE WHEN COUNT(m) > 0 THEN true ELSE false END FROM Medicine m WHERE m.medicineCode = :medicineCode")
    boolean existsById(@Param("medicineCode") String medicineCode);
    
    // Find medicine by name (case-insensitive)
    @Query("SELECT m FROM Medicine m WHERE LOWER(m.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Medicine> findByNameContainingIgnoreCase(@Param("name") String name);
}
package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Pharmacist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_PharmacistRepository extends JpaRepository<Lab_Phar_Pharmacist, Integer> {
    
    // Find all pharmacists
    @Query("SELECT ph FROM Lab_Phar_Pharmacist ph ORDER BY ph.id")
    List<Lab_Phar_Pharmacist> findAll();
    
    // Find pharmacist by ID
    @Query("SELECT ph FROM Lab_Phar_Pharmacist ph WHERE ph.id = :id")
    Optional<Lab_Phar_Pharmacist> findById(@Param("id") Integer id);
    
    // Check if pharmacist exists by ID
    @Query("SELECT CASE WHEN COUNT(ph) > 0 THEN true ELSE false END FROM Lab_Phar_Pharmacist ph WHERE ph.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Custom insert for pharmacist record
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO pharmacist (eid) VALUES (:eid)", nativeQuery = true)
    void savePharmacist(@Param("eid") Integer eid);
}
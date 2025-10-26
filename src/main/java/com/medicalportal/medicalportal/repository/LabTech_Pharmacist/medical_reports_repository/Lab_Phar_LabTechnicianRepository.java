package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_LabTechnician;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_LabTechnicianRepository extends JpaRepository<Lab_Phar_LabTechnician, Integer> {
    
    // Find all lab technicians
    @Query("SELECT lt FROM Lab_Phar_LabTechnician lt ORDER BY lt.id")
    List<Lab_Phar_LabTechnician> findAll();
    
    // Find lab technician by ID
    @Query("SELECT lt FROM Lab_Phar_LabTechnician lt WHERE lt.id = :id")
    Optional<Lab_Phar_LabTechnician> findById(@Param("id") Integer id);
    
    // Check if lab technician exists by ID
    @Query("SELECT CASE WHEN COUNT(lt) > 0 THEN true ELSE false END FROM Lab_Phar_LabTechnician lt WHERE lt.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Custom insert for lab technician record
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO lab_technician (eid) VALUES (:eid)", nativeQuery = true)
    void saveLabTechnician(@Param("eid") Integer eid);
}
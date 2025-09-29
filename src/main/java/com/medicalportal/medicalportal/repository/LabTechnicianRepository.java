package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.LabTechnician;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface LabTechnicianRepository extends JpaRepository<LabTechnician, Integer> {
    
    // Find all lab technicians
    @Query("SELECT lt FROM LabTechnician lt ORDER BY lt.id")
    List<LabTechnician> findAll();
    
    // Find lab technician by ID
    @Query("SELECT lt FROM LabTechnician lt WHERE lt.id = :id")
    Optional<LabTechnician> findById(@Param("id") Integer id);
    
    // Check if lab technician exists by ID
    @Query("SELECT CASE WHEN COUNT(lt) > 0 THEN true ELSE false END FROM LabTechnician lt WHERE lt.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Custom insert for lab technician record
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO lab_technician (eid) VALUES (:eid)", nativeQuery = true)
    void saveLabTechnician(@Param("eid") Integer eid);
}
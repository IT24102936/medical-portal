package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_LabOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_LabOrderRepository extends JpaRepository<Lab_Phar_LabOrder, Integer> {
    
    // Find all lab orders
    @Query("SELECT lo FROM Lab_Phar_LabOrder lo ORDER BY lo.id")
    List<Lab_Phar_LabOrder> findAll();
    
    // Find lab order by ID
    @Query("SELECT lo FROM Lab_Phar_LabOrder lo WHERE lo.id = :id")
    Optional<Lab_Phar_LabOrder> findById(@Param("id") Integer id);
    
    // Check if lab order exists by ID
    @Query("SELECT CASE WHEN COUNT(lo) > 0 THEN true ELSE false END FROM Lab_Phar_LabOrder lo WHERE lo.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Insert new lab order
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO lab_order (description) VALUES (:description)", nativeQuery = true)
    void insertLabOrder(@Param("description") String description);
    
    // Get last inserted ID
    @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
    Integer getLastInsertedId();
    
    // Update lab order
    @Modifying
    @Transactional
    @Query("UPDATE Lab_Phar_LabOrder lo SET lo.description = :description WHERE lo.id = :id")
    void updateLabOrder(@Param("id") Integer id, @Param("description") String description);
    
    // Delete lab order by ID
    @Modifying
    @Transactional
    @Query("DELETE FROM Lab_Phar_LabOrder lo WHERE lo.id = :id")
    void deleteById(@Param("id") Integer id);
}
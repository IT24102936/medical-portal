package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface PrescriptionRepository extends JpaRepository<Prescription, Integer> {
    
    // Find all prescriptions
    @Query("SELECT p FROM Prescription p ORDER BY p.id DESC")
    List<Prescription> findAll();
    
    // Find prescription by ID
    @Query("SELECT p FROM Prescription p WHERE p.id = :id")
    Optional<Prescription> findById(@Param("id") Integer id);
    
    // Check if prescription exists by ID
    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Prescription p WHERE p.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Count total prescriptions
    @Query("SELECT COUNT(p) FROM Prescription p")
    long count();
    
    // Insert new prescription (simplified for description-only table)
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO prescription (description) VALUES (:description)", nativeQuery = true)
    void insertPrescription(@Param("description") String description);
    
    // Get last inserted ID
    @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
    Integer getLastInsertedId();
    
    // Update prescription (only description is available in entity)
    @Modifying
    @Transactional
    @Query("UPDATE Prescription p SET p.description = :description WHERE p.id = :id")
    void updatePrescription(@Param("id") Integer id, 
                           @Param("description") String description);
    
    // Delete prescription by ID
    @Modifying
    @Transactional
    @Query("DELETE FROM Prescription p WHERE p.id = :id")
    void deleteById(@Param("id") Integer id);
}
package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.LabOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface LabOrderRepository extends JpaRepository<LabOrder, Integer> {
    
    // Find all lab orders
    @Query("SELECT lo FROM LabOrder lo ORDER BY lo.id")
    List<LabOrder> findAll();
    
    // Find lab order by ID
    @Query("SELECT lo FROM LabOrder lo WHERE lo.id = :id")
    Optional<LabOrder> findById(@Param("id") Integer id);
    
    // Check if lab order exists by ID
    @Query("SELECT CASE WHEN COUNT(lo) > 0 THEN true ELSE false END FROM LabOrder lo WHERE lo.id = :id")
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
    @Query("UPDATE LabOrder lo SET lo.description = :description WHERE lo.id = :id")
    void updateLabOrder(@Param("id") Integer id, @Param("description") String description);
    
    // Delete lab order by ID
    @Modifying
    @Transactional
    @Query("DELETE FROM LabOrder lo WHERE lo.id = :id")
    void deleteById(@Param("id") Integer id);
}
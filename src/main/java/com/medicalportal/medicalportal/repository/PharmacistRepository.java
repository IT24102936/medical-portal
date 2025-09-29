package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Pharmacist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface PharmacistRepository extends JpaRepository<Pharmacist, Integer> {
    
    // Find all pharmacists
    @Query("SELECT ph FROM Pharmacist ph ORDER BY ph.id")
    List<Pharmacist> findAll();
    
    // Find pharmacist by ID
    @Query("SELECT ph FROM Pharmacist ph WHERE ph.id = :id")
    Optional<Pharmacist> findById(@Param("id") Integer id);
    
    // Check if pharmacist exists by ID
    @Query("SELECT CASE WHEN COUNT(ph) > 0 THEN true ELSE false END FROM Pharmacist ph WHERE ph.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Custom insert for pharmacist record
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO pharmacist (eid) VALUES (:eid)", nativeQuery = true)
    void savePharmacist(@Param("eid") Integer eid);
}
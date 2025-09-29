package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface DoctorRepository extends JpaRepository<Doctor, Integer> {
    
    // Find all doctors
    @Query("SELECT d FROM Doctor d ORDER BY d.id")
    List<Doctor> findAll();
    
    // Find doctor by ID
    @Query("SELECT d FROM Doctor d WHERE d.id = :id")
    Optional<Doctor> findById(@Param("id") Integer id);
    
    // Check if doctor exists by ID
    @Query("SELECT CASE WHEN COUNT(d) > 0 THEN true ELSE false END FROM Doctor d WHERE d.id = :id")
    boolean existsById(@Param("id") Integer id);
}
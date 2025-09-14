package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long> {
    
    // Find doctors by specialization
    List<Doctor> findBySpecialization(String specialization);
    
    // Find available doctors
    List<Doctor> findByAvailable(Boolean available);
    
    // Find doctors by specialization and availability
    List<Doctor> findBySpecializationAndAvailable(String specialization, Boolean available);
}

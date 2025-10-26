package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface receptionist_DoctorRepository extends JpaRepository<receptionist_Doctor, Integer> {
    
    // Find doctors by specialization
    List<receptionist_Doctor> findBySpecialization(String specialization);
    
    // Find available doctors
    List<receptionist_Doctor> findByAvailable(Boolean available);
    
    // Find doctors by specialization and availability
    List<receptionist_Doctor> findBySpecializationAndAvailable(String specialization, Boolean available);
}

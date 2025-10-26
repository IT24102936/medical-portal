package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Receptionist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface receptionist_ReceptionistRepository extends JpaRepository<receptionist_Receptionist, Integer> {
    
    // Find receptionist by ID
    Optional<receptionist_Receptionist> findById(Integer id);
}

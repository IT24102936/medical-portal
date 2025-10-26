package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface receptionist_EmployeeRepository extends JpaRepository<receptionist_Employee, Integer> {
    
    // Find employee by ID
    Optional<receptionist_Employee> findById(Integer id);
    
    // Find employee by email
    Optional<receptionist_Employee> findByEmail(String email);
}

package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface receptionist_PatientRepository extends JpaRepository<receptionist_Patient, Integer> {
    
    // Find patients by first name (case insensitive)
    List<receptionist_Patient> findByFirstNameContainingIgnoreCase(String firstName);
    
    // Find patients by last name (case insensitive)
    List<receptionist_Patient> findByLastNameContainingIgnoreCase(String lastName);
    
    // Find patients by email
    receptionist_Patient findByEmail(String email);
    
    // Find patients by national ID
    receptionist_Patient findByNationalId(String nationalId);
    
    // Find patients by full name
    @Query("SELECT p FROM receptionist_Patient p WHERE CONCAT(p.firstName, ' ', p.lastName) LIKE %:fullName%")
    List<receptionist_Patient> findByFullNameContaining(String fullName);
    
    // Find patients by gender
    List<receptionist_Patient> findByGender(String gender);
    
    // Note: findByAddressContainingIgnoreCase removed due to CLOB type incompatibility
    // Use custom query if address search is needed
    @Query("SELECT p FROM receptionist_Patient p WHERE p.address LIKE %:address%")
    List<receptionist_Patient> findByAddressContaining(String address);
}

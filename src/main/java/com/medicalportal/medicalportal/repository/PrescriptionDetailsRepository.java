package com.medicalportal.medicalportal.repository;


import com.medicalportal.medicalportal.entity.PrescriptionDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PrescriptionDetailsRepository extends JpaRepository<PrescriptionDetails, Long> {

    // Find prescription details by description containing text (case-insensitive)
    List<PrescriptionDetails> findByDescriptionContainingIgnoreCase(String description);

    // Find prescription details with description longer than specified length
    @Query("SELECT pd FROM PrescriptionDetails pd WHERE LENGTH(pd.description) > :minLength")
    List<PrescriptionDetails> findByDescriptionLengthGreaterThan(@Param("minLength") int minLength);

    // Search prescription details by keyword in description
    @Query("SELECT pd FROM PrescriptionDetails pd WHERE LOWER(pd.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<PrescriptionDetails> searchByKeyword(@Param("keyword") String keyword);

    // Check if description exists (for validation)
    boolean existsByDescription(String description);

    // Find the latest prescription details
    Optional<PrescriptionDetails> findTopByOrderByIdDesc();

    // Count prescription details with descriptions containing specific text
    long countByDescriptionContainingIgnoreCase(String text);

    // Custom query to find prescription details with associated prescriptions
    @Query("SELECT pd FROM PrescriptionDetails pd WHERE pd.id IN " +
            "(SELECT p.prescriptionId FROM Prescription p WHERE p.doctorId = :doctorId)")
    List<PrescriptionDetails> findPrescriptionDetailsByDoctorId(@Param("doctorId") Long doctorId);

    // Custom query to find prescription details for a specific patient
    @Query("SELECT pd FROM PrescriptionDetails pd WHERE pd.id IN " +
            "(SELECT p.prescriptionId FROM Prescription p WHERE p.patientId = :patientId)")
    List<PrescriptionDetails> findPrescriptionDetailsByPatientId(@Param("patientId") Long patientId);
}


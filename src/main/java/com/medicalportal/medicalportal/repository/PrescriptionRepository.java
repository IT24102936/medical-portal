package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Prescription;
import com.medicalportal.medicalportal.entity.PrescriptionId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, PrescriptionId> {

    // Find all prescriptions by doctor ID
    @Query("SELECT p FROM Prescription p WHERE p.doctorId = :doctorId ORDER BY p.issueDate DESC")
    List<Prescription> findByDoctorId(@Param("doctorId") Long doctorId);

    // Find specific prescription by composite ID and doctor ID
    @Query("SELECT p FROM Prescription p WHERE p.prescriptionId = :prescriptionId AND p.doctorId = :doctorId")
    Optional<Prescription> findByPrescriptionIdAndDoctorId(@Param("prescriptionId") Long prescriptionId,
                                                           @Param("doctorId") Long doctorId);

    // Find by patient ID
    @Query("SELECT p FROM Prescription p WHERE p.patientId = :patientId ORDER BY p.issueDate DESC")
    List<Prescription> findByPatientId(@Param("patientId") Long patientId);

    // Find by date range
    @Query("SELECT p FROM Prescription p WHERE p.issueDate BETWEEN :startDate AND :endDate ORDER BY p.issueDate DESC")
    List<Prescription> findByIssueDateBetween(@Param("startDate") LocalDate startDate,
                                              @Param("endDate") LocalDate endDate);

    // Find by doctor ID and patient name (using patient entity)
    @Query("SELECT p FROM Prescription p WHERE p.doctorId = :doctorId AND " +
            "(p.patient.firstName LIKE %:name% OR p.patient.lastName LIKE %:name%)")
    List<Prescription> findByDoctorIdAndPatientNameContaining(@Param("doctorId") Long doctorId,
                                                              @Param("name") String name);
}



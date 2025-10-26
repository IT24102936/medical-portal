package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_MedicalReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface Lab_Phar_MedicalReportRepository extends JpaRepository<Lab_Phar_MedicalReport, Integer> {
    
    // Find all reports by patient ID
    @Query("SELECT mr FROM Lab_Phar_MedicalReport mr WHERE mr.patient.id = :patientId ORDER BY mr.reportDate DESC")
    List<Lab_Phar_MedicalReport> findByPatientId(@Param("patientId") Integer patientId);
    
    // Find reports by report type (case-insensitive search)
    @Query("SELECT mr FROM Lab_Phar_MedicalReport mr WHERE LOWER(mr.reportType) LIKE LOWER(CONCAT('%', :reportType, '%')) ORDER BY mr.reportDate DESC")
    List<Lab_Phar_MedicalReport> findByReportTypeContainingIgnoreCase(@Param("reportType") String reportType);
    
    // Find reports by date range
    @Query("SELECT mr FROM Lab_Phar_MedicalReport mr WHERE mr.reportDate BETWEEN :startDate AND :endDate ORDER BY mr.reportDate DESC")
    List<Lab_Phar_MedicalReport> findByReportDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
    
    // Find all reports ordered by date
    @Query("SELECT mr FROM Lab_Phar_MedicalReport mr ORDER BY mr.reportDate DESC")
    List<Lab_Phar_MedicalReport> findAllOrderedByDate();
    
    // Find medical report by ID
    @Query("SELECT mr FROM Lab_Phar_MedicalReport mr WHERE mr.id = :id")
    Optional<Lab_Phar_MedicalReport> findById(@Param("id") Integer id);
    
    // Check if medical report exists by ID
    @Query("SELECT CASE WHEN COUNT(mr) > 0 THEN true ELSE false END FROM Lab_Phar_MedicalReport mr WHERE mr.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Count total medical reports
    @Query("SELECT COUNT(mr) FROM Lab_Phar_MedicalReport mr")
    long count();
    
    // Delete medical report by ID
    @Modifying
    @Transactional
    @Query("DELETE FROM Lab_Phar_MedicalReport mr WHERE mr.id = :id")
    void deleteById(@Param("id") Integer id);
    
    // Save or update medical report (Insert new record)
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO medical_report (report_date, report_type, document_path, patient_id) VALUES (:reportDate, :reportType, :documentPath, :patientId)", nativeQuery = true)
    void insertMedicalReport(@Param("reportDate") LocalDate reportDate, 
                            @Param("reportType") String reportType, 
                            @Param("documentPath") String documentPath, 
                            @Param("patientId") Integer patientId);
    
    // Update existing medical report
    @Modifying
    @Transactional
    @Query("UPDATE Lab_Phar_MedicalReport mr SET mr.reportType = :reportType, mr.documentPath = :documentPath, mr.patient.id = :patientId WHERE mr.id = :id")
    void updateMedicalReport(@Param("id") Integer id, 
                            @Param("reportType") String reportType, 
                            @Param("documentPath") String documentPath, 
                            @Param("patientId") Integer patientId);
    
    // Get last inserted ID for new medical reports
    @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
    Integer getLastInsertedId();
}
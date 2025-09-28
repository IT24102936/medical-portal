package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.MedicalReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface MedicalReportRepository extends JpaRepository<MedicalReport, Integer> {
    
    // Find all reports by patient ID
    @Query("SELECT mr FROM MedicalReport mr WHERE mr.patient.id = :patientId ORDER BY mr.reportDate DESC")
    List<MedicalReport> findByPatientId(@Param("patientId") Integer patientId);
    
    // Find reports by report type
    List<MedicalReport> findByReportTypeContainingIgnoreCase(String reportType);
    
    // Find reports by date range
    @Query("SELECT mr FROM MedicalReport mr WHERE mr.reportDate BETWEEN :startDate AND :endDate ORDER BY mr.reportDate DESC")
    List<MedicalReport> findByReportDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
    
    // Find all reports ordered by date
    @Query("SELECT mr FROM MedicalReport mr ORDER BY mr.reportDate DESC")
    List<MedicalReport> findAllOrderedByDate();
}
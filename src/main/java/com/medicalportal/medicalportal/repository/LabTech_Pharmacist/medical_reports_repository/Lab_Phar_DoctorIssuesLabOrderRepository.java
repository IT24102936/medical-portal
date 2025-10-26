package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_DoctorIssuesLabOrder;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_DoctorIssuesLabOrderId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface Lab_Phar_DoctorIssuesLabOrderRepository extends JpaRepository<Lab_Phar_DoctorIssuesLabOrder, Lab_Phar_DoctorIssuesLabOrderId> {
    
    // Find all doctor orders issued on a specific date
    @Query("SELECT d FROM Lab_Phar_DoctorIssuesLabOrder d WHERE d.issueDate = :issueDate ORDER BY d.issueDate DESC")
    List<Lab_Phar_DoctorIssuesLabOrder> findByIssueDate(@Param("issueDate") LocalDate issueDate);
    
    // Find all orders by doctor ID
    @Query("SELECT d FROM Lab_Phar_DoctorIssuesLabOrder d WHERE d.doctorEid.id = :doctorId ORDER BY d.issueDate DESC")
    List<Lab_Phar_DoctorIssuesLabOrder> findByDoctorId(@Param("doctorId") Integer doctorId);
    
    // Find all orders by patient ID
    @Query("SELECT d FROM Lab_Phar_DoctorIssuesLabOrder d WHERE d.patient.id = :patientId ORDER BY d.issueDate DESC")
    List<Lab_Phar_DoctorIssuesLabOrder> findByPatientId(@Param("patientId") Integer patientId);
    
    // Find orders within date range
    @Query("SELECT d FROM Lab_Phar_DoctorIssuesLabOrder d WHERE d.issueDate BETWEEN :startDate AND :endDate ORDER BY d.issueDate DESC")
    List<Lab_Phar_DoctorIssuesLabOrder> findByIssueDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
    
    // Find all orders ordered by date
    @Query("SELECT d FROM Lab_Phar_DoctorIssuesLabOrder d ORDER BY d.issueDate DESC")
    List<Lab_Phar_DoctorIssuesLabOrder> findAllOrdersOrderedByDate();
    
    // Find by composite ID
    @Query("SELECT d FROM Lab_Phar_DoctorIssuesLabOrder d WHERE d.doctorEid.id = :doctorEid AND d.labOrder.id = :labOrderId AND d.patient.id = :patientId")
    Optional<Lab_Phar_DoctorIssuesLabOrder> findById(@Param("doctorEid") Integer doctorEid, @Param("labOrderId") Integer labOrderId, @Param("patientId") Integer patientId);
    
    // Count total orders
    @Query("SELECT COUNT(d) FROM Lab_Phar_DoctorIssuesLabOrder d")
    long count();
}
package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.DoctorIssuesLabOrder;
import com.medicalportal.medicalportal.entity.DoctorIssuesLabOrderId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface DoctorIssuesLabOrderRepository extends JpaRepository<DoctorIssuesLabOrder, DoctorIssuesLabOrderId> {
    
    // Find all doctor orders issued on a specific date
    List<DoctorIssuesLabOrder> findByIssueDate(LocalDate issueDate);
    
    // Find all orders by doctor ID
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.doctorEid.id = :doctorId")
    List<DoctorIssuesLabOrder> findByDoctorId(@Param("doctorId") Integer doctorId);
    
    // Find all orders by patient ID
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.patient.id = :patientId")
    List<DoctorIssuesLabOrder> findByPatientId(@Param("patientId") Integer patientId);
    
    // Find orders within date range
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.issueDate BETWEEN :startDate AND :endDate ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findByIssueDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
    
    // Find pending orders (for lab technician dashboard)
    @Query("SELECT d FROM DoctorIssuesLabOrder d ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findAllOrdersOrderedByDate();
}
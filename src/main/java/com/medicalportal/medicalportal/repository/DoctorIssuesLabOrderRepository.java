package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.DoctorIssuesLabOrder;
import com.medicalportal.medicalportal.entity.DoctorIssuesLabOrderId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface DoctorIssuesLabOrderRepository extends JpaRepository<DoctorIssuesLabOrder, DoctorIssuesLabOrderId> {
    
    // Find all doctor orders issued on a specific date
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.issueDate = :issueDate ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findByIssueDate(@Param("issueDate") LocalDate issueDate);
    
    // Find all orders by doctor ID
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.doctorEid.id = :doctorId ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findByDoctorId(@Param("doctorId") Integer doctorId);
    
    // Find all orders by patient ID
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.patient.id = :patientId ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findByPatientId(@Param("patientId") Integer patientId);
    
    // Find orders within date range
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.issueDate BETWEEN :startDate AND :endDate ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findByIssueDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
    
    // Find all orders ordered by date
    @Query("SELECT d FROM DoctorIssuesLabOrder d ORDER BY d.issueDate DESC")
    List<DoctorIssuesLabOrder> findAllOrdersOrderedByDate();
    
    // Find by composite ID
    @Query("SELECT d FROM DoctorIssuesLabOrder d WHERE d.doctorEid.id = :doctorEid AND d.labOrder.id = :labOrderId AND d.patient.id = :patientId")
    Optional<DoctorIssuesLabOrder> findById(@Param("doctorEid") Integer doctorEid, @Param("labOrderId") Integer labOrderId, @Param("patientId") Integer patientId);
    
    // Count total orders
    @Query("SELECT COUNT(d) FROM DoctorIssuesLabOrder d")
    long count();
}
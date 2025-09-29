package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.*;
import com.medicalportal.medicalportal.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class LabTechnicianService {

    @Autowired
    private DoctorIssuesLabOrderRepository doctorIssuesLabOrderRepository;
    
    @Autowired
    private LabOrderRepository labOrderRepository;
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private PatientRepository patientRepository;
    
    @Autowired
    private LabTechnicianRepository labTechnicianRepository;

    // Get all doctor issued lab orders
    public List<DoctorIssuesLabOrder> getAllDoctorOrders() {
        return doctorIssuesLabOrderRepository.findAllOrdersOrderedByDate();
    }

    // Get doctor orders by specific date
    public List<DoctorIssuesLabOrder> getDoctorOrdersByDate(LocalDate date) {
        return doctorIssuesLabOrderRepository.findByIssueDate(date);
    }

    // Get doctor orders within date range
    public List<DoctorIssuesLabOrder> getDoctorOrdersByDateRange(LocalDate startDate, LocalDate endDate) {
        return doctorIssuesLabOrderRepository.findByIssueDateBetween(startDate, endDate);
    }

    // Get orders by patient
    public List<DoctorIssuesLabOrder> getOrdersByPatient(Integer patientId) {
        return doctorIssuesLabOrderRepository.findByPatientId(patientId);
    }

    // Get orders by doctor
    public List<DoctorIssuesLabOrder> getOrdersByDoctor(Integer doctorId) {
        return doctorIssuesLabOrderRepository.findByDoctorId(doctorId);
    }

    // Get specific order by composite key
    public Optional<DoctorIssuesLabOrder> getOrderById(Integer doctorEid, Integer labOrderId, Integer patientId) {
        return doctorIssuesLabOrderRepository.findById(doctorEid, labOrderId, patientId);
    }

    // Accept/Process an order (for lab technician workflow)
    public boolean acceptOrder(Integer doctorEid, Integer labOrderId, Integer patientId) {
        try {
            Optional<DoctorIssuesLabOrder> orderOpt = getOrderById(doctorEid, labOrderId, patientId);
            if (orderOpt.isPresent()) {
                // Order exists - in a real application, you might update a status field
                // For now, we'll just return true indicating successful acceptance
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    // Get all lab orders (for reference)
    public List<LabOrder> getAllLabOrders() {
        return labOrderRepository.findAll();
    }

    // Get lab order by ID
    public Optional<LabOrder> getLabOrderById(Integer id) {
        return labOrderRepository.findById(id);
    }

    // Create new lab order
    public LabOrder createLabOrder(String description) {
        // Insert new lab order using custom query
        labOrderRepository.insertLabOrder(description);
        
        // Get the last inserted ID and return the created lab order
        Integer newLabOrderId = labOrderRepository.getLastInsertedId();
        Optional<LabOrder> createdLabOrder = labOrderRepository.findById(newLabOrderId);
        
        return createdLabOrder.orElseThrow(() -> new RuntimeException("Failed to create lab order"));
    }

    // Get all doctors (for reference in dropdowns)
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    // Get all patients (for reference in dropdowns)
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    // Get all lab technicians
    public List<LabTechnician> getAllLabTechnicians() {
        return labTechnicianRepository.findAll();
    }

    // Statistics for dashboard
    public long getTotalPendingOrders() {
        return doctorIssuesLabOrderRepository.count();
    }

    public long getTotalOrdersToday() {
        return doctorIssuesLabOrderRepository.findByIssueDate(LocalDate.now()).size();
    }

    public long getTotalOrdersThisWeek() {
        LocalDate weekStart = LocalDate.now().minusWeeks(1);
        LocalDate weekEnd = LocalDate.now();
        return doctorIssuesLabOrderRepository.findByIssueDateBetween(weekStart, weekEnd).size();
    }
}
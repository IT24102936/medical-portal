package com.medicalportal.medicalportal.service.LabTech_Pharmacist;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.Lab_Phar_Patient;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Doctor;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_DoctorIssuesLabOrder;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_LabOrder;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_LabTechnician;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class Lab_Phar_LabTechnicianService {

    @Autowired
    private Lab_Phar_DoctorIssuesLabOrderRepository doctorIssuesLabOrderRepository;
    
    @Autowired
    private Lab_Phar_LabOrderRepository labOrderRepository;
    
    @Autowired
    private Lab_Phar_DoctorRepository doctorRepository;
    
    @Autowired
    private Lab_Phar_PatientRepository patientRepository;
    
    @Autowired
    private Lab_Phar_LabTechnicianRepository labTechnicianRepository;

    // Get all doctor issued lab orders
    public List<Lab_Phar_DoctorIssuesLabOrder> getAllDoctorOrders() {
        return doctorIssuesLabOrderRepository.findAllOrdersOrderedByDate();
    }

    // Get doctor orders by specific date
    public List<Lab_Phar_DoctorIssuesLabOrder> getDoctorOrdersByDate(LocalDate date) {
        return doctorIssuesLabOrderRepository.findByIssueDate(date);
    }

    // Get doctor orders within date range
    public List<Lab_Phar_DoctorIssuesLabOrder> getDoctorOrdersByDateRange(LocalDate startDate, LocalDate endDate) {
        return doctorIssuesLabOrderRepository.findByIssueDateBetween(startDate, endDate);
    }

    // Get orders by patient
    public List<Lab_Phar_DoctorIssuesLabOrder> getOrdersByPatient(Integer patientId) {
        return doctorIssuesLabOrderRepository.findByPatientId(patientId);
    }

    // Get orders by doctor
    public List<Lab_Phar_DoctorIssuesLabOrder> getOrdersByDoctor(Integer doctorId) {
        return doctorIssuesLabOrderRepository.findByDoctorId(doctorId);
    }

    // Get specific order by composite key
    public Optional<Lab_Phar_DoctorIssuesLabOrder> getOrderById(Integer doctorEid, Integer labOrderId, Integer patientId) {
        return doctorIssuesLabOrderRepository.findById(doctorEid, labOrderId, patientId);
    }

    // Accept/Process an order (for lab technician workflow)
    public boolean acceptOrder(Integer doctorEid, Integer labOrderId, Integer patientId) {
        try {
            Optional<Lab_Phar_DoctorIssuesLabOrder> orderOpt = getOrderById(doctorEid, labOrderId, patientId);
            if (orderOpt.isPresent()) {
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    // Get all lab orders (for reference)
    public List<Lab_Phar_LabOrder> getAllLabOrders() {
        return labOrderRepository.findAll();
    }

    // Get lab order by ID
    public Optional<Lab_Phar_LabOrder> getLabOrderById(Integer id) {
        return labOrderRepository.findById(id);
    }

    // Create new lab order
    public Lab_Phar_LabOrder createLabOrder(String description) {
        // Insert new lab order using custom query
        labOrderRepository.insertLabOrder(description);
        
        // Get the last inserted ID and return the created lab order
        Integer newLabOrderId = labOrderRepository.getLastInsertedId();
        Optional<Lab_Phar_LabOrder> createdLabOrder = labOrderRepository.findById(newLabOrderId);
        
        return createdLabOrder.orElseThrow(() -> new RuntimeException("Failed to create lab order"));
    }

    // Get all doctors (for reference in dropdowns)
    public List<Lab_Phar_Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    // Get all patients (for reference in dropdowns)
    public List<Lab_Phar_Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    // Get all lab technicians
    public List<Lab_Phar_LabTechnician> getAllLabTechnicians() {
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
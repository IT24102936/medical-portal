package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.MedicalReport;
import com.medicalportal.medicalportal.entity.Patient;
import com.medicalportal.medicalportal.repository.MedicalReportRepository;
import com.medicalportal.medicalportal.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class MedicalReportService {

    @Autowired
    private MedicalReportRepository medicalReportRepository;
    
    @Autowired
    private PatientRepository patientRepository;

    // Get all medical reports
    public List<MedicalReport> getAllReports() {
        return medicalReportRepository.findAllOrderedByDate();
    }

    // Get reports by patient ID
    public List<MedicalReport> getReportsByPatient(Integer patientId) {
        return medicalReportRepository.findByPatientId(patientId);
    }

    // Get reports by report type
    public List<MedicalReport> getReportsByType(String reportType) {
        return medicalReportRepository.findByReportTypeContainingIgnoreCase(reportType);
    }

    // Get reports by date range
    public List<MedicalReport> getReportsByDateRange(LocalDate startDate, LocalDate endDate) {
        return medicalReportRepository.findByReportDateBetween(startDate, endDate);
    }

    // Get specific report by ID
    public Optional<MedicalReport> getReportById(Integer id) {
        return medicalReportRepository.findById(id);
    }

    // Create new medical report with drive link
    public MedicalReport createMedicalReport(String reportType, String documentPath, Integer patientId) {
        Optional<Patient> patientOpt = patientRepository.findById(patientId);
        if (patientOpt.isEmpty()) {
            throw new IllegalArgumentException("Patient not found with ID: " + patientId);
        }

        MedicalReport report = new MedicalReport();
        report.setReportType(reportType);
        report.setDocumentPath(documentPath);
        report.setReportDate(LocalDate.now());
        report.setPatient(patientOpt.get());
        
        return medicalReportRepository.save(report);
    }

    // Update medical report
    public MedicalReport updateMedicalReport(Integer reportId, String reportType, String documentPath, Integer patientId) {
        Optional<MedicalReport> reportOpt = medicalReportRepository.findById(reportId);
        if (reportOpt.isEmpty()) {
            throw new IllegalArgumentException("Medical report not found with ID: " + reportId);
        }

        Optional<Patient> patientOpt = patientRepository.findById(patientId);
        if (patientOpt.isEmpty()) {
            throw new IllegalArgumentException("Patient not found with ID: " + patientId);
        }

        MedicalReport report = reportOpt.get();
        report.setReportType(reportType);
        report.setDocumentPath(documentPath);
        report.setPatient(patientOpt.get());
        
        return medicalReportRepository.save(report);
    }

    // Delete medical report
    public boolean deleteMedicalReport(Integer reportId) {
        try {
            if (medicalReportRepository.existsById(reportId)) {
                medicalReportRepository.deleteById(reportId);
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    // Get all patients for dropdown
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    // Statistics for dashboard
    public long getTotalReportsCount() {
        return medicalReportRepository.count();
    }

    public long getReportsCountToday() {
        return medicalReportRepository.findByReportDateBetween(LocalDate.now(), LocalDate.now()).size();
    }

    public long getReportsCountThisWeek() {
        LocalDate weekStart = LocalDate.now().minusWeeks(1);
        LocalDate weekEnd = LocalDate.now();
        return medicalReportRepository.findByReportDateBetween(weekStart, weekEnd).size();
    }

    // Validate Google Drive link format
    public boolean isValidDriveLink(String driveLink) {
        if (driveLink == null || driveLink.trim().isEmpty()) {
            return false;
        }
        
        // Basic validation for Google Drive links
        return driveLink.contains("drive.google.com") || 
               driveLink.contains("docs.google.com") ||
               driveLink.startsWith("https://");
    }
}
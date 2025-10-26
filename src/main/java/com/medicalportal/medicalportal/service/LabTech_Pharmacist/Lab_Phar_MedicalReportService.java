package com.medicalportal.medicalportal.service.LabTech_Pharmacist;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.Lab_Phar_Patient;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_MedicalReport;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_MedicalReportRepository;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class Lab_Phar_MedicalReportService {

    @Autowired
    private Lab_Phar_MedicalReportRepository medicalReportRepository;
    
    @Autowired
    private Lab_Phar_PatientRepository patientRepository;

    // Get all medical reports
    public List<Lab_Phar_MedicalReport> getAllReports() {
        return medicalReportRepository.findAllOrderedByDate();
    }

    // Get reports by patient ID
    public List<Lab_Phar_MedicalReport> getReportsByPatient(Integer patientId) {
        return medicalReportRepository.findByPatientId(patientId);
    }

    // Get reports by report type
    public List<Lab_Phar_MedicalReport> getReportsByType(String reportType) {
        return medicalReportRepository.findByReportTypeContainingIgnoreCase(reportType);
    }

    // Get reports by date range
    public List<Lab_Phar_MedicalReport> getReportsByDateRange(LocalDate startDate, LocalDate endDate) {
        return medicalReportRepository.findByReportDateBetween(startDate, endDate);
    }

    // Get specific report by ID
    public Optional<Lab_Phar_MedicalReport> getReportById(Integer id) {
        return medicalReportRepository.findById(id);
    }

    // Create new medical report with drive link
    public Lab_Phar_MedicalReport createMedicalReport(String reportType, String documentPath, Integer patientId) {
        Optional<Lab_Phar_Patient> patientOpt = patientRepository.findById(patientId);
        if (patientOpt.isEmpty()) {
            throw new IllegalArgumentException("Patient not found with ID: " + patientId);
        }

        // Insert new medical report using custom query
        medicalReportRepository.insertMedicalReport(LocalDate.now(), reportType, documentPath, patientId);
        
        // Get the last inserted ID and return the created medical report
        Integer newReportId = medicalReportRepository.getLastInsertedId();
        Optional<Lab_Phar_MedicalReport> createdReport = medicalReportRepository.findById(newReportId);
        
        return createdReport.orElseThrow(() -> new RuntimeException("Failed to create medical report"));
    }

    // Update medical report
    public Lab_Phar_MedicalReport updateMedicalReport(Integer reportId, String reportType, String documentPath, Integer patientId) {
        Optional<Lab_Phar_MedicalReport> reportOpt = medicalReportRepository.findById(reportId);
        if (reportOpt.isEmpty()) {
            throw new IllegalArgumentException("Medical report not found with ID: " + reportId);
        }

        Optional<Lab_Phar_Patient> patientOpt = patientRepository.findById(patientId);
        if (patientOpt.isEmpty()) {
            throw new IllegalArgumentException("Patient not found with ID: " + patientId);
        }

        // Update medical report using custom query
        medicalReportRepository.updateMedicalReport(reportId, reportType, documentPath, patientId);
        
        // Return the updated medical report
        Optional<Lab_Phar_MedicalReport> updatedReport = medicalReportRepository.findById(reportId);
        return updatedReport.orElseThrow(() -> new RuntimeException("Failed to update medical report"));
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
    public List<Lab_Phar_Patient> getAllPatients() {
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

    // Validate Google Drive link format with proper URL structure validation
    public boolean isValidDriveLink(String driveLink) {
        if (driveLink == null || driveLink.trim().isEmpty()) {
            return false;
        }
        
        String cleanLink = driveLink.trim().toLowerCase();
        
        // Must start with https for security
        if (!cleanLink.startsWith("https://")) {
            return false;
        }
        
        // Validate specific Google Drive URL patterns
        boolean isGoogleDriveLink = cleanLink.contains("drive.google.com/file/d/") ||
                                   cleanLink.contains("drive.google.com/open?id=") ||
                                   cleanLink.contains("docs.google.com/document/d/") ||
                                   cleanLink.contains("docs.google.com/spreadsheets/d/") ||
                                   cleanLink.contains("docs.google.com/presentation/d/");
        
        // Additional validation: check if it's a valid Google Drive sharing link
        if (isGoogleDriveLink) {
            // Ensure the link has proper structure and sharing parameters
            return cleanLink.contains("/d/") && (cleanLink.length() > 50); // Basic length check for valid IDs
        }
        
        // Allow other valid medical document hosting services (optional)
        boolean isOtherValidService = cleanLink.contains("dropbox.com") ||
                                     cleanLink.contains("onedrive.live.com") ||
                                     cleanLink.contains("sharepoint.com");
        
        return isOtherValidService;
    }
}
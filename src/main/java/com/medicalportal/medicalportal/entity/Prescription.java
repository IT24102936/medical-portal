package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "doctor_issues_prescription")
@IdClass(PrescriptionId.class)
public class Prescription {
    @Id
    @Column(name = "doctor_eid")
    private Long doctorId;

    @Id
    @Column(name = "prescription_id")
    private Long prescriptionId;

    @Id
    @Column(name = "patient_id")
    private Long patientId;

    @Column(name = "issue_date", nullable = false)
    @NotNull(message = "Issue date is required")
    private LocalDate issueDate;

    // Many-to-one relationship to the actual prescription details
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "prescription_id", insertable = false, updatable = false)
    private PrescriptionDetails prescriptionDetails;

    // Many-to-one relationship to doctor
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "doctor_eid", insertable = false, updatable = false)
    private Doctor doctor;

    // Many-to-one relationship to patient
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "patient_id", insertable = false, updatable = false)
    private Patient patient;

    // Transient field for easy access to description
    @Transient
    private String description;

    // Transient field for patient name
    @Transient
    private String patientName;


    // Default constructor
    public Prescription() {
        this.issueDate = LocalDate.now();
    }

    // Parameterized constructor
    public Prescription(Long doctorId, Long prescriptionId, Long patientId, LocalDate issueDate) {
        this.doctorId = doctorId;
        this.prescriptionId = prescriptionId;
        this.patientId = patientId;
        this.issueDate = issueDate != null ? issueDate : LocalDate.now();
    }

    // Getters and setters
    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }

    public Long getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(Long prescriptionId) {
        this.prescriptionId = prescriptionId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

    public PrescriptionDetails getPrescriptionDetails() {
        return prescriptionDetails;
    }

    public void setPrescriptionDetails(PrescriptionDetails prescriptionDetails) {
        this.prescriptionDetails = prescriptionDetails;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    // Convenience method to get description from prescription details
    public String getDescription() {
        if (description != null) {
            return description;
        }
        return prescriptionDetails != null ? prescriptionDetails.getDescription() : null;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Convenience method to get patient name
    public String getPatientName() {
        if (patientName != null) {
            return patientName;
        }
        return patient != null ? patient.getFirstName() + " " + patient.getLastName() : null;
    }

    public String getFormattedIssueDate() {
        if (issueDate == null) {
            return "N/A";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        return issueDate.format(formatter);
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    @PrePersist
    protected void onCreate() {
        if (issueDate == null) {
            issueDate = LocalDate.now();
        }
    }
    /*
    // Helper methods
    public String getFormattedIssueDate() {
        return issueDate != null ? issueDate.toString() : "N/A";
    }

    public boolean isRecent() {
        return issueDate != null &&
                issueDate.isAfter(LocalDate.now().minusDays(30));
    }

     */

    @Override
    public String toString() {
        return "Prescription{" +
                "doctorId=" + doctorId +
                ", prescriptionId=" + prescriptionId +
                ", patientId=" + patientId +
                ", issueDate=" + issueDate +
                ", description='" + getDescription() + '\'' +
                '}';
    }
}

package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "appointments")
public class Appointment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id")
    private Long appointmentId;
    
    @Column(name = "appointment_time")
    private LocalDateTime appointmentTime;
    
    @Column(name = "doctor_name")
    private String doctorName;
    
    @Column(name = "patient_first_name")
    private String patientFirstName;
    
    @Column(name = "patient_last_name")
    private String patientLastName;
    
    @Column(name = "patient_name")
    private String patientName;
    
    @Column(name = "status")
    private String status;
    
    @Column(name = "reason")
    private String reason;
    
    // Constructors
    public Appointment() {}
    
    public Appointment(LocalDateTime appointmentTime, String doctorName, 
                      String patientFirstName, String patientLastName, 
                      String status, String reason) {
        this.appointmentTime = appointmentTime;
        this.doctorName = doctorName;
        this.patientFirstName = patientFirstName;
        this.patientLastName = patientLastName;
        this.patientName = patientFirstName + " " + patientLastName;
        this.status = status;
        this.reason = reason;
    }
    
    // Getters and Setters
    public Long getAppointmentId() {
        return appointmentId;
    }
    
    public void setAppointmentId(Long appointmentId) {
        this.appointmentId = appointmentId;
    }
    
    public LocalDateTime getAppointmentTime() {
        return appointmentTime;
    }
    
    public void setAppointmentTime(LocalDateTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
    
    public String getPatientFirstName() {
        return patientFirstName;
    }
    
    public void setPatientFirstName(String patientFirstName) {
        this.patientFirstName = patientFirstName;
    }
    
    public String getPatientLastName() {
        return patientLastName;
    }
    
    public void setPatientLastName(String patientLastName) {
        this.patientLastName = patientLastName;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getReason() {
        return reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }
    
    // Helper methods
    public String getFullPatientName() {
        return patientFirstName + " " + patientLastName;
    }
    
    public String getDate() {
        return appointmentTime != null ? appointmentTime.toLocalDate().toString() : "";
    }
    
    public String getTime() {
        return appointmentTime != null ? appointmentTime.toLocalTime().toString() : "";
    }
    
    public String getDoctorSpecialization() {
        // For now, return a default specialization since we don't have it in the entity
        return "General Medicine";
    }
    
    @Override
    public String toString() {
        return "Appointment{" +
                "appointmentId=" + appointmentId +
                ", appointmentTime=" + appointmentTime +
                ", doctorName='" + doctorName + '\'' +
                ", patientName='" + patientName + '\'' +
                ", status='" + status + '\'' +
                ", reason='" + reason + '\'' +
                '}';
    }
}

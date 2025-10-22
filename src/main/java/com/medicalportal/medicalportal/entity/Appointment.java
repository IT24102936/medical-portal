package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "appointment")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id")
    private Long id;

    @Column(name = "appointment_time", nullable = false)
    private LocalDateTime appointmentTime;

    @Column(nullable = false)
    private String status = "Scheduled";

    @ManyToOne
    @JoinColumn(name = "receptionist_eid")
    private Receptionist receptionist;

    // Add this missing doctor relationship
    @ManyToOne
    @JoinColumn(name = "doctor_eid")
    private Doctor doctor;

    @ManyToMany
    @JoinTable(
            name = "patient_appointment_booking",
            joinColumns = @JoinColumn(name = "appointment_id"),
            inverseJoinColumns = @JoinColumn(name = "patient_id")
    )
    private Set<Patient> patients = new HashSet<>();

    @ManyToMany
    @JoinTable(
            name = "doctor_views_appointment",
            joinColumns = @JoinColumn(name = "appointment_id"),
            inverseJoinColumns = @JoinColumn(name = "doctor_eid")
    )
    private Set<Doctor> viewingDoctors = new HashSet<>();

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public LocalDateTime getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(LocalDateTime appointmentTime) { this.appointmentTime = appointmentTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Receptionist getReceptionist() { return receptionist; }
    public void setReceptionist(Receptionist receptionist) { this.receptionist = receptionist; }
    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }
    public Set<Patient> getPatients() { return patients; }
    public void setPatients(Set<Patient> patients) { this.patients = patients; }
    public Set<Doctor> getViewingDoctors() { return viewingDoctors; }
    public void setViewingDoctors(Set<Doctor> viewingDoctors) { this.viewingDoctors = viewingDoctors; }

    // Fix these methods in your Appointment.java entity
    public String getFormattedDate() {
        if (appointmentTime != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return appointmentTime.format(formatter); // Use appointmentTime directly without timezone conversion
        }
        return "";
    }

    public String getFormattedTime() {
        if (appointmentTime != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            return appointmentTime.format(formatter); // Use appointmentTime directly without timezone conversion
        }
        return "No time set";
    }


    public LocalDate getLocalAppointmentDate() {
        if (appointmentTime != null) {
            return appointmentTime.toLocalDate(); // Use appointmentTime directly
        }
        return null;
    }
}
package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "time_slots")
public class TimeSlot {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    
    @Column(name = "doctor_id", nullable = false)
    private Long doctorId;
    
    @Column(name = "date", nullable = false)
    private LocalDate date;
    
    @Column(name = "time_slot", nullable = false)
    private LocalTime timeSlot;
    
    @Column(name = "is_available", nullable = false)
    private Boolean isAvailable;
    
    @Column(name = "appointment_id")
    private Long appointmentId;
    
    // Constructors
    public TimeSlot() {}
    
    public TimeSlot(Long doctorId, LocalDate date, LocalTime timeSlot, Boolean isAvailable) {
        this.doctorId = doctorId;
        this.date = date;
        this.timeSlot = timeSlot;
        this.isAvailable = isAvailable;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }
    
    public LocalDate getDate() {
        return date;
    }
    
    public void setDate(LocalDate date) {
        this.date = date;
    }
    
    public LocalTime getTimeSlot() {
        return timeSlot;
    }
    
    public void setTimeSlot(LocalTime timeSlot) {
        this.timeSlot = timeSlot;
    }
    
    public Boolean getIsAvailable() {
        return isAvailable;
    }
    
    public void setIsAvailable(Boolean isAvailable) {
        this.isAvailable = isAvailable;
    }
    
    public Long getAppointmentId() {
        return appointmentId;
    }
    
    public void setAppointmentId(Long appointmentId) {
        this.appointmentId = appointmentId;
    }
    
    @Override
    public String toString() {
        return "TimeSlot{" +
                "id=" + id +
                ", doctorId=" + doctorId +
                ", date=" + date +
                ", timeSlot=" + timeSlot +
                ", isAvailable=" + isAvailable +
                ", appointmentId=" + appointmentId +
                '}';
    }
}

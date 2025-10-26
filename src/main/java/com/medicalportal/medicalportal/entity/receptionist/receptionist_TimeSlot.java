package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "time_slot")
public class receptionist_TimeSlot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "doctor_id", nullable = false)
    private Integer doctorId;
    
    @Column(name = "date", nullable = false)
    private LocalDate date;
    
    @Column(name = "time_slot", nullable = false)
    private LocalTime timeSlot;
    
    @Column(name = "is_available", nullable = false)
    private Boolean isAvailable = true;
    
    @Column(name = "appointment_id")
    private Long appointmentId;
    
    // Constructors
    public receptionist_TimeSlot() {}
    
    public receptionist_TimeSlot(Integer doctorId, LocalDate date, LocalTime timeSlot, Boolean isAvailable) {
        this.doctorId = doctorId;
        this.date = date;
        this.timeSlot = timeSlot;
        this.isAvailable = isAvailable;
    }
    
    // Getters and setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Integer getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(Integer doctorId) {
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
}

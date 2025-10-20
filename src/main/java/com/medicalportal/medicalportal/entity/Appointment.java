package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "appointment")
public class Appointment {
    @Id
    @Column(name = "appointment_id")
    private Integer appointmentId;

    @Column(name = "appointment_time")
    private LocalDateTime appointmentTime;

    @Column(name = "status")
    private String status;

    @Column(name = "receptionist_eid")
    private Integer receptionistEid;

    // Relationships
    @ManyToOne
    @JoinColumn(name = "receptionist_eid", insertable = false, updatable = false)
    private Employee receptionist;

    // Constructors
    public Appointment() {}

    public Appointment(Integer appointmentId, LocalDateTime appointmentTime, String status, Integer receptionistEid) {
        this.appointmentId = appointmentId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.receptionistEid = receptionistEid;
    }

    // Getters and setters
    public Integer getAppointmentId() { return appointmentId; }
    public void setAppointmentId(Integer appointmentId) { this.appointmentId = appointmentId; }

    public LocalDateTime getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(LocalDateTime appointmentTime) { this.appointmentTime = appointmentTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getReceptionistEid() { return receptionistEid; }
    public void setReceptionistEid(Integer receptionistEid) { this.receptionistEid = receptionistEid; }

    public Employee getReceptionist() { return receptionist; }
    public void setReceptionist(Employee receptionist) { this.receptionist = receptionist; }

    // Helper methods
    public String getFormattedDate() {
        return appointmentTime != null ? appointmentTime.toLocalDate().toString() : "";
    }

    public String getFormattedTime() {
        return appointmentTime != null ? appointmentTime.toLocalTime().toString() : "";
    }
}

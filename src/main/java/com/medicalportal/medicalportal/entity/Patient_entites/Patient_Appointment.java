package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "appointment")
public class Patient_Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id", nullable = false)
    private Integer id;

    @Column(name = "appointment_time", nullable = false)
    private LocalDateTime appointmentDatetime;

    @Column(name = "status", nullable = false, length = 50)
    private String status;

    @Column(name = "receptionist_eid")
    private Integer receptionistEid;

    @Column(name = "doctor_eid", nullable = false)
    private Integer doctorEid;

    // Link to Patient
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient_Patient patient;

    // Link to Doctor
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "doctor_eid", insertable = false, updatable = false)
    private Patient_Doctor doctor;

    // Constructors
    public Patient_Appointment() {}

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public LocalDateTime getAppointmentDatetime() { return appointmentDatetime; }
    public void setAppointmentDatetime(LocalDateTime appointmentDatetime) { this.appointmentDatetime = appointmentDatetime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getReceptionistEid() { return receptionistEid; }
    public void setReceptionistEid(Integer receptionistEid) { this.receptionistEid = receptionistEid; }

    public Integer getDoctorEid() { return doctorEid; }
    public void setDoctorEid(Integer doctorEid) { this.doctorEid = doctorEid; }

    public Patient_Patient getPatient() { return patient; }
    public void setPatient(Patient_Patient patient) { this.patient = patient; }

    public Patient_Doctor getDoctor() { return doctor; }
    public void setDoctor(Patient_Doctor doctor) { this.doctor = doctor; }
}

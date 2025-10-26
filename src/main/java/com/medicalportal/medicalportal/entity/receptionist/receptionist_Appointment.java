package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "appointment")
public class receptionist_Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "appointment_id", nullable = false)
    private Integer id;

    @Column(name = "appointment_time", nullable = false)
    private Instant appointmentTime;

    @Column(name = "status", nullable = false, length = 50)
    private String status;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "receptionist_eid")
    private receptionist_Receptionist receptionistEid;

    @ManyToMany
    @JoinTable(name = "doctor_views_appointment",
            joinColumns = @JoinColumn(name = "appointment_id"),
            inverseJoinColumns = @JoinColumn(name = "doctor_eid"))
    private Set<receptionist_Doctor> doctors = new LinkedHashSet<>();

    @ManyToMany
    @JoinTable(name = "patient_appointment_booking",
            joinColumns = @JoinColumn(name = "appointment_id"),
            inverseJoinColumns = @JoinColumn(name = "patient_id"))
    private Set<receptionist_Patient> patients = new LinkedHashSet<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Instant getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Instant appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public receptionist_Receptionist getReceptionistEid() {
        return receptionistEid;
    }

    public void setReceptionistEid(receptionist_Receptionist receptionistEid) {
        this.receptionistEid = receptionistEid;
    }

    public Set<receptionist_Doctor> getDoctors() {
        return doctors;
    }

    public void setDoctors(Set<receptionist_Doctor> doctors) {
        this.doctors = doctors;
    }

    public Set<receptionist_Patient> getPatients() {
        return patients;
    }

    public void setPatients(Set<receptionist_Patient> patients) {
        this.patients = patients;
    }

}

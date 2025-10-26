package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

// Note: This entity is disabled because the relationship is managed via @ManyToMany in Appointment entity
// If you need to add additional fields to this junction table, uncomment and remove @ManyToMany from Appointment

// @Entity
@Table(name = "patient_appointment_booking")
public class receptionist_PatientAppointmentBooking {
    @EmbeddedId
    private receptionist_PatientAppointmentBookingId id;

    @MapsId("patientId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "patient_id", nullable = false)
    private receptionist_Patient patient;

    @MapsId("appointmentId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "appointment_id", nullable = false)
    private receptionist_Appointment appointment;

    public receptionist_PatientAppointmentBookingId getId() {
        return id;
    }

    public void setId(receptionist_PatientAppointmentBookingId id) {
        this.id = id;
    }

    public receptionist_Patient getPatient() {
        return patient;
    }

    public void setPatient(receptionist_Patient patient) {
        this.patient = patient;
    }

    public receptionist_Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(receptionist_Appointment appointment) {
        this.appointment = appointment;
    }

}

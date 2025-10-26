package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

// Note: This entity is disabled because the relationship is managed via @ManyToMany in Appointment entity
// If you need to add additional fields to this junction table, uncomment and remove @ManyToMany from Appointment

// @Entity
@Table(name = "doctor_views_appointment")
public class receptionist_DoctorViewsAppointment {
    @EmbeddedId
    private receptionist_DoctorViewsAppointmentId id;

    @MapsId("doctorEid")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "doctor_eid", nullable = false)
    private receptionist_Doctor doctorEid;

    @MapsId("appointmentId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "appointment_id", nullable = false)
    private receptionist_Appointment appointment;

    public receptionist_DoctorViewsAppointmentId getId() {
        return id;
    }

    public void setId(receptionist_DoctorViewsAppointmentId id) {
        this.id = id;
    }

    public receptionist_Doctor getDoctorEid() {
        return doctorEid;
    }

    public void setDoctorEid(receptionist_Doctor doctorEid) {
        this.doctorEid = doctorEid;
    }

    public receptionist_Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(receptionist_Appointment appointment) {
        this.appointment = appointment;
    }

}

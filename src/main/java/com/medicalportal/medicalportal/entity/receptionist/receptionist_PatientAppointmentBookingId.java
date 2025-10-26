package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class receptionist_PatientAppointmentBookingId implements Serializable {
    private static final long serialVersionUID = 6100325886169707867L;
    @Column(name = "patient_id", nullable = false)
    private Integer patientId;

    @Column(name = "appointment_id", nullable = false)
    private Integer appointmentId;

    public Integer getPatientId() {
        return patientId;
    }

    public void setPatientId(Integer patientId) {
        this.patientId = patientId;
    }

    public Integer getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(Integer appointmentId) {
        this.appointmentId = appointmentId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        receptionist_PatientAppointmentBookingId entity = (receptionist_PatientAppointmentBookingId) o;
        return Objects.equals(this.patientId, entity.patientId) &&
                Objects.equals(this.appointmentId, entity.appointmentId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(patientId, appointmentId);
    }

}

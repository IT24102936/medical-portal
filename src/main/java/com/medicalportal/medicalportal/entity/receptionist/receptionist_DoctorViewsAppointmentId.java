package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class receptionist_DoctorViewsAppointmentId implements Serializable {
    private static final long serialVersionUID = -6210604436939846452L;
    @Column(name = "doctor_eid", nullable = false)
    private Integer doctorEid;

    @Column(name = "appointment_id", nullable = false)
    private Integer appointmentId;

    public Integer getDoctorEid() {
        return doctorEid;
    }

    public void setDoctorEid(Integer doctorEid) {
        this.doctorEid = doctorEid;
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
        receptionist_DoctorViewsAppointmentId entity = (receptionist_DoctorViewsAppointmentId) o;
        return Objects.equals(this.appointmentId, entity.appointmentId) &&
                Objects.equals(this.doctorEid, entity.doctorEid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(appointmentId, doctorEid);
    }

}

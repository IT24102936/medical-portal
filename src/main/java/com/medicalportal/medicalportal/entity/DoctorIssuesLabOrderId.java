package com.medicalportal.medicalportal.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class DoctorIssuesLabOrderId implements Serializable {
    private static final long serialVersionUID = -1804581052452625595L;
    @Column(name = "doctor_eid", nullable = false)
    private Integer doctorEid;

    @Column(name = "lab_order_id", nullable = false)
    private Integer labOrderId;

    @Column(name = "patient_id", nullable = false)
    private Integer patientId;

    public Integer getDoctorEid() {
        return doctorEid;
    }

    public void setDoctorEid(Integer doctorEid) {
        this.doctorEid = doctorEid;
    }

    public Integer getLabOrderId() {
        return labOrderId;
    }

    public void setLabOrderId(Integer labOrderId) {
        this.labOrderId = labOrderId;
    }

    public Integer getPatientId() {
        return patientId;
    }

    public void setPatientId(Integer patientId) {
        this.patientId = patientId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        DoctorIssuesLabOrderId entity = (DoctorIssuesLabOrderId) o;
        return Objects.equals(this.patientId, entity.patientId) &&
                Objects.equals(this.doctorEid, entity.doctorEid) &&
                Objects.equals(this.labOrderId, entity.labOrderId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(patientId, doctorEid, labOrderId);
    }

}
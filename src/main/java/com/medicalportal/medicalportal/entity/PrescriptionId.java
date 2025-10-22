package com.medicalportal.medicalportal.entity;

import java.io.Serializable;
import java.util.Objects;

public class PrescriptionId implements Serializable {
    private Long doctorId;
    private Long prescriptionId;
    private Long patientId;

    // Default constructor
    public PrescriptionId() {}

    // Parameterized constructor
    public PrescriptionId(Long doctorId, Long prescriptionId, Long patientId) {
        this.doctorId = doctorId;
        this.prescriptionId = prescriptionId;
        this.patientId = patientId;
    }

    // Getters and setters
    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }

    public Long getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(Long prescriptionId) {
        this.prescriptionId = prescriptionId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    // equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PrescriptionId that = (PrescriptionId) o;
        return Objects.equals(doctorId, that.doctorId) &&
                Objects.equals(prescriptionId, that.prescriptionId) &&
                Objects.equals(patientId, that.patientId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(doctorId, prescriptionId, patientId);
    }

    @Override
    public String toString() {
        return "PrescriptionId{" +
                "doctorId=" + doctorId +
                ", prescriptionId=" + prescriptionId +
                ", patientId=" + patientId +
                '}';
    }
}


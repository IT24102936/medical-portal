package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "patient_phone")
public class PatientPhone {
    @EmbeddedId
    private PatientPhoneId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("patientId")
    @JoinColumn(name = "patient_id")
    private Patient patient;

    public PatientPhone() {}

    public PatientPhone(Patient patient, String phoneNumber) {
        this.patient = patient;
        this.id = new PatientPhoneId(patient.getId(), phoneNumber);
    }

    // Getters and setters
    public PatientPhoneId getId() {
        return id;
    }

    public void setId(PatientPhoneId id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    // Convenience method to get phone number
    public String getPhoneNumber() {
        return id != null ? id.getPhoneNumber() : null;
    }

    @Override
    public String toString() {
        return "PatientPhone{" +
                "patientId=" + (id != null ? id.getPatientId() : null) +
                ", phoneNumber='" + getPhoneNumber() + '\'' +
                '}';
    }
}

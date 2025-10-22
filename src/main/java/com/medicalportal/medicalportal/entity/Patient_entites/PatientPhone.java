package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "patient_phone")
@IdClass(PatientPhone.PatientPhoneId.class)
public class PatientPhone {

    @Id
    @Column(name = "patient_id", nullable = false)
    private Integer patientId;

    @Id
    @Column(name = "phone_number", nullable = false, length = 20)
    private String phoneNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", insertable = false, updatable = false)
    private Patient patient;

    public PatientPhone() {}

    public PatientPhone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    // Pre-persist method to set patientId from patient
    @PrePersist
    public void prePersist() {
        if (patient != null && patientId == null) {
            this.patientId = patient.getId();
        }
    }

    public Integer getPatientId() {
        return patientId;
    }

    public void setPatientId(Integer patientId) {
        this.patientId = patientId;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
        if (patient != null && patient.getId() != null) {
            this.patientId = patient.getId();
        }
    }

    public static class PatientPhoneId implements Serializable {
        private Integer patientId;
        private String phoneNumber;

        public PatientPhoneId() {}

        public PatientPhoneId(Integer patientId, String phoneNumber) {
            this.patientId = patientId;
            this.phoneNumber = phoneNumber;
        }

        public Integer getPatientId() {
            return patientId;
        }

        public void setPatientId(Integer patientId) {
            this.patientId = patientId;
        }

        public String getPhoneNumber() {
            return phoneNumber;
        }

        public void setPhoneNumber(String phoneNumber) {
            this.phoneNumber = phoneNumber;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            PatientPhoneId that = (PatientPhoneId) o;
            return Objects.equals(patientId, that.patientId) &&
                    Objects.equals(phoneNumber, that.phoneNumber);
        }

        @Override
        public int hashCode() {
            return Objects.hash(patientId, phoneNumber);
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PatientPhone)) return false;
        PatientPhone that = (PatientPhone) o;
        return Objects.equals(patientId, that.patientId) &&
                Objects.equals(phoneNumber, that.phoneNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(patientId, phoneNumber);
    }
}
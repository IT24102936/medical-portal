package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "patient")
public class Patient {
    @Id
    @Column(name = "patient_id")  // Match the DB column name
    private Integer patientId;    // Use patientId instead of pid

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "national_id")
    private String nationalId;

    @Column(name = "gender")
    private String gender;

    @Column(name = "dob")
    private LocalDate dob;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    // Removed user_name field as it's not in the schema
    
    @Column(name = "status")
    private String status;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<PatientPhone> phones;

    // Getters and setters (update method names to match patientId)
    public Integer getPatientId() { return patientId; }
    public void setPatientId(Integer patientId) { this.patientId = patientId; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getNationalId() { return nationalId; }
    public void setNationalId(String nationalId) { this.nationalId = nationalId; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    // Removed getUserName and setUserName methods
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public List<PatientPhone> getPhones() { return phones; }
    public void setPhones(List<PatientPhone> phones) { this.phones = phones; }

    public String getFirstPhoneNumber() {
        return phones != null && !phones.isEmpty() ? phones.get(0).getPhoneNumber() : "";
    }
}

@Entity
@Table(name = "patient_phone")
class PatientPhone {
    @EmbeddedId
    private PatientPhoneId id;

    @ManyToOne
    @MapsId("patientId")  // Update to match the new field name
    @JoinColumn(name = "patient_id")  // Reference the DB column
    private Patient patient;

    @Column(name = "phone_number", insertable = false, updatable = false)
    private String phoneNumber;

    // Getters and setters
    public PatientPhoneId getId() { return id; }
    public void setId(PatientPhoneId id) { this.id = id; }
    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
}

@Embeddable
class PatientPhoneId implements Serializable {
    @Column(name = "patient_id")  // Update to match DB
    private Integer patientId;

    @Column(name = "phone_number")
    private String phoneNumber;

    // Constructors
    public PatientPhoneId() {}
    public PatientPhoneId(Integer patientId, String phoneNumber) {
        this.patientId = patientId;
        this.phoneNumber = phoneNumber;
    }

    // Getters and setters
    public Integer getPatientId() { return patientId; }
    public void setPatientId(Integer patientId) { this.patientId = patientId; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PatientPhoneId)) return false;
        PatientPhoneId that = (PatientPhoneId) o;
        return patientId.equals(that.patientId) && phoneNumber.equals(that.phoneNumber);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(patientId, phoneNumber);
    }
}
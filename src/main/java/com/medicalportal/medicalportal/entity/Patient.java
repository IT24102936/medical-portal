package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "patient")
public class Patient {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "patient_id")
    private Long patientId;
    
    @Column(name = "first_name", nullable = false)
    private String firstName;
    
    @Column(name = "last_name", nullable = false)
    private String lastName;
    
    @Column(name = "national_id", unique = true, nullable = false)
    private String nationalId;
    
    @Column(name = "password", nullable = false)
    private String password;
    
    @Column(name = "gender")
    private String gender;
    
    @Column(name = "address")
    private String address;
    
    @Column(name = "dob", nullable = false)
    private LocalDate dob;
    
    @Column(name = "email", unique = true, nullable = false)
    private String email;
    
    @Column(name = "last_visit")
    private LocalDateTime lastVisit;
    
    // Constructors
    public Patient() {}
    
    public Patient(String firstName, String lastName, String nationalId, String password, 
                   String gender, String address, LocalDate dob, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.nationalId = nationalId;
        this.password = password;
        this.gender = gender;
        this.address = address;
        this.dob = dob;
        this.email = email;
    }
    
    // Getters and Setters
    public Long getPatientId() {
        return patientId;
    }
    
    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getNationalId() {
        return nationalId;
    }
    
    public void setNationalId(String nationalId) {
        this.nationalId = nationalId;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public LocalDate getDob() {
        return dob;
    }
    
    public void setDob(LocalDate dob) {
        this.dob = dob;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public LocalDateTime getLastVisit() {
        return lastVisit;
    }
    
    public void setLastVisit(LocalDateTime lastVisit) {
        this.lastVisit = lastVisit;
    }
    
    // Helper methods
    public String getFullName() {
        return firstName + " " + lastName;
    }
    
    @Override
    public String toString() {
        return "Patient{" +
                "patientId=" + patientId +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", nationalId='" + nationalId + '\'' +
                ", email='" + email + '\'' +
                ", dob=" + dob +
                '}';
    }
}

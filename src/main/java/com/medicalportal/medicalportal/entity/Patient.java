package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;


import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "patient")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "patient_id")
    private Integer id;

    @Column(name = "first_name", nullable = false, length = 100)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 100)
    private String lastName;

    @Column(name = "national_id", nullable = false, unique = true, length = 20)
    private String nationalId;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "gender", length = 10)
    private String gender;

    @Lob
    @Column(name = "address")
    private String address;

    @Column(name = "dob", nullable = false)
    private LocalDate dob;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<PatientPhone> phoneNumbers = new HashSet<>();

    @OneToMany(mappedBy = "patient")
    private Set<MedicalReport> medicalReports = new HashSet<>();

    @OneToMany(mappedBy = "patient")
    private Set<Bill> bills = new HashSet<>();

    // Getters and setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getNationalId() { return nationalId; }
    public void setNationalId(String nationalId) { this.nationalId = nationalId; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public Set<PatientPhone> getPhoneNumbers() { return phoneNumbers; }
    public void setPhoneNumbers(Set<PatientPhone> phoneNumbers) { this.phoneNumbers = phoneNumbers; }
    public Set<MedicalReport> getMedicalReports() { return medicalReports; }
    public void setMedicalReports(Set<MedicalReport> medicalReports) { this.medicalReports = medicalReports; }
    public Set<Bill> getBills() { return bills; }
    public void setBills(Set<Bill> bills) { this.bills = bills; }

    // Helper method
    public void addPhoneNumber(String phoneNumber) {
        PatientPhone patientPhone = new PatientPhone(this, phoneNumber);
        this.phoneNumbers.add(patientPhone);
    }


}

package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;

@Entity
@Table(name = "doctor")
public class Patient_Doctor {

    @Id
    @Column(name = "eid")
    private Integer eid;

    @Column(name = "specialization", length = 255)
    private String specialization;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "eid", insertable = false, updatable = false)
    private Patient_Employee employee;

    // Constructors
    public Patient_Doctor() {
    }

    public Patient_Doctor(Integer eid, String specialization) {
        this.eid = eid;
        this.specialization = specialization;
    }

    // Getters and Setters
    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public Patient_Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Patient_Employee employee) {
        this.employee = employee;
    }

    // Convenience methods
    public String getFullName() {
        return employee != null ? "Dr. " + employee.getFullName() : "Unknown Doctor";
    }

    public String getFirstName() {
        return employee != null ? employee.getFirstName() : "";
    }

    public String getLastName() {
        return employee != null ? employee.getLastName() : "";
    }
}

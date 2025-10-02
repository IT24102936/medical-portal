package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "doctor")
public class Doctor {
    @Id
    @Column(name = "eid")
    private Integer eid;

    @Column(name = "specialization")
    private String specialization;

    @OneToOne
    @MapsId
    @JoinColumn(name = "eid")
    private Employee employee;

    // Getters and setters
    public Integer getEid() { return eid; }
    public void setEid(Integer eid) { this.eid = eid; }
    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }
    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }
}
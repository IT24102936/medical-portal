package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "doctor")
public class Doctor {
    
    @Id
    @Column(name = "eid")
    private Long eid;
    
    @Column(name = "specialization")
    private String specialization;
    
    @Column(name = "available")
    private Boolean available;
    
    // Constructors
    public Doctor() {}
    
    public Doctor(Long eid, String specialization, Boolean available) {
        this.eid = eid;
        this.specialization = specialization;
        this.available = available;
    }
    
    // Getters and Setters
    public Long getEid() {
        return eid;
    }
    
    public void setEid(Long eid) {
        this.eid = eid;
    }
    
    public String getSpecialization() {
        return specialization;
    }
    
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    
    public Boolean getAvailable() {
        return available;
    }
    
    public void setAvailable(Boolean available) {
        this.available = available;
    }
    
    @Override
    public String toString() {
        return "Doctor{" +
                "eid=" + eid +
                ", specialization='" + specialization + '\'' +
                ", available=" + available +
                '}';
    }
}

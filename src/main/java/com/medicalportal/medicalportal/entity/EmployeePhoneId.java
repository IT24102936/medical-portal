package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class EmployeePhoneId implements Serializable {
    private Long eid;
    private String phoneNumber;

    public EmployeePhoneId() {}

    public EmployeePhoneId(Long eid, String phoneNumber) {
        this.eid = eid;
        this.phoneNumber = phoneNumber;
    }

    // Getters and setters
    public Long getEid() { return eid; }
    public void setEid(Long eid) { this.eid = eid; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EmployeePhoneId that = (EmployeePhoneId) o;
        return Objects.equals(eid, that.eid) && Objects.equals(phoneNumber, that.phoneNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eid, phoneNumber);
    }
}


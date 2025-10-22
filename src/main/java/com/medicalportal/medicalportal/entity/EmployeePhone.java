package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "employee_phone")
public class EmployeePhone {
    @EmbeddedId
    private EmployeePhoneId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("eid")
    @JoinColumn(name = "eid")
    private Employee employee;

    public EmployeePhone() {}

    public EmployeePhone(Employee employee, String phoneNumber) {
        this.employee = employee;
        this.id = new EmployeePhoneId(employee.getId(), phoneNumber);
    }

    // Getters and setters
    public EmployeePhoneId getId() { return id; }
    public void setId(EmployeePhoneId id) { this.id = id; }
    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }

    // Convenience method
    public String getPhoneNumber() {
        return id != null ? id.getPhoneNumber() : null;
    }
}

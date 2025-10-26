package com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "pharmacist")
public class Lab_Phar_Pharmacist {
    @Id
    @Column(name = "eid", nullable = false)
    private Integer id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "eid", nullable = false)
    private Lab_Phar_Employee employee;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Lab_Phar_Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Lab_Phar_Employee employee) {
        this.employee = employee;
    }

}
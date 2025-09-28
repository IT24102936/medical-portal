package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;

@Entity
@Table(name = "doctor_issues_lab_order")
public class DoctorIssuesLabOrder {
    @EmbeddedId
    private DoctorIssuesLabOrderId id;

    @MapsId("doctorEid")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "doctor_eid", nullable = false)
    private Doctor doctorEid;

    @MapsId("labOrderId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "lab_order_id", nullable = false)
    private LabOrder labOrder;

    @MapsId("patientId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;

    public DoctorIssuesLabOrderId getId() {
        return id;
    }

    public void setId(DoctorIssuesLabOrderId id) {
        this.id = id;
    }

    public Doctor getDoctorEid() {
        return doctorEid;
    }

    public void setDoctorEid(Doctor doctorEid) {
        this.doctorEid = doctorEid;
    }

    public LabOrder getLabOrder() {
        return labOrder;
    }

    public void setLabOrder(LabOrder labOrder) {
        this.labOrder = labOrder;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

}
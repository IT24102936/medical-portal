package com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.Lab_Phar_Patient;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;

@Entity
@Table(name = "doctor_issues_lab_order")
public class Lab_Phar_DoctorIssuesLabOrder {
    @EmbeddedId
    private Lab_Phar_DoctorIssuesLabOrderId id;

    @MapsId("doctorEid")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "doctor_eid", nullable = false)
    private Lab_Phar_Doctor doctorEid;

    @MapsId("labOrderId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "lab_order_id", nullable = false)
    private Lab_Phar_LabOrder labOrder;

    @MapsId("patientId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "patient_id", nullable = false)
    private Lab_Phar_Patient patient;

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;

    public Lab_Phar_DoctorIssuesLabOrderId getId() {
        return id;
    }

    public void setId(Lab_Phar_DoctorIssuesLabOrderId id) {
        this.id = id;
    }

    public Lab_Phar_Doctor getDoctorEid() {
        return doctorEid;
    }

    public void setDoctorEid(Lab_Phar_Doctor doctorEid) {
        this.doctorEid = doctorEid;
    }

    public Lab_Phar_LabOrder getLabOrder() {
        return labOrder;
    }

    public void setLabOrder(Lab_Phar_LabOrder labOrder) {
        this.labOrder = labOrder;
    }

    public Lab_Phar_Patient getPatient() {
        return patient;
    }

    public void setPatient(Lab_Phar_Patient patient) {
        this.patient = patient;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

}
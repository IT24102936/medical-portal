package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;


@Entity
@Table(name = "doctor_issues_lab_order")
public class Patient_DoctorIssuesLabOrder {
    @EmbeddedId
    private Patient_DoctorIssuesLabOrderId id;

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient_Patient patient;

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;

}

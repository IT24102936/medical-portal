package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;



@Entity
@Table(name = "pharmacist_issues_medicine")
public class Patient_PharmacistIssuesMedicine {
    @EmbeddedId
    private Patient_PharmacistIssuesMedicineId id;

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient_Patient patient;

    @Column(name = "amount", nullable = false)
    private Integer amount;

}

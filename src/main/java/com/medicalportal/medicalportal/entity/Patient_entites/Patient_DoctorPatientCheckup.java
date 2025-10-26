package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;


@Entity
@Table(name = "doctor_patient_checkup")
public class Patient_DoctorPatientCheckup {
    @EmbeddedId
    private Patient_DoctorPatientCheckupId id;

    @MapsId
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient_Patient patient;

    @Lob
    @Column(name = "notes")
    private String notes;

}

package com.medicalportal.medicalportal.entity.Patient_entites;

import jakarta.persistence.*;



@Entity
@Table(name = "prescription")
public class Patient_Prescription {
    @Id
    @Column(name = "prescription_id", nullable = false)
    private Integer id;

    @Lob
    @Column(name = "description", nullable = false)
    private String description;

}

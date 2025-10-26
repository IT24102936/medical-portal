package com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities;

import jakarta.persistence.*;

@Entity
@Table(name = "lab_order")
public class Lab_Phar_LabOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lab_order_id", nullable = false)
    private Integer id;

    @Lob
    @Column(name = "description", nullable = false)
    private String description;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
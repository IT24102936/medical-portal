package com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities;

import jakarta.persistence.*;

@Entity
@Table(name = "medicine_inventory")
public class Lab_Phar_MedicineInventory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inventory_id", nullable = false)
    private Integer id;

    @Column(name = "count", nullable = false)
    private Integer count;

    @Lob
    @Column(name = "description")
    private String description;

    @Column(name = "pharmacist_eid")
    private Integer pharmacistEid;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getPharmacistEid() {
        return pharmacistEid;
    }

    public void setPharmacistEid(Integer pharmacistEid) {
        this.pharmacistEid = pharmacistEid;
    }
}
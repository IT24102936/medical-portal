package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "medicine_inventory")
public class MedicineInventory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inventory_id")
    private Long id;

    @Column(name = "count", nullable = false)
    private Integer count;

    private String description;

    @ManyToOne
    @JoinColumn(name = "pharmacist_eid", nullable = false)
    private Pharmacist pharmacist;

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Integer getCount() { return count; }
    public void setCount(Integer count) { this.count = count; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Pharmacist getPharmacist() { return pharmacist; }
    public void setPharmacist(Pharmacist pharmacist) { this.pharmacist = pharmacist; }
}



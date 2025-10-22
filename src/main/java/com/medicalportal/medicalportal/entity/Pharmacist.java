package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "pharmacist")
@PrimaryKeyJoinColumn(name = "eid")
public class Pharmacist extends Employee {

    @OneToMany(mappedBy = "pharmacist")
    private Set<MedicineInventory> inventories = new HashSet<>();

    // Getters and setters
    public Set<MedicineInventory> getInventories() { return inventories; }
    public void setInventories(Set<MedicineInventory> inventories) { this.inventories = inventories; }
}


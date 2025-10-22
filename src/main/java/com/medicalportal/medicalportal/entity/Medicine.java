package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "medicine")
public class Medicine {
    @Id
    @Column(name = "medicine_code")
    private String medicineCode;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private BigDecimal price;

    // Getters and setters
    public String getMedicineCode() { return medicineCode; }
    public void setMedicineCode(String medicineCode) { this.medicineCode = medicineCode; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
}


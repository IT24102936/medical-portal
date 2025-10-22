package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "prescription")
public class PrescriptionDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "prescription_id")
    private Long id;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String description;

    // Default constructor
    public PrescriptionDetails() {}

    // Parameterized constructor
    public PrescriptionDetails(String description) {
        this.description = description;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    @Override
    public String toString() {
        return "PrescriptionDetails{" +
                "id=" + id +
                ", description='" + description + '\'' +
                '}';
    }

    public void setPatient(Patient patient) {
    }
}
package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "lab_technician")
@PrimaryKeyJoinColumn(name = "eid")
public class LabTechnician extends Employee {
    // Lab technician specific fields can be added here
}

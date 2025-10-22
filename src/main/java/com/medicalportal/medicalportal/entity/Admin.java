package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "admin")
@PrimaryKeyJoinColumn(name = "eid")
public class Admin extends Employee {
    // Additional admin-specific fields can be added here
}


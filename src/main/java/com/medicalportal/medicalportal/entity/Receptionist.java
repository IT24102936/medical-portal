package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "receptionist")
@PrimaryKeyJoinColumn(name = "eid")
public class Receptionist extends Employee {

    @OneToMany(mappedBy = "receptionist")
    private Set<Appointment> appointments = new HashSet<>();

    // Getters and setters
    public Set<Appointment> getAppointments() { return appointments; }
    public void setAppointments(Set<Appointment> appointments) { this.appointments = appointments; }
}


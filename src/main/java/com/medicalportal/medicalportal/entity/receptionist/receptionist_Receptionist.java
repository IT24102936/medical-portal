package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "receptionist")
public class receptionist_Receptionist {
    @Id
    @Column(name = "eid", nullable = false)
    private Integer id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "eid", nullable = false)
    private receptionist_Employee employee;
    
    @OneToMany(mappedBy = "receptionistEid")
    private Set<receptionist_Appointment> appointments = new LinkedHashSet<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public receptionist_Employee getEmployee() {
        return employee;
    }

    public void setEmployee(receptionist_Employee employee) {
        this.employee = employee;
    }
    
    public Set<receptionist_Appointment> getAppointments() {
        return appointments;
    }
    
    public void setAppointments(Set<receptionist_Appointment> appointments) {
        this.appointments = appointments;
    }

}

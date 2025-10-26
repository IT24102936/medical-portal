package com.medicalportal.medicalportal.entity.receptionist;

import jakarta.persistence.*;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "doctor")
public class receptionist_Doctor {
    @Id
    @Column(name = "eid", nullable = false)
    private Integer id;

    @Column(name = "specialization")
    private String specialization;
    
    @Column(name = "available")
    private Boolean available = true;
    
    @ManyToMany(mappedBy = "doctors")
    private Set<receptionist_Appointment> appointments = new LinkedHashSet<>();
    
    @OneToOne
    @JoinColumn(name = "eid", referencedColumnName = "eid", insertable = false, updatable = false)
    private receptionist_Employee employee;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    
    public Boolean getAvailable() {
        return available;
    }
    
    public void setAvailable(Boolean available) {
        this.available = available;
    }
    
    public Set<receptionist_Appointment> getAppointments() {
        return appointments;
    }
    
    public void setAppointments(Set<receptionist_Appointment> appointments) {
        this.appointments = appointments;
    }
    
    public receptionist_Employee getEmployee() {
        return employee;
    }
    
    public void setEmployee(receptionist_Employee employee) {
        this.employee = employee;
    }
    
    // Convenience method to get doctor's full name
    public String getFullName() {
        if (employee != null) {
            return employee.getFirstName() + " " + employee.getLastName();
        }
        return "Dr. " + id;
    }
    
    // Convenience method for backward compatibility
    public Integer getEid() {
        return id;
    }
    
    public void setEid(Integer eid) {
        this.id = eid;
    }

}

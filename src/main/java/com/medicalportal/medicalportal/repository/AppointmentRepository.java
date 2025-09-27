package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {
}
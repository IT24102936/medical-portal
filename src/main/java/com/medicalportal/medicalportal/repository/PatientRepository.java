package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientRepository extends JpaRepository<Patient, Integer> {
}
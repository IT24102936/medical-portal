package com.medicalportal.medicalportal.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import  com.medicalportal.medicalportal.entity.Patient;
import java.util.Optional;

public interface PatientRepository extends JpaRepository<Patient, Integer> {
    Optional<Patient> findById(Integer id);
}
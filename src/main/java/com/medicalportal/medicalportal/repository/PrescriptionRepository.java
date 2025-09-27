package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PrescriptionRepository extends JpaRepository<Prescription, Integer> {
}
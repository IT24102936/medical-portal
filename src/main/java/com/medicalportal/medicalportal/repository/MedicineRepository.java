package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MedicineRepository extends JpaRepository<Medicine, String> {
}
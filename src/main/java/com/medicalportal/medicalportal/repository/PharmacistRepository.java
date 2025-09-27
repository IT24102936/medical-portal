package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Pharmacist;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PharmacistRepository extends JpaRepository<Pharmacist, Integer> {
}
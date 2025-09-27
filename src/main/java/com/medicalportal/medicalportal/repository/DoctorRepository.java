package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepository extends JpaRepository<Doctor, Integer> {
}
package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.MedicalReport;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MedicalReportRepository extends JpaRepository<MedicalReport, Integer> {
}
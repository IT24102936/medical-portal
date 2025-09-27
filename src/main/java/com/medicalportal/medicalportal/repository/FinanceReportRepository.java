package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.FinanceReport;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FinanceReportRepository extends JpaRepository<FinanceReport, Integer> {
}
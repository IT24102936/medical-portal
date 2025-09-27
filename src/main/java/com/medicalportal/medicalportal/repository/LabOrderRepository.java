package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.LabOrder;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LabOrderRepository extends JpaRepository<LabOrder, Integer> {
}
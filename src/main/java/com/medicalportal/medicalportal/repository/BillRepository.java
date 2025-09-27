package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Bill;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BillRepository extends JpaRepository<Bill, Integer> {
}
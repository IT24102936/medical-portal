package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
}
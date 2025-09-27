package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Receptionist;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReceptionistRepository extends JpaRepository<Receptionist, Integer> {
}
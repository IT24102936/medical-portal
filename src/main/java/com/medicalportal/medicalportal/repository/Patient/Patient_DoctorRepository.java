package com.medicalportal.medicalportal.repository.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Patient_DoctorRepository extends JpaRepository<Patient_Doctor, Integer> {

    @Query("SELECT d FROM Patient_Doctor d JOIN FETCH d.employee")
    List<Patient_Doctor> findAllWithEmployee();
}

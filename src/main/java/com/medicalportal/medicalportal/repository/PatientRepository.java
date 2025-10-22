package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Integer> {
    Patient findByEmail(String email);
    boolean existsByEmail(String email);

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END " +
            "FROM patient WHERE email = :email AND patient_id <> :id",
            nativeQuery = true)
    boolean existsByEmailAndPatient_idNot(String email, Integer id);

    @Query("SELECT p FROM Patient p LEFT JOIN FETCH p.patientPhones WHERE p.id = :id")
    Optional<Patient> findByIdWithPhones(@Param("id") Integer id);
}
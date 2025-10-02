package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Integer> {

    // Get all patients with their phone numbers
    @Query(value = """
        SELECT p.patient_id, p.first_name, p.last_name, p.email, p.gender, p.dob, 
               p.national_id, p.user_name, p.status,
               GROUP_CONCAT(pp.phone_number SEPARATOR ', ') as phone_numbers
        FROM patient p
        LEFT JOIN patient_phone pp ON p.patient_id = pp.patient_id
        GROUP BY p.patient_id, p.first_name, p.last_name, p.email, p.gender, p.dob, 
                 p.national_id, p.user_name, p.status
        ORDER BY p.first_name, p.last_name
        """, nativeQuery = true)
    List<Map<String, Object>> findAllPatientsWithPhones();

    // Get patient by ID with phone numbers
    @Query(value = """
        SELECT p.patient_id, p.first_name, p.last_name, p.email, p.gender, p.dob, 
               p.national_id, p.user_name, p.status,
               GROUP_CONCAT(pp.phone_number SEPARATOR ', ') as phone_numbers
        FROM patient p
        LEFT JOIN patient_phone pp ON p.patient_id = pp.patient_id
        WHERE p.patient_id = :patientId
        GROUP BY p.patient_id, p.first_name, p.last_name, p.email, p.gender, p.dob, 
                 p.national_id, p.user_name, p.status
        """, nativeQuery = true)
    Optional<Map<String, Object>> findPatientByIdWithPhones(@Param("patientId") Integer patientId);

    // Update patient information
    @Modifying
    @Transactional
    @Query(value = """
        UPDATE patient SET 
        first_name = :firstName, 
        last_name = :lastName, 
        email = :email, 
        gender = :gender, 
        dob = :dob, 
        national_id = :nationalId, 
        user_name = :userName
        WHERE patient_id = :patientId
        """, nativeQuery = true)
    void updatePatient(@Param("patientId") Integer patientId,
                       @Param("firstName") String firstName,
                       @Param("lastName") String lastName,
                       @Param("email") String email,
                       @Param("gender") String gender,
                       @Param("dob") LocalDate dob,
                       @Param("nationalId") String nationalId,
                       @Param("userName") String userName);

    // Disable patient
    @Modifying
    @Transactional
    @Query(value = "UPDATE patient SET status = 'DISABLED' WHERE patient_id = :patientId", nativeQuery = true)
    void disablePatient(@Param("patientId") Integer patientId);

    // Enable patient
    @Modifying
    @Transactional
    @Query(value = "UPDATE patient SET status = 'ACTIVE' WHERE patient_id = :patientId", nativeQuery = true)
    void enablePatient(@Param("patientId") Integer patientId);

    // Delete patient related records (appointments, checkups, etc.)
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM patient_phone WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientPhones(@Param("patientId") Integer patientId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM appointment WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientAppointments(@Param("patientId") Integer patientId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_patient_checkup WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientCheckups(@Param("patientId") Integer patientId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM patient_report WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientReports(@Param("patientId") Integer patientId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM prescription WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientPrescriptions(@Param("patientId") Integer patientId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM lab_order WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientLabOrders(@Param("patientId") Integer patientId);

    // Delete patient record
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM patient WHERE patient_id = :patientId", nativeQuery = true)
    void deletePatientRecord(@Param("patientId") Integer patientId);

    // Insert new patient
    @Modifying
    @Transactional
    @Query(value = """
        INSERT INTO patient (patient_id, first_name, last_name, email, gender, dob, 
                           national_id, user_name, password, status)
        VALUES (:patientId, :firstName, :lastName, :email, :gender, :dob, 
                :nationalId, :userName, :password, 'ACTIVE')
        """, nativeQuery = true)
    void insertPatient(@Param("patientId") Integer patientId,
                       @Param("firstName") String firstName,
                       @Param("lastName") String lastName,
                       @Param("email") String email,
                       @Param("gender") String gender,
                       @Param("dob") LocalDate dob,
                       @Param("nationalId") String nationalId,
                       @Param("userName") String userName,
                       @Param("password") String password);

    // Insert phone number
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO patient_phone (patient_id, phone_number) VALUES (:patientId, :phoneNumber)", nativeQuery = true)
    void insertPhoneNumber(@Param("patientId") Integer patientId, @Param("phoneNumber") String phoneNumber);

    // Update patient password
    @Modifying
    @Transactional
    @Query(value = "UPDATE patient SET password = :password WHERE patient_id = :patientId", nativeQuery = true)
    void updatePatientPassword(@Param("patientId") Integer patientId, @Param("password") String password);

    // Get next available patient ID
    @Query(value = "SELECT COALESCE(MAX(patient_id), 0) + 1 FROM patient", nativeQuery = true)
    Integer getNextPatientId();

    // Get phone numbers for a patient
    @Query(value = "SELECT phone_number FROM patient_phone WHERE patient_id = :patientId", nativeQuery = true)
    List<String> getPhoneNumbersByPid(@Param("patientId") Integer patientId);
}
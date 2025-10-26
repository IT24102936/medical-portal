package com.medicalportal.medicalportal.repository.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface Patient_AppointmentRepository extends JpaRepository<Patient_Appointment, Integer> {

    @Query("SELECT a FROM Patient_Appointment a WHERE a.patient.id = :patientId")
    List<Patient_Appointment> findByPatientId(@Param("patientId") Integer patientId);

    @Query("SELECT a FROM Patient_Appointment a WHERE a.doctorEid = :doctorId")
    List<Patient_Appointment> findByDoctorId(@Param("doctorId") Integer doctorId);

    @Query("SELECT a FROM Patient_Appointment a WHERE a.patient.id = :patientId AND a.appointmentDatetime = :dateTime")
    List<Patient_Appointment> findByPatientIdAndDateTime(@Param("patientId") Integer patientId,
                                                 @Param("dateTime") LocalDateTime dateTime);

    @Query("SELECT a FROM Patient_Appointment a WHERE a.doctorEid = :doctorId AND a.appointmentDatetime = :dateTime")
    List<Patient_Appointment> findByDoctorIdAndDateTime(@Param("doctorId") Integer doctorId,
                                                @Param("dateTime") LocalDateTime dateTime);

    List<Patient_Appointment> findByStatus(String status);
}

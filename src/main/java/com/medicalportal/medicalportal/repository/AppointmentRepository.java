package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId")
    List<Appointment> findByDoctorId(@Param("doctorId") Long doctorId);

    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND DATE(a.appointmentTime) = :date")
    List<Appointment> findByDoctorIdAndAppointmentDate(@Param("doctorId") Long doctorId, @Param("date") LocalDate date);

    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND DATE(a.appointmentTime) BETWEEN :startDate AND :endDate")
    List<Appointment> findByDoctorIdAndAppointmentDateBetween(@Param("doctorId") Long doctorId,
                                                              @Param("startDate") LocalDate startDate,
                                                              @Param("endDate") LocalDate endDate);

    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND DATE(a.appointmentTime) BETWEEN :startDate AND :endDate AND a.status = :status")
    List<Appointment> findByDoctorIdAndAppointmentDateBetweenAndStatus(@Param("doctorId") Long doctorId,
                                                                       @Param("startDate") LocalDate startDate,
                                                                       @Param("endDate") LocalDate endDate,
                                                                       @Param("status") String status);


    List<Appointment> findByStatus(String status);

    @Query("SELECT a FROM Appointment a WHERE a.appointmentTime BETWEEN :startDateTime AND :endDateTime")
    List<Appointment> findByAppointmentTimeBetween(@Param("startDateTime") LocalDateTime startDateTime,
                                                   @Param("endDateTime") LocalDateTime endDateTime);

    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.appointmentTime BETWEEN :startDateTime AND :endDateTime")
    List<Appointment> findByDoctorIdAndAppointmentTimeBetween(@Param("doctorId") Long doctorId,
                                                              @Param("startDateTime") LocalDateTime startDateTime,
                                                              @Param("endDateTime") LocalDateTime endDateTime);

    // Query appointments by patient ID using the junction table
    @Query("SELECT a FROM Appointment a JOIN a.patients p WHERE p.id = :patientId")
    List<Appointment> findByPatientId(@Param("patientId") Integer patientId);

    //  Get appointments for a patient with specific status
    @Query("SELECT a FROM Appointment a JOIN a.patients p WHERE p.id = :patientId AND a.status = :status")
    List<Appointment> findByPatientIdAndStatus(@Param("patientId") Integer patientId, @Param("status") String status);

}

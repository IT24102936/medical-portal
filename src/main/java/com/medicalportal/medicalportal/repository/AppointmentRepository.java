package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    
    // Find appointments by doctor name
    List<Appointment> findByDoctorNameContainingIgnoreCase(String doctorName);
    
    // Find appointments by patient name
    List<Appointment> findByPatientNameContainingIgnoreCase(String patientName);
    
    // Find appointments by status
    List<Appointment> findByStatus(String status);
    
    // Find appointments by date range
    List<Appointment> findByAppointmentTimeBetween(LocalDateTime startTime, LocalDateTime endTime);
    
    // Find appointments by date
    @Query("SELECT a FROM Appointment a WHERE DATE(a.appointmentTime) = DATE(:date)")
    List<Appointment> findByAppointmentDate(LocalDateTime date);
    
    // Find appointments by doctor and date
    @Query("SELECT a FROM Appointment a WHERE a.doctorName = :doctorName AND DATE(a.appointmentTime) = DATE(:date)")
    List<Appointment> findByDoctorAndDate(String doctorName, LocalDateTime date);
    
    // Find upcoming appointments (future appointments)
    @Query("SELECT a FROM Appointment a WHERE a.appointmentTime > :now AND a.status = 'Scheduled' ORDER BY a.appointmentTime ASC")
    List<Appointment> findUpcomingAppointments(LocalDateTime now);
    
    // Find past appointments
    @Query("SELECT a FROM Appointment a WHERE a.appointmentTime < :now ORDER BY a.appointmentTime DESC")
    List<Appointment> findPastAppointments(LocalDateTime now);
    
    // Find canceled appointments
    List<Appointment> findByStatusOrderByAppointmentTimeDesc(String status);
}

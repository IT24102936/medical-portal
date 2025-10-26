package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface receptionist_AppointmentRepository extends JpaRepository<receptionist_Appointment, Integer> {
    
    // Note: Doctor and patient name searches would need custom queries using relationships
    
    // Find appointments by status
    List<receptionist_Appointment> findByStatus(String status);
    
    // Find appointments by date range
    List<receptionist_Appointment> findByAppointmentTimeBetween(LocalDateTime startTime, LocalDateTime endTime);
    
    // Find appointments by date
    @Query("SELECT a FROM receptionist_Appointment a WHERE DATE(a.appointmentTime) = DATE(:date)")
    List<receptionist_Appointment> findByAppointmentDate(LocalDateTime date);
    
    // Find appointments by doctor and date (would need custom query with relationships)
    // List<receptionist_Appointment> findByDoctorAndDate(String doctorName, LocalDateTime date);
    
    // Find upcoming appointments (future appointments)
    @Query("SELECT a FROM receptionist_Appointment a WHERE a.appointmentTime > :now AND a.status = 'Scheduled' ORDER BY a.appointmentTime ASC")
    List<receptionist_Appointment> findUpcomingAppointments(LocalDateTime now);
    
    // Find past appointments
    @Query("SELECT a FROM receptionist_Appointment a WHERE a.appointmentTime < :now ORDER BY a.appointmentTime DESC")
    List<receptionist_Appointment> findPastAppointments(LocalDateTime now);
    
    // Find canceled appointments
    List<receptionist_Appointment> findByStatusOrderByAppointmentTimeDesc(String status);
}

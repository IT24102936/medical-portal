package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface TimeSlotRepository extends JpaRepository<TimeSlot, Long> {
    
    // Find time slots by doctor ID and date
    List<TimeSlot> findByDoctorIdAndDate(Long doctorId, LocalDate date);
    
    // Find available time slots by doctor ID and date
    List<TimeSlot> findByDoctorIdAndDateAndIsAvailable(Long doctorId, LocalDate date, Boolean isAvailable);
    
    // Find time slots by doctor ID, date, and time
    TimeSlot findByDoctorIdAndDateAndTimeSlot(Long doctorId, LocalDate date, LocalTime timeSlot);
    
    // Find time slots by appointment ID
    List<TimeSlot> findByAppointmentId(Long appointmentId);
    
    // Find available time slots for a specific date range
    @Query("SELECT t FROM TimeSlot t WHERE t.doctorId = :doctorId AND t.date = :date AND t.isAvailable = true ORDER BY t.timeSlot")
    List<TimeSlot> findAvailableTimeSlotsForDoctorAndDate(Long doctorId, LocalDate date);
    
    // Find booked time slots for a specific date
    @Query("SELECT t FROM TimeSlot t WHERE t.doctorId = :doctorId AND t.date = :date AND t.isAvailable = false ORDER BY t.timeSlot")
    List<TimeSlot> findBookedTimeSlotsForDoctorAndDate(Long doctorId, LocalDate date);
}

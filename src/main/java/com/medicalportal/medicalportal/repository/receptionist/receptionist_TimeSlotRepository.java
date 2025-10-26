package com.medicalportal.medicalportal.repository.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface receptionist_TimeSlotRepository extends JpaRepository<receptionist_TimeSlot, Long> {
    
    // Find time slots by doctor ID and date
    List<receptionist_TimeSlot> findByDoctorIdAndDate(Integer doctorId, LocalDate date);
    
    // Find available time slots by doctor ID and date
    List<receptionist_TimeSlot> findByDoctorIdAndDateAndIsAvailable(Integer doctorId, LocalDate date, Boolean isAvailable);
    
    // Find time slots by doctor ID, date, and time
    receptionist_TimeSlot findByDoctorIdAndDateAndTimeSlot(Integer doctorId, LocalDate date, LocalTime timeSlot);
    
    // Find time slots by appointment ID
    List<receptionist_TimeSlot> findByAppointmentId(Long appointmentId);
    
    // Find available time slots for a specific date range
    @Query("SELECT t FROM receptionist_TimeSlot t WHERE t.doctorId = :doctorId AND t.date = :date AND t.isAvailable = true ORDER BY t.timeSlot")
    List<receptionist_TimeSlot> findAvailableTimeSlotsForDoctorAndDate(Integer doctorId, LocalDate date);
    
    // Find booked time slots for a specific date
    @Query("SELECT t FROM receptionist_TimeSlot t WHERE t.doctorId = :doctorId AND t.date = :date AND t.isAvailable = false ORDER BY t.timeSlot")
    List<receptionist_TimeSlot> findBookedTimeSlotsForDoctorAndDate(Integer doctorId, LocalDate date);
}

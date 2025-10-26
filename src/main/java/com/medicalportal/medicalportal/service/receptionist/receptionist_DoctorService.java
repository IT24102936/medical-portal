package com.medicalportal.medicalportal.service.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Doctor;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_DoctorSchedule;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_TimeSlot;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_DoctorRepository;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_DoctorScheduleRepository;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_TimeSlotRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class receptionist_DoctorService {
    
    @Autowired
    private receptionist_DoctorRepository doctorRepository;
    
    @Autowired
    private receptionist_DoctorScheduleRepository doctorScheduleRepository;
    
    @Autowired
    private receptionist_TimeSlotRepository timeSlotRepository;
    
    // Get all doctors
    public List<receptionist_Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }
    
    // Get doctor by ID
    public Optional<receptionist_Doctor> getDoctorById(Integer id) {
        return doctorRepository.findById(id);
    }
    
    // Get doctors by specialization
    public List<receptionist_Doctor> getDoctorsBySpecialization(String specialization) {
        return doctorRepository.findBySpecialization(specialization);
    }
    
    // Get available doctors
    public List<receptionist_Doctor> getAvailableDoctors() {
        return doctorRepository.findByAvailable(true);
    }
    
    // Get doctors by specialization and availability
    public List<receptionist_Doctor> getDoctorsBySpecializationAndAvailability(String specialization, Boolean available) {
        return doctorRepository.findBySpecializationAndAvailable(specialization, available);
    }
    
    // Save or update doctor
    public receptionist_Doctor saveDoctor(receptionist_Doctor doctor) {
        return doctorRepository.save(doctor);
    }
    
    // Delete doctor
    public void deleteDoctor(Integer id) {
        doctorRepository.deleteById(id);
    }
    
    // Update doctor availability
    public receptionist_Doctor updateDoctorAvailability(Integer id, Boolean available) {
        Optional<receptionist_Doctor> doctorOpt = doctorRepository.findById(id);
        if (doctorOpt.isPresent()) {
            receptionist_Doctor doctor = doctorOpt.get();
            doctor.setAvailable(available);
            return doctorRepository.save(doctor);
        }
        return null;
    }
    
    // Schedule Management Methods
    
    // Get doctor's weekly schedule
    public List<receptionist_DoctorSchedule> getDoctorSchedule(Integer doctorId) {
        return doctorScheduleRepository.findByDoctorId(doctorId);
    }
    
    // Save or update doctor schedule
    public receptionist_DoctorSchedule saveDoctorSchedule(receptionist_DoctorSchedule schedule) {
        return doctorScheduleRepository.save(schedule);
    }
    
    // Update doctor's weekly schedule
    public void updateDoctorWeeklySchedule(Integer doctorId, String dayOfWeek, String startTime, String endTime, Boolean isAvailable) {
        // Check if schedule exists for this doctor and day
        List<receptionist_DoctorSchedule> existingSchedules = doctorScheduleRepository.findByDoctorIdAndDayOfWeek(doctorId, dayOfWeek);
        
        if (!existingSchedules.isEmpty()) {
            // Update existing schedule
            receptionist_DoctorSchedule schedule = existingSchedules.get(0);
            schedule.setStartTime(startTime);
            schedule.setEndTime(endTime);
            schedule.setIsAvailable(isAvailable);
            doctorScheduleRepository.save(schedule);
        } else {
            // Create new schedule
            receptionist_DoctorSchedule newSchedule = new receptionist_DoctorSchedule(doctorId, dayOfWeek, startTime, endTime, isAvailable);
            doctorScheduleRepository.save(newSchedule);
        }
    }
    
    // Get doctor availability for a specific date
    public List<receptionist_TimeSlot> getDoctorAvailability(Integer doctorId, LocalDate date) {
        return timeSlotRepository.findByDoctorIdAndDate(doctorId, date);
    }
    
    // Generate time slots for a doctor on a specific date
    public List<receptionist_TimeSlot> generateTimeSlotsForDate(Integer doctorId, LocalDate date) {
        List<receptionist_TimeSlot> timeSlots = new ArrayList<>();
        
        // Get doctor's schedule for the day of week
        String dayOfWeek = date.getDayOfWeek().toString();
        List<receptionist_DoctorSchedule> schedules = doctorScheduleRepository.findByDoctorIdAndDayOfWeekAndIsAvailable(doctorId, dayOfWeek, true);
        
        if (schedules.isEmpty()) {
            // If no specific schedule, use default 9 AM - 5 PM
            generateDefaultTimeSlots(doctorId, date, timeSlots);
        } else {
            // Use doctor's specific schedule
            receptionist_DoctorSchedule schedule = schedules.get(0);
            generateTimeSlotsFromSchedule(doctorId, date, schedule, timeSlots);
        }
        
        return timeSlots;
    }
    
    // Generate default time slots (9 AM - 5 PM, 30-minute intervals)
    private void generateDefaultTimeSlots(Integer doctorId, LocalDate date, List<receptionist_TimeSlot> timeSlots) {
        LocalTime startTime = LocalTime.of(9, 0);
        LocalTime endTime = LocalTime.of(17, 0);
        
        LocalTime currentTime = startTime;
        while (currentTime.isBefore(endTime)) {
            // Skip lunch break (12:00 PM - 2:00 PM)
            if (currentTime.equals(LocalTime.of(12, 0))) {
                currentTime = LocalTime.of(14, 0);
                continue;
            }
            
            receptionist_TimeSlot timeSlot = new receptionist_TimeSlot(doctorId, date, currentTime, true);
            timeSlots.add(timeSlot);
            currentTime = currentTime.plusMinutes(30);
        }
    }
    
    // Generate time slots from doctor's schedule
    private void generateTimeSlotsFromSchedule(Integer doctorId, LocalDate date, receptionist_DoctorSchedule schedule, List<receptionist_TimeSlot> timeSlots) {
        if (schedule.getIsAvailable()) {
            LocalTime startTime = LocalTime.parse(schedule.getStartTime());
            LocalTime endTime = LocalTime.parse(schedule.getEndTime());
            
            LocalTime currentTime = startTime;
            while (currentTime.isBefore(endTime)) {
                receptionist_TimeSlot timeSlot = new receptionist_TimeSlot(doctorId, date, currentTime, true);
                timeSlots.add(timeSlot);
                currentTime = currentTime.plusMinutes(30);
            }
        }
    }
    
    // Check if a specific time slot is available
    public boolean isTimeSlotAvailable(Integer doctorId, LocalDate date, LocalTime time) {
        receptionist_TimeSlot existingSlot = timeSlotRepository.findByDoctorIdAndDateAndTimeSlot(doctorId, date, time);
        return existingSlot == null || existingSlot.getIsAvailable();
    }
    
    // Book a time slot
    public receptionist_TimeSlot bookTimeSlot(Integer doctorId, LocalDate date, LocalTime time, Long appointmentId) {
        receptionist_TimeSlot timeSlot = timeSlotRepository.findByDoctorIdAndDateAndTimeSlot(doctorId, date, time);
        
        if (timeSlot == null) {
            // Create new time slot
            timeSlot = new receptionist_TimeSlot(doctorId, date, time, false);
        } else {
            // Update existing time slot
            timeSlot.setIsAvailable(false);
        }
        
        timeSlot.setAppointmentId(appointmentId);
        return timeSlotRepository.save(timeSlot);
    }
    
    // Cancel a time slot booking
    public void cancelTimeSlot(Integer doctorId, LocalDate date, LocalTime time) {
        receptionist_TimeSlot timeSlot = timeSlotRepository.findByDoctorIdAndDateAndTimeSlot(doctorId, date, time);
        if (timeSlot != null) {
            timeSlot.setIsAvailable(true);
            timeSlot.setAppointmentId(null);
            timeSlotRepository.save(timeSlot);
        }
    }
}

package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.entity.DoctorSchedule;
import com.medicalportal.medicalportal.entity.TimeSlot;
import com.medicalportal.medicalportal.repository.DoctorRepository;
import com.medicalportal.medicalportal.repository.DoctorScheduleRepository;
import com.medicalportal.medicalportal.repository.TimeSlotRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private DoctorScheduleRepository doctorScheduleRepository;
    
    @Autowired
    private TimeSlotRepository timeSlotRepository;
    
    // Get all doctors
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }
    
    // Get doctor by ID
    public Optional<Doctor> getDoctorById(Long id) {
        return doctorRepository.findById(id);
    }
    
    // Get doctors by specialization
    public List<Doctor> getDoctorsBySpecialization(String specialization) {
        return doctorRepository.findBySpecialization(specialization);
    }
    
    // Get available doctors
    public List<Doctor> getAvailableDoctors() {
        return doctorRepository.findByAvailable(true);
    }
    
    // Get doctors by specialization and availability
    public List<Doctor> getDoctorsBySpecializationAndAvailability(String specialization, Boolean available) {
        return doctorRepository.findBySpecializationAndAvailable(specialization, available);
    }
    
    // Save or update doctor
    public Doctor saveDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }
    
    // Delete doctor
    public void deleteDoctor(Long id) {
        doctorRepository.deleteById(id);
    }
    
    // Update doctor availability
    public Doctor updateDoctorAvailability(Long id, Boolean available) {
        Optional<Doctor> doctorOpt = doctorRepository.findById(id);
        if (doctorOpt.isPresent()) {
            Doctor doctor = doctorOpt.get();
            doctor.setAvailable(available);
            return doctorRepository.save(doctor);
        }
        return null;
    }
    
    // Schedule Management Methods
    
    // Get doctor's weekly schedule
    public List<DoctorSchedule> getDoctorSchedule(Long doctorId) {
        return doctorScheduleRepository.findByDoctorId(doctorId);
    }
    
    // Save or update doctor schedule
    public DoctorSchedule saveDoctorSchedule(DoctorSchedule schedule) {
        return doctorScheduleRepository.save(schedule);
    }
    
    // Update doctor's weekly schedule
    public void updateDoctorWeeklySchedule(Long doctorId, String dayOfWeek, String startTime, String endTime, Boolean isAvailable) {
        // Check if schedule exists for this doctor and day
        List<DoctorSchedule> existingSchedules = doctorScheduleRepository.findByDoctorIdAndDayOfWeek(doctorId, dayOfWeek);
        
        if (!existingSchedules.isEmpty()) {
            // Update existing schedule
            DoctorSchedule schedule = existingSchedules.get(0);
            schedule.setStartTime(startTime);
            schedule.setEndTime(endTime);
            schedule.setIsAvailable(isAvailable);
            doctorScheduleRepository.save(schedule);
        } else {
            // Create new schedule
            DoctorSchedule newSchedule = new DoctorSchedule(doctorId, dayOfWeek, startTime, endTime, isAvailable);
            doctorScheduleRepository.save(newSchedule);
        }
    }
    
    // Get doctor availability for a specific date
    public List<TimeSlot> getDoctorAvailability(Long doctorId, LocalDate date) {
        return timeSlotRepository.findByDoctorIdAndDate(doctorId, date);
    }
    
    // Generate time slots for a doctor on a specific date
    public List<TimeSlot> generateTimeSlotsForDate(Long doctorId, LocalDate date) {
        List<TimeSlot> timeSlots = new ArrayList<>();
        
        // Get doctor's schedule for the day of week
        String dayOfWeek = date.getDayOfWeek().toString();
        List<DoctorSchedule> schedules = doctorScheduleRepository.findByDoctorIdAndDayOfWeekAndIsAvailable(doctorId, dayOfWeek, true);
        
        if (schedules.isEmpty()) {
            // If no specific schedule, use default 9 AM - 5 PM
            generateDefaultTimeSlots(doctorId, date, timeSlots);
        } else {
            // Use doctor's specific schedule
            DoctorSchedule schedule = schedules.get(0);
            generateTimeSlotsFromSchedule(doctorId, date, schedule, timeSlots);
        }
        
        return timeSlots;
    }
    
    // Generate default time slots (9 AM - 5 PM, 30-minute intervals)
    private void generateDefaultTimeSlots(Long doctorId, LocalDate date, List<TimeSlot> timeSlots) {
        LocalTime startTime = LocalTime.of(9, 0);
        LocalTime endTime = LocalTime.of(17, 0);
        
        LocalTime currentTime = startTime;
        while (currentTime.isBefore(endTime)) {
            // Skip lunch break (12:00 PM - 2:00 PM)
            if (currentTime.equals(LocalTime.of(12, 0))) {
                currentTime = LocalTime.of(14, 0);
                continue;
            }
            
            TimeSlot timeSlot = new TimeSlot(doctorId, date, currentTime, true);
            timeSlots.add(timeSlot);
            currentTime = currentTime.plusMinutes(30);
        }
    }
    
    // Generate time slots from doctor's schedule
    private void generateTimeSlotsFromSchedule(Long doctorId, LocalDate date, DoctorSchedule schedule, List<TimeSlot> timeSlots) {
        if (schedule.getIsAvailable()) {
            LocalTime startTime = LocalTime.parse(schedule.getStartTime());
            LocalTime endTime = LocalTime.parse(schedule.getEndTime());
            
            LocalTime currentTime = startTime;
            while (currentTime.isBefore(endTime)) {
                TimeSlot timeSlot = new TimeSlot(doctorId, date, currentTime, true);
                timeSlots.add(timeSlot);
                currentTime = currentTime.plusMinutes(30);
            }
        }
    }
    
    // Check if a specific time slot is available
    public boolean isTimeSlotAvailable(Long doctorId, LocalDate date, LocalTime time) {
        TimeSlot existingSlot = timeSlotRepository.findByDoctorIdAndDateAndTimeSlot(doctorId, date, time);
        return existingSlot == null || existingSlot.getIsAvailable();
    }
    
    // Book a time slot
    public TimeSlot bookTimeSlot(Long doctorId, LocalDate date, LocalTime time, Long appointmentId) {
        TimeSlot timeSlot = timeSlotRepository.findByDoctorIdAndDateAndTimeSlot(doctorId, date, time);
        
        if (timeSlot == null) {
            // Create new time slot
            timeSlot = new TimeSlot(doctorId, date, time, false);
        } else {
            // Update existing time slot
            timeSlot.setIsAvailable(false);
        }
        
        timeSlot.setAppointmentId(appointmentId);
        return timeSlotRepository.save(timeSlot);
    }
    
    // Cancel a time slot booking
    public void cancelTimeSlot(Long doctorId, LocalDate date, LocalTime time) {
        TimeSlot timeSlot = timeSlotRepository.findByDoctorIdAndDateAndTimeSlot(doctorId, date, time);
        if (timeSlot != null) {
            timeSlot.setIsAvailable(true);
            timeSlot.setAppointmentId(null);
            timeSlotRepository.save(timeSlot);
        }
    }
}

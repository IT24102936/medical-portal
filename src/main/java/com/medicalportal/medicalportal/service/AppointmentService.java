package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Appointment;
import com.medicalportal.medicalportal.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
public class AppointmentService {
    
    @Autowired
    private AppointmentRepository appointmentRepository;
    
    // Save or update appointment
    public Appointment saveAppointment(Appointment appointment) {
        return appointmentRepository.save(appointment);
    }
    
    // Get all appointments
    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }
    
    // Get appointment by ID
    public Optional<Appointment> getAppointmentById(Long id) {
        return appointmentRepository.findById(id);
    }
    
    // Get appointments by doctor name
    public List<Appointment> getAppointmentsByDoctorName(String doctorName) {
        return appointmentRepository.findByDoctorNameContainingIgnoreCase(doctorName);
    }
    
    // Get appointments by patient name
    public List<Appointment> getAppointmentsByPatientName(String patientName) {
        return appointmentRepository.findByPatientNameContainingIgnoreCase(patientName);
    }
    
    // Get appointments by status
    public List<Appointment> getAppointmentsByStatus(String status) {
        return appointmentRepository.findByStatus(status);
    }
    
    // Get upcoming appointments
    public List<Appointment> getUpcomingAppointments() {
        return appointmentRepository.findUpcomingAppointments(LocalDateTime.now());
    }
    
    // Get past appointments
    public List<Appointment> getPastAppointments() {
        return appointmentRepository.findPastAppointments(LocalDateTime.now());
    }
    
    // Get appointments by date
    public List<Appointment> getAppointmentsByDate(LocalDateTime date) {
        return appointmentRepository.findByAppointmentDate(date);
    }
    
    // Get appointments by doctor and date
    public List<Appointment> getAppointmentsByDoctorAndDate(String doctorName, LocalDateTime date) {
        return appointmentRepository.findByDoctorAndDate(doctorName, date);
    }
    
    // Get appointments by date range
    public List<Appointment> getAppointmentsByDateRange(LocalDateTime startTime, LocalDateTime endTime) {
        return appointmentRepository.findByAppointmentTimeBetween(startTime, endTime);
    }
    
    // Delete appointment
    public void deleteAppointment(Long id) {
        appointmentRepository.deleteById(id);
    }
    
    // Update appointment status
    public Appointment updateAppointmentStatus(Long id, String status) {
        Optional<Appointment> appointmentOpt = appointmentRepository.findById(id);
        if (appointmentOpt.isPresent()) {
            Appointment appointment = appointmentOpt.get();
            appointment.setStatus(status);
            return appointmentRepository.save(appointment);
        }
        return null;
    }
    
    // Create new appointment
    public Appointment createAppointment(String doctorName, String patientFirstName, 
                                       String patientLastName, LocalDateTime appointmentTime, 
                                       String reason) {
        Appointment appointment = new Appointment();
        appointment.setDoctorName(doctorName);
        appointment.setPatientFirstName(patientFirstName);
        appointment.setPatientLastName(patientLastName);
        appointment.setPatientName(patientFirstName + " " + patientLastName);
        appointment.setAppointmentTime(appointmentTime);
        appointment.setStatus("Scheduled");
        appointment.setReason(reason);
        
        return appointmentRepository.save(appointment);
    }
    
    // Get appointments by date
    public List<Appointment> getAppointmentsByDate(LocalDate date) {
        return appointmentRepository.findByAppointmentDate(LocalDateTime.of(date, LocalTime.MIN));
    }
}

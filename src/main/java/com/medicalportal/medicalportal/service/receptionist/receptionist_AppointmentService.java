package com.medicalportal.medicalportal.service.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Appointment;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Doctor;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Patient;
import com.medicalportal.medicalportal.entity.receptionist.receptionist_Receptionist;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class receptionist_AppointmentService {
    
    @Autowired
    private receptionist_AppointmentRepository appointmentRepository;
    
    @Autowired
    private receptionist_ReceptionistService receptionistService;
    
    // Save or update appointment
    public receptionist_Appointment saveAppointment(receptionist_Appointment appointment) {
        return appointmentRepository.save(appointment);
    }
    
    // Get all appointments
    public List<receptionist_Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }
    
    // Get appointment by ID
    public Optional<receptionist_Appointment> getAppointmentById(Integer id) {
        return appointmentRepository.findById(id);
    }
    
    // Get appointments by doctor name (using doctor relationship)
    public List<receptionist_Appointment> getAppointmentsByDoctorName(String doctorName) {
        // This would need to be implemented with a custom query
        return appointmentRepository.findAll().stream()
            .filter(appointment -> appointment.getDoctors().stream()
                .anyMatch(doctor -> doctor.getSpecialization().contains(doctorName)))
            .toList();
    }
    
    // Get appointments by patient name (using patient relationship)
    public List<receptionist_Appointment> getAppointmentsByPatientName(String patientName) {
        // This would need to be implemented with a custom query
        return appointmentRepository.findAll().stream()
            .filter(appointment -> appointment.getPatients().stream()
                .anyMatch(patient -> (patient.getFirstName() + " " + patient.getLastName()).contains(patientName)))
            .toList();
    }
    
    // Get appointments by status
    public List<receptionist_Appointment> getAppointmentsByStatus(String status) {
        return appointmentRepository.findByStatus(status);
    }
    
    // Get upcoming appointments
    public List<receptionist_Appointment> getUpcomingAppointments() {
        return appointmentRepository.findUpcomingAppointments(LocalDateTime.now());
    }
    
    // Get past appointments
    public List<receptionist_Appointment> getPastAppointments() {
        return appointmentRepository.findPastAppointments(LocalDateTime.now());
    }
    
    // Get appointments by date
    public List<receptionist_Appointment> getAppointmentsByDate(LocalDateTime date) {
        return appointmentRepository.findByAppointmentDate(date);
    }
    
    // Get appointments by doctor and date (would need custom implementation)
    public List<receptionist_Appointment> getAppointmentsByDoctorAndDate(String doctorName, LocalDateTime date) {
        // This would need a custom query implementation
        return List.of();
    }
    
    // Get appointments by date range
    public List<receptionist_Appointment> getAppointmentsByDateRange(LocalDateTime startTime, LocalDateTime endTime) {
        return appointmentRepository.findByAppointmentTimeBetween(startTime, endTime);
    }
    
    // Delete appointment
    public void deleteAppointment(Integer id) {
        appointmentRepository.deleteById(id);
    }
    
    // Update appointment status
    public receptionist_Appointment updateAppointmentStatus(Integer id, String status) {
        Optional<receptionist_Appointment> appointmentOpt = appointmentRepository.findById(id);
        if (appointmentOpt.isPresent()) {
            receptionist_Appointment appointment = appointmentOpt.get();
            appointment.setStatus(status);
            return appointmentRepository.save(appointment);
        }
        return null;
    }
    
    // Create new appointment (simplified version for backward compatibility)
    public receptionist_Appointment createAppointment(String doctorName, String patientFirstName, 
                                       String patientLastName, LocalDateTime appointmentTime, 
                                       String reason) {
        receptionist_Appointment appointment = new receptionist_Appointment();
        appointment.setAppointmentTime(appointmentTime.toInstant(java.time.ZoneOffset.UTC));
        appointment.setStatus("Scheduled");
        
        return appointmentRepository.save(appointment);
    }
    
    // Get appointments by date
    public List<receptionist_Appointment> getAppointmentsByDate(LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(23, 59, 59);
        return appointmentRepository.findByAppointmentTimeBetween(startOfDay, endOfDay);
    }
    
    // Create appointment with proper relationships
    public receptionist_Appointment createAppointmentWithRelationships(receptionist_Patient patient, receptionist_Doctor doctor, 
                                                          LocalDateTime appointmentDateTime, 
                                                          Integer receptionistId) {
        receptionist_Appointment appointment = new receptionist_Appointment();
        appointment.setAppointmentTime(appointmentDateTime.toInstant(java.time.ZoneOffset.UTC));
        appointment.setStatus("Scheduled");
        
        // Set receptionist if found
        receptionist_Receptionist receptionist = receptionistService.getReceptionistById(receptionistId).orElse(null);
        if (receptionist != null) {
            appointment.setReceptionistEid(receptionist);
        }
        
        // Add doctor to the appointment
        appointment.getDoctors().add(doctor);
        
        // Add patient to the appointment
        appointment.getPatients().add(patient);
        
        // Save the appointment
        receptionist_Appointment savedAppointment = appointmentRepository.save(appointment);
        
        return savedAppointment;
    }
}

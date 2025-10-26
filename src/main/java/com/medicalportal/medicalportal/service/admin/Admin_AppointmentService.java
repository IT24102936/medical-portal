package com.medicalportal.medicalportal.service.admin;

import com.medicalportal.medicalportal.repository.admin.Admin_AppointmentRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class Admin_AppointmentService {
    private static final Logger logger = LoggerFactory.getLogger(Admin_AppointmentService.class);
    private final Admin_AppointmentRepository appointmentRepository;

    public Admin_AppointmentService(Admin_AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    public List<Map<String, Object>> getAllAppointments() {
        try {
            List<Map<String, Object>> appointments = appointmentRepository.findAllAppointmentsWithDetails();
            return processAppointmentData(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving all appointments: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load appointments", e);
        }
    }

    public List<Map<String, Object>> getAppointmentCountsBySpecialization() {
        try {
            return appointmentRepository.findAppointmentCountsBySpecialization();
        } catch (Exception e) {
            logger.error("Error retrieving appointment counts by specialization: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load appointment statistics", e);
        }
    }

    public List<Map<String, Object>> getAppointmentCountsByMonth() {
        try {
            return appointmentRepository.findAppointmentCountsByMonth();
        } catch (Exception e) {
            logger.error("Error retrieving appointment counts by month: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load appointment trends", e);
        }
    }

    public List<Map<String, Object>> getUpcomingAppointments() {
        try {
            List<Map<String, Object>> appointments = appointmentRepository.findUpcomingAppointments();
            return processAppointmentData(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving upcoming appointments: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load upcoming appointments", e);
        }
    }

    public List<Map<String, Object>> getTodaysAppointments() {
        try {
            List<Map<String, Object>> appointments = appointmentRepository.findTodaysAppointments();
            return processAppointmentData(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving today's appointments: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load today's appointments", e);
        }
    }

    public List<Map<String, Object>> getPastAppointments() {
        try {
            List<Map<String, Object>> appointments = appointmentRepository.findPastAppointments();
            return processAppointmentData(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving past appointments: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load past appointments", e);
        }
    }

    public List<Map<String, Object>> getCanceledAppointments() {
        try {
            List<Map<String, Object>> appointments = appointmentRepository.findCanceledAppointments();
            return processAppointmentData(appointments);
        } catch (Exception e) {
            logger.error("Error retrieving canceled appointments: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to load canceled appointments", e);
        }
    }

    @Transactional
    public void cancelAppointment(Integer appointmentId) {
        try {
            appointmentRepository.cancelAppointment(appointmentId);
            logger.info("Canceled appointment with ID: {}", appointmentId);
        } catch (Exception e) {
            logger.error("Error canceling appointment with ID {}: {}", appointmentId, e.getMessage(), e);
            throw new RuntimeException("Failed to cancel appointment", e);
        }
    }

    @Transactional
    public void deleteAppointment(Integer appointmentId) {
        try {
            // Delete appointment links first
            appointmentRepository.deleteAppointmentDoctorLink(appointmentId);
            appointmentRepository.deleteAppointmentPatientLink(appointmentId);
            // Then delete the appointment
            appointmentRepository.deleteAppointment(appointmentId);
            logger.info("Deleted appointment with ID: {}", appointmentId);
        } catch (Exception e) {
            logger.error("Error deleting appointment with ID {}: {}", appointmentId, e.getMessage(), e);
            throw new RuntimeException("Failed to delete appointment", e);
        }
    }

    @Transactional
    public void createAppointment(LocalDateTime appointmentTime, Integer doctorEid, Integer patientId, Integer receptionistEid) {
        try {
            // Get next appointment ID
            Integer nextAppointmentId = appointmentRepository.getNextAppointmentId();

            // Create appointment
            appointmentRepository.insertAppointment(nextAppointmentId, appointmentTime, "SCHEDULED", receptionistEid);

            // Link to doctor and patient
            appointmentRepository.linkAppointmentToDoctor(doctorEid, nextAppointmentId);
            appointmentRepository.linkAppointmentToPatient(patientId, nextAppointmentId);

            logger.info("Created new appointment with ID: {}", nextAppointmentId);
        } catch (Exception e) {
            logger.error("Error creating appointment: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to create appointment", e);
        }
    }

    private List<Map<String, Object>> processAppointmentData(List<Map<String, Object>> appointments) {
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

        List<Map<String, Object>> processed = new ArrayList<>(appointments.size());

        for (Map<String, Object> sourceRow : appointments) {
            Map<String, Object> row = new HashMap<>(sourceRow); // copy to mutable map

            Object appointmentTimeObj = row.get("appointment_time");
            if (appointmentTimeObj != null) {
                try {
                    LocalDateTime appointmentTime;
                    if (appointmentTimeObj instanceof java.sql.Timestamp) {
                        appointmentTime = ((java.sql.Timestamp) appointmentTimeObj).toLocalDateTime();
                    } else if (appointmentTimeObj instanceof LocalDateTime) {
                        appointmentTime = (LocalDateTime) appointmentTimeObj;
                    } else {
                        appointmentTime = LocalDateTime.parse(appointmentTimeObj.toString());
                    }

                    row.put("appointment_date", appointmentTime.format(dateFormatter));
                    row.put("appointment_time_formatted", appointmentTime.format(timeFormatter));
                } catch (Exception e) {
                    logger.warn("Error parsing appointment time: {}", e.getMessage());
                    row.put("appointment_date", "");
                    row.put("appointment_time_formatted", "");
                }
            } else {
                row.put("appointment_date", "");
                row.put("appointment_time_formatted", "");
            }

            // Ensure null values are handled
            row.put("doctor_name", row.get("doctor_name") != null ? row.get("doctor_name") : "N/A");
            row.put("doctor_specialization", row.get("doctor_specialization") != null ? row.get("doctor_specialization") : "General");
            row.put("patient_name", row.get("patient_name") != null ? row.get("patient_name") : "N/A");
            row.put("status", row.get("status") != null ? row.get("status") : "UNKNOWN");

            processed.add(row);
        }

        return processed;
    }
}

package com.medicalportal.medicalportal.controller.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Appointment;
import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.service.Patient.Patient_AppointmentService;
import com.medicalportal.medicalportal.service.Patient.Patient_PatientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/appointment")
@CrossOrigin(origins = "*")
public class AppointmentController {

    @Autowired
    private Patient_AppointmentService appointmentService;

    @Autowired
    private Patient_PatientService patientService;

    @PostMapping("/book")
    public ResponseEntity<?> bookAppointment(@RequestBody Map<String, Object> payload, HttpSession session) {
        try {
            System.out.println("=== APPOINTMENT BOOKING REQUEST RECEIVED ===");
            System.out.println("Payload: " + payload);

            // Get logged-in patient from session
            String userType = (String) session.getAttribute("userType");
            Patient_Patient patient = null;
            
            if ("patient".equals(userType)) {
                Integer userId = (Integer) session.getAttribute("userId");
                if (userId != null) {
                    patient = patientService.getPatientById(userId);
                }
            } else {
                patient = (Patient_Patient) session.getAttribute("loggedInPatient");
            }
            
            if (patient == null) {
                System.out.println("ERROR: No patient in session");
                return ResponseEntity.status(401).body(Map.of(
                        "success", false,
                        "message", "Please login to book an appointment"
                ));
            }

            System.out.println("Patient logged in: ID=" + patient.getId() + ", Name=" + patient.getFirstName() + " " + patient.getLastName());

            // Extract and validate parameters
            String appointmentDateStr = payload.get("appointmentDatetime") != null ? payload.get("appointmentDatetime").toString().trim() : null;
            Object doctorIdObj = payload.get("doctorId");
            String selectedTime = payload.get("selectedTime") != null ? payload.get("selectedTime").toString().trim() : null;

            System.out.println("Extracted data:");
            System.out.println("  - appointmentDate: '" + appointmentDateStr + "'");
            System.out.println("  - doctorId: " + doctorIdObj);
            System.out.println("  - time: '" + selectedTime + "'");

            // Basic validation
            if (appointmentDateStr == null || appointmentDateStr.isEmpty() || appointmentDateStr.equals("--")) {
                System.out.println("ERROR: Appointment date is missing or invalid");
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Appointment date is required and must be in format yyyy-MM-dd"
                ));
            }

            // Try parsing appointmentDate as LocalDate (accept yyyy-MM-dd, or allow yyyy/MM/dd as fallback)
            LocalDate appointmentDate;
            try {
                appointmentDate = LocalDate.parse(appointmentDateStr); // ISO yyyy-MM-dd
            } catch (DateTimeParseException ex1) {
                // try replacing common separators
                String alt = appointmentDateStr.replace("/", "-");
                try {
                    appointmentDate = LocalDate.parse(alt);
                } catch (DateTimeParseException ex2) {
                    System.out.println("ERROR: Invalid date format. Expected yyyy-MM-dd, got: " + appointmentDateStr);
                    return ResponseEntity.badRequest().body(Map.of(
                            "success", false,
                            "message", "Invalid date format. Expected format: yyyy-MM-dd (e.g., 2025-09-12). Received: " + appointmentDateStr
                    ));
                }
            }

            if (doctorIdObj == null) {
                System.out.println("ERROR: Doctor ID is missing");
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Doctor selection is required"
                ));
            }

            if (selectedTime == null || selectedTime.trim().isEmpty()) {
                System.out.println("ERROR: Time is missing");
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Time selection is required"
                ));
            }

            Integer doctorId = null;
            try {
                doctorId = doctorIdObj instanceof Integer ? (Integer) doctorIdObj : Integer.parseInt(doctorIdObj.toString());
            } catch (NumberFormatException nfe) {
                System.out.println("ERROR: Doctor ID is invalid: " + doctorIdObj);
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Doctor ID is invalid"
                ));
            }

            System.out.println("Parsed doctor ID: " + doctorId);

            // Parse date + time into LocalDateTime
            LocalDateTime appointmentDateTime = parseAppointmentDateTime(appointmentDate, selectedTime);

            if (appointmentDateTime == null) {
                System.out.println("ERROR: Failed to parse date/time");
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Invalid date or time format. Date format should be yyyy-MM-dd and time like '9:00 AM' or '09:00'."
                ));
            }

            System.out.println("Parsed appointment datetime: " + appointmentDateTime);

            // Check if appointment is in the past
            if (appointmentDateTime.isBefore(LocalDateTime.now())) {
                System.out.println("ERROR: Appointment is in the past");
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Cannot book appointments in the past"
                ));
            }

            System.out.println("Calling appointmentService.createAppointment...");

            // Create appointment
            Patient_Appointment appointment = appointmentService.createAppointment(
                    patient.getId(),
                    appointmentDateTime,
                    "Scheduled",
                    doctorId
            );

            System.out.println("SUCCESS: Appointment created with ID: " + appointment.getId());
            System.out.println("=== APPOINTMENT BOOKING COMPLETED SUCCESSFULLY ===");

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "message", "Appointment booked successfully",
                    "appointmentId", appointment.getId(),
                    "appointmentDate", appointment.getAppointmentDatetime().toString()
            ));

        } catch (RuntimeException e) {
            System.err.println("RUNTIME ERROR: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", e.getMessage()
            ));
        } catch (Exception e) {
            System.err.println("UNEXPECTED ERROR: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of(
                    "success", false,
                    "message", "An unexpected error occurred: " + e.getMessage()
            ));
        }
    }

    /**
     * Build LocalDateTime from LocalDate and a time string.
     * Accepts:
     *  - "9:00 AM", "9:00PM", "09:00 AM"
     *  - "09:00" (24-hour)
     *  - "9:00AM" (no space)
     */
    private LocalDateTime parseAppointmentDateTime(LocalDate date, String timeStr) {
        try {
            if (date == null || timeStr == null) return null;
            String t = timeStr.trim();

            // If contains AM/PM (case-insensitive)
            if (t.toLowerCase().contains("am") || t.toLowerCase().contains("pm")) {
                // Normalize: ensure there is a space before AM/PM, e.g. "9:00AM" -> "9:00 AM"
                t = t.replaceAll("(?i)(am|pm)$", " $1").trim();

                // split
                String[] parts = t.split(" ");
                if (parts.length < 2) {
                    System.err.println("Invalid AM/PM time format: " + timeStr);
                    return null;
                }
                String hm = parts[0];
                String ampm = parts[1];

                String[] hourMin = hm.split(":");
                if (hourMin.length != 2) {
                    System.err.println("Invalid hour:minute: " + hm);
                    return null;
                }

                int hour = Integer.parseInt(hourMin[0]);
                int minute = Integer.parseInt(hourMin[1]);

                if (ampm.equalsIgnoreCase("PM") && hour != 12) hour += 12;
                else if (ampm.equalsIgnoreCase("AM") && hour == 12) hour = 0;

                return LocalDateTime.of(date.getYear(), date.getMonth(), date.getDayOfMonth(), hour, minute);
            } else {
                // Expect format HH:mm (24-hour) or H:mm
                String[] hourMin = t.split(":");
                if (hourMin.length != 2) {
                    System.err.println("Invalid 24-hour time format: " + timeStr);
                    return null;
                }
                int hour = Integer.parseInt(hourMin[0]);
                int minute = Integer.parseInt(hourMin[1]);
                return LocalDateTime.of(date.getYear(), date.getMonth(), date.getDayOfMonth(), hour, minute);
            }
        } catch (NumberFormatException nfe) {
            System.err.println("Number format error parsing time: " + timeStr + " - " + nfe.getMessage());
            return null;
        } catch (Exception e) {
            System.err.println("ERROR parsing date/time: date=" + date + " timeStr=" + timeStr + " - " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all appointments for the logged-in patient
     */
    @GetMapping("/my-appointments")
    public ResponseEntity<?> getMyAppointments(HttpSession session) {
        try {
            Patient_Patient patient = (Patient_Patient) session.getAttribute("loggedInPatient");
            if (patient == null) {
                return ResponseEntity.status(401).body(Map.of(
                        "success", false,
                        "message", "Please login to view appointments"
                ));
            }

            List<Patient_Appointment> appointments = appointmentService.getAppointmentsByPatientId(patient.getId());

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "appointments", appointments,
                    "count", appointments.size()
            ));
        } catch (Exception e) {
            System.err.println("ERROR getting appointments: " + e.getMessage());
            return ResponseEntity.status(500).body(Map.of(
                    "success", false,
                    "message", "Error retrieving appointments: " + e.getMessage()
            ));
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getAppointment(@PathVariable Integer id, HttpSession session) {
        try {
            Patient_Patient patient = (Patient_Patient) session.getAttribute("loggedInPatient");
            if (patient == null) {
                return ResponseEntity.status(401).body(Map.of(
                        "success", false,
                        "message", "Please login to view appointment"
                ));
            }

            Patient_Appointment appointment = appointmentService.getAppointmentById(id);

            // Verify the appointment belongs to the logged-in patient
            if (!appointment.getPatient().getId().equals(patient.getId())) {
                return ResponseEntity.status(403).body(Map.of(
                        "success", false,
                        "message", "You don't have permission to view this appointment"
                ));
            }

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "appointment", appointment
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(Map.of(
                    "success", false,
                    "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                    "success", false,
                    "message", "Error retrieving appointment: " + e.getMessage()
            ));
        }
    }

    @PostMapping("/{id}/cancel")
    public ResponseEntity<?> cancelAppointment(@PathVariable Integer id, HttpSession session) {
        try {
            Patient_Patient patient = (Patient_Patient) session.getAttribute("loggedInPatient");
            if (patient == null) {
                return ResponseEntity.status(401).body(Map.of(
                        "success", false,
                        "message", "Please login to cancel appointment"
                ));
            }

            Patient_Appointment appointment = appointmentService.getAppointmentById(id);

            // Verify the appointment belongs to the logged-in patient
            if (!appointment.getPatient().getId().equals(patient.getId())) {
                return ResponseEntity.status(403).body(Map.of(
                        "success", false,
                        "message", "You don't have permission to cancel this appointment"
                ));
            }

            // Check if already cancelled
            if ("Cancelled".equalsIgnoreCase(appointment.getStatus())) {
                return ResponseEntity.badRequest().body(Map.of(
                        "success", false,
                        "message", "Appointment is already cancelled"
                ));
            }

            // Cancel the appointment
            Patient_Appointment cancelledAppointment = appointmentService.cancelAppointment(id);

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "message", "Appointment cancelled successfully",
                    "appointment", cancelledAppointment
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(Map.of(
                    "success", false,
                    "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of(
                    "success", false,
                    "message", "Error cancelling appointment: " + e.getMessage()
            ));
        }
    }
}

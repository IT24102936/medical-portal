package com.medicalportal.medicalportal.service.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Appointment;
import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.repository.Patient.Patient_AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class Patient_AppointmentService {

    @Autowired
    private Patient_AppointmentRepository appointmentRepository;

    @Autowired
    private Patient_PatientService patientService;

    public Patient_Appointment createAppointment(Integer patientId, LocalDateTime appointmentDatetime,
                                         String status, Integer doctorEid) {
        try {
            System.out.println("DEBUG: createAppointment called -> patientId=" + patientId
                    + " doctorEid=" + doctorEid + " datetime=" + appointmentDatetime);

            Patient_Patient patient = patientService.getPatientById(patientId);

            if (patient == null) {
                throw new RuntimeException("Patient not found with ID: " + patientId);
            }

            if (doctorEid == null || doctorEid <= 0) {
                throw new RuntimeException("Invalid doctor ID: " + doctorEid);
            }

            // Check if same patient already has appointment at same datetime
            List<Patient_Appointment> patientConflicts = appointmentRepository.findByPatientIdAndDateTime(patientId, appointmentDatetime);
            if (patientConflicts != null && !patientConflicts.isEmpty()) {
                throw new RuntimeException("You already have an appointment at this time");
            }

            // Check doctor conflicts
            List<Patient_Appointment> doctorConflicts = appointmentRepository.findByDoctorIdAndDateTime(doctorEid, appointmentDatetime);
            if (doctorConflicts != null && !doctorConflicts.isEmpty()) {
                throw new RuntimeException("Selected doctor is not available at this time");
            }

            Patient_Appointment appointment = new Patient_Appointment();
            appointment.setPatient(patient);
            appointment.setAppointmentDatetime(appointmentDatetime);
            appointment.setStatus(status != null ? status : "Scheduled");
            appointment.setReceptionistEid(null); // Set to null until receptionist assigns it
            appointment.setDoctorEid(doctorEid);

            // save and flush to force DB write immediately
            Patient_Appointment saved = appointmentRepository.saveAndFlush(appointment);
            System.out.println("DEBUG: Appointment saved with ID: " + saved.getId());

            return saved;
        } catch (RuntimeException re) {
            System.err.println("ERROR (createAppointment): " + re.getMessage());
            throw re;
        } catch (Exception e) {
            System.err.println("ERROR (createAppointment) unexpected: " + e.getMessage());
            throw new RuntimeException("Failed to create appointment: " + e.getMessage(), e);
        }
    }

    public List<Patient_Appointment> getAppointmentsByPatientId(Integer patientId) {
        return appointmentRepository.findByPatientId(patientId);
    }

    public Patient_Appointment getAppointmentById(Integer id) {
        return appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found with ID: " + id));
    }

    public boolean deleteAppointment(Integer id) {
        if (appointmentRepository.existsById(id)) {
            appointmentRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Patient_Appointment cancelAppointment(Integer appointmentId) {
        Patient_Appointment appointment = appointmentRepository.findById(appointmentId)
                .orElseThrow(() -> new RuntimeException("Appointment not found with ID: " + appointmentId));
        
        appointment.setStatus("Cancelled");
        return appointmentRepository.save(appointment);
    }
}

package com.medicalportal.medicalportal.service;


import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.entity.Appointment;
import com.medicalportal.medicalportal.entity.Prescription;
import com.medicalportal.medicalportal.entity.PrescriptionDetails;
import com.medicalportal.medicalportal.entity.Patient;
import com.medicalportal.medicalportal.repository.DoctorRepository;
import com.medicalportal.medicalportal.repository.AppointmentRepository;
import com.medicalportal.medicalportal.repository.PrescriptionRepository;
import com.medicalportal.medicalportal.repository.PrescriptionDetailsRepository;
import com.medicalportal.medicalportal.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorServiceImpl implements DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private PrescriptionRepository prescriptionRepository;

    @Autowired
    private PrescriptionDetailsRepository prescriptionDetailsRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Override
    public Doctor saveDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    @Override
    @Transactional
    public Doctor registerDoctor(Doctor doctor) {
        try {
            System.out.println("DEBUG: Starting registration for doctor: " + doctor.getUsername());
            Doctor savedDoctor = doctorRepository.save(doctor);
            System.out.println("DEBUG: Saved to employee table with ID: " + savedDoctor.getId());
            return savedDoctor;
        } catch (Exception e) {
            System.out.println("DEBUG: Error in registerDoctor: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public Optional<Doctor> getDoctorByUsername(String username) {
        return doctorRepository.findByUsername(username);
    }

    @Override
    public Optional<Doctor> getDoctorById(Long id) {
        return doctorRepository.findById(id);
    }

    @Override
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    @Override
    public Doctor updateDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    @Override
    public void deleteDoctor(Long id) {
        doctorRepository.deleteById(id);
    }

    @Override
    public List<Appointment> getDoctorAppointments(Long doctorId) {
        return appointmentRepository.findByDoctorId(doctorId);
    }

    @Override
    public List<Appointment> getDoctorAppointmentsByDate(Long doctorId, String date) {
        LocalDate localDate = LocalDate.parse(date);
        return appointmentRepository.findByDoctorIdAndAppointmentDate(doctorId, localDate);
    }

    @Override
    public List<Appointment> getDoctorAppointmentsByWeek(Long doctorId, String startDate) {
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = start.plusDays(6);
        return appointmentRepository.findByDoctorIdAndAppointmentDateBetween(doctorId, start, end);
    }

    @Override
    public List<Appointment> getUpcomingAppointments(Long doctorId) {
        return getUpcomingAppointments(doctorId, 7);
    }

    @Override
    public List<Appointment> getUpcomingAppointments(Long doctorId, int days) {
        LocalDate today = LocalDate.now();
        LocalDate endDate = today.plusDays(days);
        return appointmentRepository.findByDoctorIdAndAppointmentDateBetween(doctorId, today.plusDays(1), endDate);
    }

    @Override
    public List<Prescription> getDoctorPrescriptions(Long doctorId) {
        if (doctorId == null) {
            throw new IllegalArgumentException("Doctor ID cannot be null");
        }

        List<Prescription> prescriptions = prescriptionRepository.findByDoctorId(doctorId);

        // Populate transient fields for easier use in views
        prescriptions.forEach(prescription -> {
            if (prescription.getPrescriptionDetails() != null) {
                prescription.setDescription(prescription.getPrescriptionDetails().getDescription());
            }
            if (prescription.getPatient() != null) {
                prescription.setPatientName(prescription.getPatient().getFirstName() + " " + prescription.getPatient().getLastName());
            }
        });

        return prescriptions;
    }

    @Override
    public Optional<Prescription> getPrescriptionById(Long prescriptionId, Long doctorId) {
        if (prescriptionId == null || doctorId == null) {
            throw new IllegalArgumentException("Prescription ID and Doctor ID cannot be null");
        }

        Optional<Prescription> prescriptionOpt = prescriptionRepository.findByPrescriptionIdAndDoctorId(prescriptionId, doctorId);

        // Populate transient fields if prescription exists
        prescriptionOpt.ifPresent(prescription -> {
            if (prescription.getPrescriptionDetails() != null) {
                prescription.setDescription(prescription.getPrescriptionDetails().getDescription());
            }
            if (prescription.getPatient() != null) {
                prescription.setPatientName(prescription.getPatient().getFirstName() + " " + prescription.getPatient().getLastName());
            }
        });

        return prescriptionOpt;
    }

    @Override
    public boolean verifyPatientExists(Long patientId) {
        if (patientId == null) {
            return false;
        }
        Optional<Patient> patient = patientRepository.findById(patientId.intValue());
        return patient.isPresent();
    }


    @Override
    @Transactional
    public Prescription createPrescription(Prescription prescription) {
        // Validate prescription data
        if (prescription == null) {
            throw new IllegalArgumentException("Prescription cannot be null");
        }

        // Basic validation
        if (prescription.getDoctorId() == null) {
            throw new IllegalArgumentException("Doctor ID is required");
        }

        if (prescription.getPatientId() == null) {
            throw new IllegalArgumentException("Patient ID is required");
        }

        // Verify patient exists
        Optional<Patient> patientOpt = patientRepository.findById(prescription.getPatientId().intValue());
        if (patientOpt.isEmpty()) {
            throw new IllegalArgumentException("Patient with ID " + prescription.getPatientId() + " not found");
        }

        //mmm Verify doctor exists
        Optional<Doctor> doctorOpt = doctorRepository.findById(prescription.getDoctorId());
        if (doctorOpt.isEmpty()) {
            throw new IllegalArgumentException("Doctor with ID " + prescription.getDoctorId() + " not found");
        }



        // First, create the prescription details (this goes into 'prescription' table)
        PrescriptionDetails details = new PrescriptionDetails();
        details.setPatient(patientOpt.get());  // Set Patient object
        details.setDescription(prescription.getDescription());
        PrescriptionDetails savedDetails = prescriptionDetailsRepository.save(details);

        // Now create the prescription relationship (this goes into 'doctor_issues_prescription' table)
        Prescription newPrescription = new Prescription();
        newPrescription.setDoctorId(prescription.getDoctorId());
        newPrescription.setPatientId(prescription.getPatientId());
        newPrescription.setPrescriptionId(savedDetails.getId()); // Use the ID from saved details
        newPrescription.setIssueDate(prescription.getIssueDate() != null ? prescription.getIssueDate() : LocalDate.now());

        // Set the relationships
        newPrescription.setDoctor(doctorOpt.get());
        newPrescription.setPatient(patientOpt.get());
        newPrescription.setPrescriptionDetails(savedDetails);


        // Set issue date if not set
        if (prescription.getIssueDate() == null) {
            prescription.setIssueDate(LocalDate.now());
        }


        // Save the prescription relationship - FIXED: Use newPrescription instead of prescription
        return prescriptionRepository.save(newPrescription);

    }
}
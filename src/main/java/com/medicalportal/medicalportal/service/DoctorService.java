package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.entity.Appointment;
import com.medicalportal.medicalportal.entity.Prescription;
import java.util.List;
import java.util.Optional;


public interface DoctorService {
    Doctor saveDoctor(Doctor doctor);
    Doctor registerDoctor(Doctor doctor);
    Optional<Doctor> getDoctorById(Long id);
    Optional<Doctor> getDoctorByUsername(String username);
    List<Doctor> getAllDoctors();
    Doctor updateDoctor(Doctor doctor);

    void deleteDoctor(Long id);
    List<Appointment> getDoctorAppointments(Long doctorId);
    List<Appointment> getDoctorAppointmentsByDate(Long doctorId, String date);
    List<Appointment> getDoctorAppointmentsByWeek(Long doctorId, String startDate);
    List<Appointment> getUpcomingAppointments(Long doctorId);
    List<Appointment> getUpcomingAppointments(Long doctorId, int days);


    // Prescription methods - FIXED: Use Prescription instead of PrescriptionDetails
    List<Prescription> getDoctorPrescriptions(Long doctorId);
    Optional<Prescription> getPrescriptionById(Long prescriptionId, Long doctorId);
    Prescription createPrescription(Prescription prescription);
    boolean verifyPatientExists(Long patientId);

}



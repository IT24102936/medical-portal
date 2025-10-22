package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient;
import com.medicalportal.medicalportal.entity.Patient_entites.PatientPhone;
import com.medicalportal.medicalportal.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.regex.Pattern;

@Service
@Transactional
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;


    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s]+$");

    public Patient createPatient(Patient patient) {
        // Validate names
        if (!isValidName(patient.getFirstName())) {
            throw new RuntimeException("First name must contain only letters and spaces");
        }

        if (!isValidName(patient.getLastName())) {
            throw new RuntimeException("Last name must contain only letters and spaces");
        }

        if (patientRepository.existsByEmail(patient.getEmail())) {
            throw new RuntimeException("Email already exists: " + patient.getEmail());
        }

        // Validate phone numbers
        validatePhoneNumbers(patient.getPatientPhones());

        // Save patient first to get the generated ID
        Patient savedPatient = patientRepository.save(patient);

        // Set the patient reference for each phone number
        if (patient.getPatientPhones() != null && !patient.getPatientPhones().isEmpty()) {
            for (PatientPhone phone : patient.getPatientPhones()) {
                phone.setPatient(savedPatient);
            }
            // Save again to persist the phones with the correct patient ID
            savedPatient = patientRepository.save(savedPatient);
        }

        return savedPatient;
    }

    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public Patient getPatientById(Integer id) {
        return patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + id));
    }

    public Patient getPatientByIdWithPhones(Integer id) {
        return patientRepository.findByIdWithPhones(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + id));
    }

    public Patient updatePatient(Patient patient) {
        // Validate names
        if (!isValidName(patient.getFirstName())) {
            throw new RuntimeException("First name must contain only letters and spaces");
        }

        if (!isValidName(patient.getLastName())) {
            throw new RuntimeException("Last name must contain only letters and spaces");
        }

        Patient existing = getPatientById(patient.getId());

        if (!existing.getEmail().equals(patient.getEmail())) {
            if (patientRepository.existsByEmailAndPatient_idNot(patient.getEmail(), patient.getId())) {
                throw new RuntimeException("Email already exists: " + patient.getEmail());
            }
            existing.setEmail(patient.getEmail());
        }

        existing.setFirstName(patient.getFirstName());
        existing.setLastName(patient.getLastName());
        existing.setDob(patient.getDob());
        existing.setNationalId(patient.getNationalId());
        existing.setGender(patient.getGender());
        existing.setAddress(patient.getAddress());

        if (patient.getPassword() != null && !patient.getPassword().trim().isEmpty()) {
            existing.setPassword(patient.getPassword());
        }

        // Validate phone numbers before updating
        if (patient.getPatientPhones() != null) {
            validatePhoneNumbers(patient.getPatientPhones());
        }

        // Clear old phones and add new ones
        existing.getPatientPhones().clear();

        if (patient.getPatientPhones() != null) {
            for (PatientPhone inputPhone : patient.getPatientPhones()) {
                String number = inputPhone.getPhoneNumber();
                if (number != null && !number.trim().isEmpty()) {
                    PatientPhone newPhone = new PatientPhone();
                    newPhone.setPhoneNumber(number.trim());
                    newPhone.setPatient(existing);
                    existing.getPatientPhones().add(newPhone);
                }
            }
        }

        return patientRepository.save(existing);
    }

    public boolean deletePatient(Integer id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Patient authenticate(String email, String password) {
        Patient patient = patientRepository.findByEmail(email);
        if (patient != null && patient.getPassword().equals(password)) {
            return patient;
        }
        return null;
    }

    private void validatePhoneNumbers(Set<PatientPhone> phones) {
        if (phones != null) {
            for (PatientPhone phone : phones) {
                if (phone.getPhoneNumber() != null && !isValidPhoneNumber(phone.getPhoneNumber())) {
                    throw new RuntimeException("Phone number must be exactly 10 digits: " + phone.getPhoneNumber());
                }
            }
        }
    }

    private boolean isValidPhoneNumber(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        // Remove any spaces or special characters
        String cleanPhone = phone.replaceAll("[^\\d]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }

    private boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return NAME_PATTERN.matcher(name.trim()).matches();
    }
}
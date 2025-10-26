package com.medicalportal.medicalportal.service.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.entity.Patient_entites.Patient_PatientPhone;
import com.medicalportal.medicalportal.repository.Patient.Patient_PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

@Service
@Transactional
public class Patient_PatientService {

    @Autowired
    private Patient_PatientRepository patientRepository;


    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s]+$");

    public Patient_Patient createPatient(Patient_Patient patient) {
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
        Patient_Patient savedPatient = patientRepository.save(patient);
        
        // Hash password after save if provided
        if (savedPatient.getPassword() != null && !com.medicalportal.medicalportal.util.PasswordUtil.isHashed(savedPatient.getPassword())) {
            savedPatient.setPassword(com.medicalportal.medicalportal.util.PasswordUtil.hash(savedPatient.getPassword()));
            savedPatient = patientRepository.save(savedPatient);
        }

        // Set the patient reference for each phone number
        if (patient.getPatientPhones() != null && !patient.getPatientPhones().isEmpty()) {
            for (Patient_PatientPhone phone : patient.getPatientPhones()) {
                phone.setPatient(savedPatient);
            }
            // Save again to persist the phones with the correct patient ID
            savedPatient = patientRepository.save(savedPatient);
        }

        return savedPatient;
    }

    public List<Patient_Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public Patient_Patient getPatientById(Integer id) {
        return patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + id));
    }

    public Patient_Patient getPatientByIdWithPhones(Integer id) {
        return patientRepository.findByIdWithPhones(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with ID: " + id));
    }

    public Patient_Patient updatePatient(Patient_Patient patient) {
        // Validate names
        if (!isValidName(patient.getFirstName())) {
            throw new RuntimeException("First name must contain only letters and spaces");
        }

        if (!isValidName(patient.getLastName())) {
            throw new RuntimeException("Last name must contain only letters and spaces");
        }

        Patient_Patient existing = getPatientById(patient.getId());

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
            existing.setPassword(com.medicalportal.medicalportal.util.PasswordUtil.hash(patient.getPassword()));
        }

        // Validate phone numbers before updating
        if (patient.getPatientPhones() != null) {
            validatePhoneNumbers(patient.getPatientPhones());
        }

        // Clear old phones and add new ones
        existing.getPatientPhones().clear();

        if (patient.getPatientPhones() != null) {
            for (Patient_PatientPhone inputPhone : patient.getPatientPhones()) {
                String number = inputPhone.getPhoneNumber();
                if (number != null && !number.trim().isEmpty()) {
                    Patient_PatientPhone newPhone = new Patient_PatientPhone();
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

    public Patient_Patient authenticate(String email, String password) {
        Patient_Patient patient = patientRepository.findByEmail(email);
        if (patient != null && com.medicalportal.medicalportal.util.PasswordUtil.matches(password, patient.getPassword())) {
            // Migrate legacy plaintext to hashed on successful login
            if (!com.medicalportal.medicalportal.util.PasswordUtil.isHashed(patient.getPassword())) {
                patient.setPassword(com.medicalportal.medicalportal.util.PasswordUtil.hash(password));
                patientRepository.save(patient);
            }
            return patient;
        }
        return null;
    }

    private void validatePhoneNumbers(Set<Patient_PatientPhone> phones) {
        if (phones != null) {
            for (Patient_PatientPhone phone : phones) {
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

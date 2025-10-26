package com.medicalportal.medicalportal.service.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Doctor;
import com.medicalportal.medicalportal.repository.Patient.Patient_DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class Patient_DoctorService {

    @Autowired
    private Patient_DoctorRepository doctorRepository;

    public List<Patient_Doctor> getAllDoctors() {
        return doctorRepository.findAllWithEmployee();
    }

    public Optional<Patient_Doctor> getDoctorById(Integer eid) {
        return doctorRepository.findById(eid);
    }

    public Patient_Doctor saveDoctor(Patient_Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    public void deleteDoctor(Integer eid) {
        doctorRepository.deleteById(eid);
    }
}

package com.medicalportal.medicalportal.controller.Patient;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient_Patient;
import com.medicalportal.medicalportal.service.Patient.Patient_PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/patient")
@CrossOrigin
public class PatientController {

    @Autowired
    private Patient_PatientService patientService;

    @PostMapping
    public Patient_Patient createPatient(@RequestBody Patient_Patient patient) {
        return patientService.createPatient(patient);
    }

    @GetMapping
    public List<Patient_Patient> getAllPatients() {
        return patientService.getAllPatients();
    }

    @PutMapping
    public Patient_Patient updatePatient(@RequestBody Patient_Patient patient) {
        return patientService.updatePatient(patient);
    }

    @DeleteMapping("/{id}")
    public boolean deletePatient(@PathVariable Integer id) {
        return patientService.deletePatient(id);
    }
}
package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Patient_entites.Patient;
import com.medicalportal.medicalportal.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/patient")
@CrossOrigin
public class PatientController {

    @Autowired
    private PatientService patientService;

    @PostMapping
    public Patient createPatient(@RequestBody Patient patient) {
        return patientService.createPatient(patient);
    }

    @GetMapping
    public List<Patient> getAllPatients() {
        return patientService.getAllPatients();
    }

    @PutMapping
    public Patient updatePatient(@RequestBody Patient patient) {
        return patientService.updatePatient(patient);
    }

    @DeleteMapping("/{id}")
    public boolean deletePatient(@PathVariable Integer id) {
        return patientService.deletePatient(id);
    }
}
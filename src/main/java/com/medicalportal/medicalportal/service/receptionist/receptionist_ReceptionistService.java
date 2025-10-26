package com.medicalportal.medicalportal.service.receptionist;

import com.medicalportal.medicalportal.entity.receptionist.receptionist_Receptionist;
import com.medicalportal.medicalportal.repository.receptionist.receptionist_ReceptionistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class receptionist_ReceptionistService {
    
    @Autowired
    private receptionist_ReceptionistRepository receptionistRepository;
    
    // Get all receptionists
    public List<receptionist_Receptionist> getAllReceptionists() {
        return receptionistRepository.findAll();
    }
    
    // Get receptionist by ID
    public Optional<receptionist_Receptionist> getReceptionistById(Integer id) {
        return receptionistRepository.findById(id);
    }
    
    // Save or update receptionist
    public receptionist_Receptionist saveReceptionist(receptionist_Receptionist receptionist) {
        return receptionistRepository.save(receptionist);
    }
    
    // Delete receptionist
    public void deleteReceptionist(Integer id) {
        receptionistRepository.deleteById(id);
    }
}

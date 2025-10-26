package com.medicalportal.medicalportal.service.LabTech_Pharmacist;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Medicine;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_MedicineInventory;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Pharmacist;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Prescription;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_MedicineInventoryRepository;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_MedicineRepository;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_PharmacistRepository;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_PrescriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class Lab_Phar_PharmacistServices {
    @Autowired
    private Lab_Phar_PrescriptionRepository prescriptionRepository;

    @Autowired
    private Lab_Phar_MedicineInventoryRepository medicineInventoryRepository;

    @Autowired
    private Lab_Phar_MedicineRepository medicineRepository;

    @Autowired
    private Lab_Phar_PharmacistRepository pharmacistRepository;

    // Get all prescriptions
    public List<Lab_Phar_Prescription> getAllPrescriptions() {
        return prescriptionRepository.findAll();
    }

    // Add new prescription
    public Lab_Phar_Prescription addPrescription(Lab_Phar_Prescription prescription) {
        // Insert prescription with only description (simplified table structure)
        prescriptionRepository.insertPrescription(prescription.getDescription());
        
        // Get the last inserted ID and return the created prescription
        Integer newPrescriptionId = prescriptionRepository.getLastInsertedId();
        Optional<Lab_Phar_Prescription> createdPrescription = prescriptionRepository.findById(newPrescriptionId);
        
        return createdPrescription.orElseThrow(() -> new RuntimeException("Failed to create prescription"));
    }

    // Get all medicine inventory
    public List<Lab_Phar_MedicineInventory> getAllMedicineInventory() {
        return medicineInventoryRepository.findAll();
    }

    // Get low stock items
    public List<Lab_Phar_MedicineInventory> getLowStockItems() {
        return medicineInventoryRepository.findLowStockItems();
    }

    // Update inventory count
    public void updateInventoryCount(Integer inventoryId, Integer newCount) {
        // Update inventory count using custom query
        medicineInventoryRepository.updateInventoryCount(inventoryId, newCount);
    }

    // Add new medicine to inventory
    public Lab_Phar_MedicineInventory addMedicineToInventory(Lab_Phar_MedicineInventory inventory) {
        // Insert new medicine inventory using custom query with available fields
        medicineInventoryRepository.insertMedicineInventory(
            inventory.getCount(),
            inventory.getPharmacistEid(),
            inventory.getDescription()
        );
        
        // Get the last inserted ID and return the created inventory
        Integer newInventoryId = medicineInventoryRepository.getLastInsertedId();
        Optional<Lab_Phar_MedicineInventory> createdInventory = medicineInventoryRepository.findById(newInventoryId);
        
        return createdInventory.orElseThrow(() -> new RuntimeException("Failed to create medicine inventory"));
    }

    // Get all medicines
    public List<Lab_Phar_Medicine> getAllMedicines() {
        return medicineRepository.findAll();
    }

    // Get medicine by code
    public Lab_Phar_Medicine getMedicineByCode(String medicineCode) {
        return medicineRepository.findById(medicineCode).orElse(null);
    }

    // Get pharmacist by ID
    public Optional<Lab_Phar_Pharmacist> getPharmacistById(Integer pharmacistId) {
        return pharmacistRepository.findById(pharmacistId);
    }

    // Restock inventory - add stock to existing inventory
    public void restockInventory(Integer inventoryId, Integer additionalStock) {
        Optional<Lab_Phar_MedicineInventory> inventoryOpt = medicineInventoryRepository.findById(inventoryId);
        if (inventoryOpt.isPresent()) {
            Lab_Phar_MedicineInventory inventory = inventoryOpt.get();
            Integer newCount = inventory.getCount() + additionalStock;
            // Update inventory count using custom query
            medicineInventoryRepository.updateInventoryCount(inventoryId, newCount);
        }
    }

    // Reduce stock - for dispensing or other reasons
    public void reduceStock(Integer inventoryId, Integer reductionAmount, String reason) {
        // Validate input parameters
        if (reductionAmount == null || reductionAmount < 0) {
            throw new IllegalArgumentException("Reduction amount must be a non-negative number");
        }
        
        Optional<Lab_Phar_MedicineInventory> inventoryOpt = medicineInventoryRepository.findById(inventoryId);
        if (inventoryOpt.isPresent()) {
            Lab_Phar_MedicineInventory inventory = inventoryOpt.get();
            
            // Validate that reduction amount doesn't exceed available stock
            if (reductionAmount > inventory.getCount()) {
                throw new IllegalArgumentException("Cannot reduce stock by " + reductionAmount + 
                    ". Only " + inventory.getCount() + " units available.");
            }
            
            int newCount = Math.max(0, inventory.getCount() - reductionAmount);
            
            // Update description to include reduction reason
            String updatedDescription = inventory.getDescription() != null ? inventory.getDescription() : "";
            if (reason != null && !reason.isEmpty()) {
                updatedDescription = updatedDescription + " [" + reason + ": -" + reductionAmount + "]";
            }
            
            // Update inventory using custom query
            medicineInventoryRepository.updateMedicineInventory(inventoryId, newCount, updatedDescription);
        } else {
            throw new IllegalArgumentException("Inventory item with ID " + inventoryId + " not found");
        }
    }

    // Get statistics for dashboard
    public long getTotalPrescriptionsCount() {
        return prescriptionRepository.count();
    }

    public long getTotalInventoryItems() {
        return medicineInventoryRepository.count();
    }

    public long getLowStockItemsCount() {
        return medicineInventoryRepository.countLowStockItems();
    }

    // Get prescription by ID
    public Lab_Phar_Prescription getPrescriptionById(Integer id) {
        return prescriptionRepository.findById(id).orElse(null);
    }

    // Delete prescription by ID
    public boolean deletePrescription(Integer id) {
        try {
            if (prescriptionRepository.existsById(id)) {
                prescriptionRepository.deleteById(id);
                return true;
            }
            return false;
        } catch (Exception e) {
            return false;
        }
    }

    // Get inventory item by ID
    public Lab_Phar_MedicineInventory getInventoryItemById(Integer id) {
        return medicineInventoryRepository.findById(id).orElse(null);
    }
}

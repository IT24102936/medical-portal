package com.medicalportal.medicalportal.service;

import com.medicalportal.medicalportal.entity.MedicineInventory;
import com.medicalportal.medicalportal.entity.Prescription;
import com.medicalportal.medicalportal.entity.Medicine;
import com.medicalportal.medicalportal.entity.Pharmacist;
import com.medicalportal.medicalportal.repository.MedicineInventoryRepository;
import com.medicalportal.medicalportal.repository.PrescriptionRepository;
import com.medicalportal.medicalportal.repository.MedicineRepository;
import com.medicalportal.medicalportal.repository.PharmacistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PharmacistServices {
    @Autowired
    private PrescriptionRepository prescriptionRepository;

    @Autowired
    private MedicineInventoryRepository medicineInventoryRepository;

    @Autowired
    private MedicineRepository medicineRepository;

    @Autowired
    private PharmacistRepository pharmacistRepository;

    // Get all prescriptions
    public List<Prescription> getAllPrescriptions() {
        return prescriptionRepository.findAll();
    }

    // Add new prescription
    public Prescription addPrescription(Prescription prescription) {
        return prescriptionRepository.save(prescription);
    }

    // Get all medicine inventory
    public List<MedicineInventory> getAllMedicineInventory() {
        return medicineInventoryRepository.findAll();
    }

    // Get low stock items
    public List<MedicineInventory> getLowStockItems() {
        return medicineInventoryRepository.findLowStockItems();
    }

    // Update inventory count
    public void updateInventoryCount(Integer inventoryId, Integer newCount) {
        Optional<MedicineInventory> inventoryOpt = medicineInventoryRepository.findById(inventoryId);
        if (inventoryOpt.isPresent()) {
            MedicineInventory inventory = inventoryOpt.get();
            inventory.setCount(newCount);
            // Update status based on stock level
            if (inventory.isLowStock()) {
                inventory.setStatus("Low Stock");
            } else {
                inventory.setStatus("In Stock");
            }
            medicineInventoryRepository.save(inventory);
        }
    }

    // Add new medicine to inventory
    public MedicineInventory addMedicineToInventory(MedicineInventory inventory) {
        return medicineInventoryRepository.save(inventory);
    }

    // Get all medicines
    public List<Medicine> getAllMedicines() {
        return medicineRepository.findAll();
    }

    // Get medicine by code
    public Medicine getMedicineByCode(String medicineCode) {
        return medicineRepository.findById(medicineCode).orElse(null);
    }

    // Get pharmacist by ID
    public Optional<Pharmacist> getPharmacistById(Integer pharmacistId) {
        return pharmacistRepository.findById(pharmacistId);
    }

    // Restock inventory - add stock to existing inventory
    public void restockInventory(Integer inventoryId, Integer additionalStock) {
        Optional<MedicineInventory> inventoryOpt = medicineInventoryRepository.findById(inventoryId);
        if (inventoryOpt.isPresent()) {
            MedicineInventory inventory = inventoryOpt.get();
            inventory.setCount(inventory.getCount() + additionalStock);
            // Update status based on stock level
            if (inventory.isLowStock()) {
                inventory.setStatus("Low Stock");
            } else {
                inventory.setStatus("In Stock");
            }
            medicineInventoryRepository.save(inventory);
        }
    }

    // Reduce stock - for dispensing or other reasons
    public void reduceStock(Integer inventoryId, Integer reductionAmount, String reason) {
        Optional<MedicineInventory> inventoryOpt = medicineInventoryRepository.findById(inventoryId);
        if (inventoryOpt.isPresent()) {
            MedicineInventory inventory = inventoryOpt.get();
            int newCount = Math.max(0, inventory.getCount() - reductionAmount);
            inventory.setCount(newCount);
            
            // Update status based on stock level
            if (newCount == 0) {
                inventory.setStatus("Out of Stock");
            } else if (inventory.isLowStock()) {
                inventory.setStatus("Low Stock");
            } else {
                inventory.setStatus("In Stock");
            }
            
            // Update description to include reduction reason
            if (reason != null && !reason.isEmpty()) {
                String currentDesc = inventory.getDescription() != null ? inventory.getDescription() : "";
                inventory.setDescription(currentDesc + " [" + reason + ": -" + reductionAmount + "]");
            }
            
            medicineInventoryRepository.save(inventory);
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
    public Prescription getPrescriptionById(Integer id) {
        return prescriptionRepository.findById(id).orElse(null);
    }

    // Get inventory item by ID
    public MedicineInventory getInventoryItemById(Integer id) {
        return medicineInventoryRepository.findById(id).orElse(null);
    }
}

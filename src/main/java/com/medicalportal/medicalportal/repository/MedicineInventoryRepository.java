package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.MedicineInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MedicineInventoryRepository extends JpaRepository<MedicineInventory, Integer> {
    
    // Find inventory items with low stock
    @Query("SELECT mi FROM MedicineInventory mi WHERE mi.count <= mi.minLevel")
    List<MedicineInventory> findLowStockItems();
    
    // Count low stock items
    @Query("SELECT COUNT(mi) FROM MedicineInventory mi WHERE mi.count <= mi.minLevel")
    long countLowStockItems();
    
    // Find inventory by medicine code
    List<MedicineInventory> findByMedicineMedicineCode(String medicineCode);
    
    // Find inventory by pharmacist ID
    List<MedicineInventory> findByPharmacistId(Integer pharmacistId);
    
    // Find inventory by status
    List<MedicineInventory> findByStatus(String status);
}
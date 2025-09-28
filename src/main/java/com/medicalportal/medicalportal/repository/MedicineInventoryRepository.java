package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.MedicineInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MedicineInventoryRepository extends JpaRepository<MedicineInventory, Integer> {
    
    // Find inventory by pharmacist EID
    List<MedicineInventory> findByPharmacistEid(Integer pharmacistEid);
    
    // Find inventory items with count below a threshold (for low stock alerts)
    @Query("SELECT mi FROM MedicineInventory mi WHERE mi.count < 10")
    List<MedicineInventory> findLowStockItems();
    
    // Count low stock items (count < 10)
    @Query("SELECT COUNT(mi) FROM MedicineInventory mi WHERE mi.count < 10")
    long countLowStockItems();
}
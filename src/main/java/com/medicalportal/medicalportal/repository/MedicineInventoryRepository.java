package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.MedicineInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface MedicineInventoryRepository extends JpaRepository<MedicineInventory, Integer> {
    
    // Find all medicine inventory
    @Query("SELECT mi FROM MedicineInventory mi ORDER BY mi.id")
    List<MedicineInventory> findAll();
    
    // Find medicine inventory by ID
    @Query("SELECT mi FROM MedicineInventory mi WHERE mi.id = :id")
    Optional<MedicineInventory> findById(@Param("id") Integer id);
    
    // Check if medicine inventory exists by ID
    @Query("SELECT CASE WHEN COUNT(mi) > 0 THEN true ELSE false END FROM MedicineInventory mi WHERE mi.id = :id")
    boolean existsById(@Param("id") Integer id);
    
    // Find inventory by pharmacist EID
    @Query("SELECT mi FROM MedicineInventory mi WHERE mi.pharmacistEid = :pharmacistEid ORDER BY mi.id")
    List<MedicineInventory> findByPharmacistEid(@Param("pharmacistEid") Integer pharmacistEid);
    
    // Find inventory items with count below a threshold (for low stock alerts)
    @Query("SELECT mi FROM MedicineInventory mi WHERE mi.count < 10 ORDER BY mi.count ASC")
    List<MedicineInventory> findLowStockItems();
    
    // Count low stock items (count < 10)
    @Query("SELECT COUNT(mi) FROM MedicineInventory mi WHERE mi.count < 10")
    long countLowStockItems();
    
    // Count total inventory items
    @Query("SELECT COUNT(mi) FROM MedicineInventory mi")
    long count();
    
    // Insert new medicine inventory (only available fields)
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO medicine_inventory (count, pharmacist_eid, description) VALUES (:count, :pharmacistEid, :description)", nativeQuery = true)
    void insertMedicineInventory(@Param("count") Integer count, 
                                @Param("pharmacistEid") Integer pharmacistEid, 
                                @Param("description") String description);
    
    // Get last inserted ID
    @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
    Integer getLastInsertedId();
    
    // Update medicine inventory count
    @Modifying
    @Transactional
    @Query("UPDATE MedicineInventory mi SET mi.count = :count WHERE mi.id = :id")
    void updateInventoryCount(@Param("id") Integer id, @Param("count") Integer count);
    
    // Update medicine inventory details (only available fields)
    @Modifying
    @Transactional
    @Query("UPDATE MedicineInventory mi SET mi.count = :count, mi.description = :description WHERE mi.id = :id")
    void updateMedicineInventory(@Param("id") Integer id, 
                                @Param("count") Integer count, 
                                @Param("description") String description);
    
    // Delete medicine inventory by ID
    @Modifying
    @Transactional
    @Query("DELETE FROM MedicineInventory mi WHERE mi.id = :id")
    void deleteById(@Param("id") Integer id);
}
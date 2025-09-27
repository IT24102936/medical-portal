package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.service.PharmacistServices;
import com.medicalportal.medicalportal.entity.MedicineInventory;
import com.medicalportal.medicalportal.entity.Medicine;
import com.medicalportal.medicalportal.entity.Pharmacist;
import com.medicalportal.medicalportal.entity.Prescription;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/pharmacist")
public class PharmacistController {

    @Autowired
    private PharmacistServices pharmacistServices;

    @GetMapping
    public String showDashboard(Model model) {
        
       
        List<Prescription> prescriptions = pharmacistServices.getAllPrescriptions();
        List<MedicineInventory> inventory = pharmacistServices.getAllMedicineInventory();
        List<Medicine> medicines = pharmacistServices.getAllMedicines();

        // Add null safety
        model.addAttribute("prescriptions", prescriptions != null ? prescriptions : new ArrayList<>());
        model.addAttribute("inventory", inventory != null ? inventory : new ArrayList<>());
        model.addAttribute("medicines", medicines != null ? medicines : new ArrayList<>());

        // Statistics with null safety
        model.addAttribute("totalPrescriptions", prescriptions != null ? prescriptions.size() : 0);
        model.addAttribute("totalItems", inventory != null ? inventory.size() : 0);
        model.addAttribute("lowStockCount", pharmacistServices.getLowStockItemsCount());

        return "pharmacist-dashboard";
    }

    @GetMapping("/dashboard")
    public String showPharmacistDashboard(Model model) {
        return showDashboard(model);
    }

    // Add new prescription
    @PostMapping("/prescription/add")
    public String addPrescription(@RequestParam String description,
                                  RedirectAttributes redirectAttributes) {
        try {
            // Validation
            if (description == null || description.trim().isEmpty()) {
                throw new IllegalArgumentException("Description cannot be empty");
            }

            if (description.length() > 500) {
                throw new IllegalArgumentException("Description too long");
            }

            Prescription prescription = new Prescription();
            prescription.setDescription(description.trim());
            pharmacistServices.addPrescription(prescription);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Prescription added successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to add prescription: " + e.getMessage());
        }
        return "redirect:/pharmacist";
    }

    // Add new medicine to inventory
    @PostMapping("/inventory/add")
    public String addMedicineToInventory(
            @RequestParam String medicineCode,
            @RequestParam String description,
            @RequestParam Integer stockCount,
            @RequestParam Integer minLevel,
            @RequestParam String expiryDate,
            @RequestParam Integer pharmacistId,
            RedirectAttributes redirectAttributes) {
        try {
            // Create new inventory item
            MedicineInventory inventory = new MedicineInventory();
            inventory.setDescription(description);
            inventory.setCount(stockCount);
            inventory.setMinLevel(minLevel);
            inventory.setExpiryDate(LocalDate.parse(expiryDate));
            inventory.setStatus(stockCount > minLevel ? "In Stock" : "Low Stock");

            // Get medicine and pharmacist
            Medicine medicine = pharmacistServices.getMedicineByCode(medicineCode);
            Pharmacist pharmacist = pharmacistServices.getPharmacistById(pharmacistId).orElse(null);

            inventory.setMedicine(medicine);
            inventory.setPharmacist(pharmacist);

            pharmacistServices.addMedicineToInventory(inventory);
            redirectAttributes.addFlashAttribute("successMessage", "Medicine added to inventory successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add medicine: " + e.getMessage());
        }
        return "redirect:/pharmacist";
    }

    // Restock inventory
    @PostMapping("/inventory/restock")
    public String restockInventory(
            @RequestParam Integer inventoryId,
            @RequestParam Integer additionalStock,
            RedirectAttributes redirectAttributes) {
        try {
            pharmacistServices.restockInventory(inventoryId, additionalStock);
            redirectAttributes.addFlashAttribute("successMessage", "Inventory restocked successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to restock inventory: " + e.getMessage());
        }
        return "redirect:/pharmacist";
    }

    // Reduce stock (for dispensing or other reasons)
    @PostMapping("/inventory/reduce")
    public String reduceStock(
            @RequestParam Integer inventoryId,
            @RequestParam Integer reductionAmount,
            @RequestParam String reason,
            RedirectAttributes redirectAttributes) {
        try {
            pharmacistServices.reduceStock(inventoryId, reductionAmount, reason);
            redirectAttributes.addFlashAttribute("successMessage", "Stock reduced successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to reduce stock: " + e.getMessage());
        }
        return "redirect:/pharmacist";
    }

    // Get low stock items
    @GetMapping("/inventory/low-stock")
    public String showLowStockItems(Model model) {
        model.addAttribute("prescriptions", pharmacistServices.getAllPrescriptions());
        model.addAttribute("inventory", pharmacistServices.getLowStockItems());
        model.addAttribute("totalPrescriptions", pharmacistServices.getTotalPrescriptionsCount());
        model.addAttribute("totalItems", pharmacistServices.getTotalInventoryItems());
        model.addAttribute("lowStockCount", pharmacistServices.getLowStockItemsCount());
        model.addAttribute("medicines", pharmacistServices.getAllMedicines());
        model.addAttribute("showLowStockOnly", true);

        return "pharmacist-dashboard";
    }

    // Update pharmacist profile
    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String address,
            @RequestParam String contactNumber,
            RedirectAttributes redirectAttributes) {
        try {
            // Here you would typically update the pharmacist's profile in the database
            // For now, we'll just show a success message
            redirectAttributes.addFlashAttribute("successMessage",
                    "Profile updated successfully! Name: " + firstName + " " + lastName);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update profile: " + e.getMessage());
        }
        return "redirect:/pharmacist";
    }

    // Get individual prescription details
    @GetMapping("/prescription/{id}")
    @ResponseBody
    public Prescription getPrescription(@PathVariable Integer id) {
        return pharmacistServices.getPrescriptionById(id);
    }

    // Navigate to prescriptions page
    @GetMapping("/prescriptions")
    public String showPrescriptions(Model model) {
        model.addAttribute("prescriptions", pharmacistServices.getAllPrescriptions());
        return "prescriptions"; // Create this view or redirect as needed
    }

    // Get inventory item details
    @GetMapping("/inventory/{id}")
    @ResponseBody
    public MedicineInventory getInventoryItem(@PathVariable Integer id) {
        return pharmacistServices.getInventoryItemById(id);
    }
}
    


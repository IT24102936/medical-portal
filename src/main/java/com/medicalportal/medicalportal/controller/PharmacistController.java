package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.service.PharmacistServices;
import com.medicalportal.medicalportal.entity.MedicineInventory;
import com.medicalportal.medicalportal.entity.Medicine;
import com.medicalportal.medicalportal.entity.Pharmacist;
import com.medicalportal.medicalportal.entity.Prescription;
import com.medicalportal.medicalportal.entity.Employee;
import com.medicalportal.medicalportal.repository.EmployeeRepository;
import com.medicalportal.medicalportal.repository.PharmacistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/pharmacist")
public class PharmacistController {

    @Autowired
    private PharmacistServices pharmacistServices;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private PharmacistRepository pharmacistRepository;

    @GetMapping
    public String showDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        // Check authentication
        Employee employee = (Employee) session.getAttribute("loggedInEmployee");
        String role = (String) session.getAttribute("employeeRole");
        
        if (employee == null) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Please log in to access the pharmacist dashboard.");
            return "redirect:/auth/login?role=pharmacist";
        }
        
        if (!"pharmacist".equalsIgnoreCase(role)) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Access denied. You need pharmacist privileges to access this page.");
            return "redirect:/auth/login?role=pharmacist";
        }
        
        // Add employee info to model
        model.addAttribute("currentEmployee", employee);
        model.addAttribute("employeeName", employee.getFirstName() + " " + employee.getLastName());
        
        // Initialize pharmacist record if it doesn't exist
        initializePharmacistRecord();
        
        // Initialize sample data if database is empty
        if (pharmacistServices.getTotalPrescriptionsCount() == 0) {
            initializeSamplePrescriptions();
        }
        if (pharmacistServices.getTotalInventoryItems() == 0) {
            initializeSampleInventory();
        }
       
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
    public String showPharmacistDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        return showDashboard(model, session, redirectAttributes);
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
            @RequestParam String description,
            @RequestParam Integer stockCount,
            @RequestParam Integer pharmacistEid,
            RedirectAttributes redirectAttributes) {
        try {
            // Create new inventory item
            MedicineInventory inventory = new MedicineInventory();
            inventory.setDescription(description);
            inventory.setCount(stockCount);
           // inventory.setPharmacistEid(pharmacistEid);
            
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
    
    // Delete prescription
    @PostMapping("/prescription/delete/{id}")
    public String deletePrescription(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            boolean deleted = pharmacistServices.deletePrescription(id);
            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage", 
                        "Prescription #RX" + id + " deleted successfully.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                        "Prescription not found or could not be deleted.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                    "Failed to delete prescription: " + e.getMessage());
        }
        return "redirect:/pharmacist";
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
    
    // Initialize sample prescription data for demonstration
    private void initializeSamplePrescriptions() {
        // Create sample prescriptions
        Prescription prescription1 = new Prescription();
        prescription1.setDescription("Aspirin 81mg, take one tablet daily with food for 30 days.");
        pharmacistServices.addPrescription(prescription1);
        
        Prescription prescription2 = new Prescription();
        prescription2.setDescription("Lisinopril 10mg, take one tablet daily in the morning.");
        pharmacistServices.addPrescription(prescription2);
        
        Prescription prescription3 = new Prescription();
        prescription3.setDescription("Metformin 500mg, take one tablet twice daily with meals.");
        pharmacistServices.addPrescription(prescription3);
        
        Prescription prescription4 = new Prescription();
        prescription4.setDescription("Amoxicillin 250mg, take one capsule three times daily for 7 days.");
        pharmacistServices.addPrescription(prescription4);
        
        Prescription prescription5 = new Prescription();
        prescription5.setDescription("Ibuprofen 200mg, take 1-2 tablets every 4-6 hours as needed for pain.");
        pharmacistServices.addPrescription(prescription5);
    }
    
    // Initialize sample inventory data for demonstration
    private void initializeSampleInventory() {
        try {
            // Create sample inventory items with simplified structure
            MedicineInventory inventory1 = new MedicineInventory();
            inventory1.setDescription("Pain relief medication - Over the counter aspirin tablets");
            inventory1.setCount(150);
            inventory1.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory1);
            
            MedicineInventory inventory2 = new MedicineInventory();
            inventory2.setDescription("Blood pressure medication - Lisinopril tablets");
            inventory2.setCount(8);
            inventory2.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory2);
            
            MedicineInventory inventory3 = new MedicineInventory();
            inventory3.setDescription("Diabetes medication - Metformin tablets");
            inventory3.setCount(75);
            inventory3.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory3);
            
            MedicineInventory inventory4 = new MedicineInventory();
            inventory4.setDescription("Antibiotic - Amoxicillin capsules");
            inventory4.setCount(45);
            inventory4.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory4);
            
        } catch (Exception e) {
            // Log error but don't break the application
            System.err.println("Error initializing sample inventory: " + e.getMessage());
        }
    }
    
    // Initialize pharmacist record if it doesn't exist
    private void initializePharmacistRecord() {
        try {
            // Check if pharmacist with EID 1 exists
            if (!pharmacistRepository.existsById(1)) {
                // First check if employee with EID 1 exists
                Employee employee = employeeRepository.findById(1).orElse(null);
                
                if (employee == null) {
                    // Create employee record first
                    employee = new Employee();
                    employee.setId(1); // Set EID to 1
                    employee.setFirstName("John");
                    employee.setLastName("Smith");
                    employee.setNationalId("NID001");
                    employee.setGender("Male");
                    employee.setDob(LocalDate.of(1985, 6, 15));
                    employee.setEmail("john.smith@medisphere.com");
                    employee.setPassword("password123");
                    employee.setUserName("jsmith");
                    employee.setSalary(new BigDecimal("75000.00"));
                    
                    employee = employeeRepository.save(employee);
                }
                
                // Create pharmacist record
                Pharmacist pharmacist = new Pharmacist();
                pharmacist.setId(1); // Set EID to 1 to match employee
                pharmacist.setEmployee(employee);
                
                pharmacistRepository.save(pharmacist);
                
                System.out.println("Initialized pharmacist record with EID: 1");
            }
        } catch (Exception e) {
            System.err.println("Error initializing pharmacist record: " + e.getMessage());
        }
    }
}
    


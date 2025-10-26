package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.*;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Employee;
import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Pharmacist;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_EmployeeRepository;
import com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository.Lab_Phar_PharmacistRepository;
import com.medicalportal.medicalportal.service.LabTech_Pharmacist.Lab_Phar_PharmacistServices;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/pharmacist")
public class PharmacistController {

    @Autowired
    private Lab_Phar_PharmacistServices pharmacistServices;

    @Autowired
    private Lab_Phar_EmployeeRepository employeeRepository;

    @Autowired
    private Lab_Phar_PharmacistRepository pharmacistRepository;
    
    // =============== AUTHENTICATION HELPER ===============
    
    private boolean isPharmacistLoggedIn(HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        return "employee".equals(userType) && "Pharmacist".equals(role);
    }
    
    private String checkPharmacistAccess(HttpSession session) {
        if (!isPharmacistLoggedIn(session)) {
            return "redirect:/login";
        }
        return null;
    }

    @GetMapping
    public String showDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        String redirectUrl = checkPharmacistAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        // Get employee details from session
        Integer employeeId = (Integer) session.getAttribute("userId");
        if (employeeId != null) {
            try {
                Lab_Phar_Pharmacist pharmacist = pharmacistRepository.findById(employeeId).orElse(null);
                if (pharmacist != null && pharmacist.getEmployee() != null) {
                    Lab_Phar_Employee employee = pharmacist.getEmployee();
                    model.addAttribute("employeeFirstName", employee.getFirstName());
                    model.addAttribute("employeeLastName", employee.getLastName());
                    model.addAttribute("employeeName", employee.getFirstName() + " " + employee.getLastName());
                    model.addAttribute("employeeId", employee.getId());
                    model.addAttribute("employeeEmail", employee.getEmail());
                } else {
                    model.addAttribute("employeeName", "Pharmacist");
                }
            } catch (Exception e) {
                model.addAttribute("employeeName", "Pharmacist");
            }
        } else {
            model.addAttribute("employeeName", "Pharmacist");
        }
        
        // Initialize pharmacist record if it doesn't exist
        initializePharmacistRecord();
        
        // Initialize sample data if database is empty
        if (pharmacistServices.getTotalPrescriptionsCount() == 0) {
            initializeSamplePrescriptions();
        }
        if (pharmacistServices.getTotalInventoryItems() == 0) {
            initializeSampleInventory();
        }
       
        List<Lab_Phar_Prescription> prescriptions = pharmacistServices.getAllPrescriptions();
        List<Lab_Phar_MedicineInventory> inventory = pharmacistServices.getAllMedicineInventory();
        List<Lab_Phar_Medicine> medicines = pharmacistServices.getAllMedicines();

        // Add null safety
        model.addAttribute("prescriptions", prescriptions != null ? prescriptions : new ArrayList<>());
        model.addAttribute("inventory", inventory != null ? inventory : new ArrayList<>());
        model.addAttribute("medicines", medicines != null ? medicines : new ArrayList<>());

        // Statistics with null safety
        model.addAttribute("totalPrescriptions", prescriptions != null ? prescriptions.size() : 0);
        model.addAttribute("totalItems", inventory != null ? inventory.size() : 0);
        model.addAttribute("lowStockCount", pharmacistServices.getLowStockItemsCount());

        return "LabTech_Pharmacist/pharmacist-dashboard";
    }

    @GetMapping("/dashboard")
    public String showPharmacistDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        String redirectUrl = checkPharmacistAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
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

            Lab_Phar_Prescription prescription = new Lab_Phar_Prescription();
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
            Lab_Phar_MedicineInventory inventory = new Lab_Phar_MedicineInventory();
            inventory.setDescription(description);
            inventory.setCount(stockCount);
            inventory.setPharmacistEid(pharmacistEid);
            
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

        return "LabTech_Pharmacist/pharmacist-dashboard";
    }

    // Update pharmacist profile
    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String nationalId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            Integer employeeId = (Integer) session.getAttribute("userId");
            if (employeeId == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Session expired. Please login again.");
                return "redirect:/login";
            }
            
            // Get the employee record
            Lab_Phar_Employee employee = employeeRepository.findById(employeeId).orElse(null);
            if (employee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Employee record not found.");
                return "redirect:/pharmacist";
            }
            
            // Update employee details
            employee.setFirstName(firstName);
            employee.setLastName(lastName);
            if (email != null && !email.trim().isEmpty()) {
                employee.setEmail(email);
            }
            if (nationalId != null && !nationalId.trim().isEmpty()) {
                employee.setNationalId(nationalId);
            }
            
            // Save updated employee
            employeeRepository.save(employee);
            
            redirectAttributes.addFlashAttribute("successMessage",
                    "Profile updated successfully! Name: " + firstName + " " + lastName);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to update profile: " + e.getMessage());
        }
        return "redirect:/pharmacist";
    }

    // Get individual prescription details
    @GetMapping("/prescription/{id}")
    @ResponseBody
    public Lab_Phar_Prescription getPrescription(@PathVariable Integer id) {
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
    public Lab_Phar_MedicineInventory getInventoryItem(@PathVariable Integer id) {
        return pharmacistServices.getInventoryItemById(id);
    }
    
    // Initialize sample prescription data for demonstration
    private void initializeSamplePrescriptions() {
        // Create sample prescriptions
        Lab_Phar_Prescription prescription1 = new Lab_Phar_Prescription();
        prescription1.setDescription("Aspirin 81mg, take one tablet daily with food for 30 days.");
        pharmacistServices.addPrescription(prescription1);
        
        Lab_Phar_Prescription prescription2 = new Lab_Phar_Prescription();
        prescription2.setDescription("Lisinopril 10mg, take one tablet daily in the morning.");
        pharmacistServices.addPrescription(prescription2);
        
        Lab_Phar_Prescription prescription3 = new Lab_Phar_Prescription();
        prescription3.setDescription("Metformin 500mg, take one tablet twice daily with meals.");
        pharmacistServices.addPrescription(prescription3);
        
        Lab_Phar_Prescription prescription4 = new Lab_Phar_Prescription();
        prescription4.setDescription("Amoxicillin 250mg, take one capsule three times daily for 7 days.");
        pharmacistServices.addPrescription(prescription4);
        
        Lab_Phar_Prescription prescription5 = new Lab_Phar_Prescription();
        prescription5.setDescription("Ibuprofen 200mg, take 1-2 tablets every 4-6 hours as needed for pain.");
        pharmacistServices.addPrescription(prescription5);
    }
    
    // Initialize sample inventory data for demonstration
    private void initializeSampleInventory() {
        try {
            // Create sample inventory items with simplified structure
            Lab_Phar_MedicineInventory inventory1 = new Lab_Phar_MedicineInventory();
            inventory1.setDescription("Pain relief medication - Over the counter aspirin tablets");
            inventory1.setCount(150);
            inventory1.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory1);
            
            Lab_Phar_MedicineInventory inventory2 = new Lab_Phar_MedicineInventory();
            inventory2.setDescription("Blood pressure medication - Lisinopril tablets");
            inventory2.setCount(8);
            inventory2.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory2);
            
            Lab_Phar_MedicineInventory inventory3 = new Lab_Phar_MedicineInventory();
            inventory3.setDescription("Diabetes medication - Metformin tablets");
            inventory3.setCount(75);
            inventory3.setPharmacistEid(1);
            pharmacistServices.addMedicineToInventory(inventory3);
            
            Lab_Phar_MedicineInventory inventory4 = new Lab_Phar_MedicineInventory();
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
                Lab_Phar_Employee employee = employeeRepository.findById(1).orElse(null);
                
                if (employee == null) {
                    // Create employee record first
                    employee = new Lab_Phar_Employee();
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
                Lab_Phar_Pharmacist pharmacist = new Lab_Phar_Pharmacist();
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
    


package com.medicalportal.medicalportal.controller.admin;

import com.medicalportal.medicalportal.entity.admin.Admin_Doctor;
import com.medicalportal.medicalportal.entity.admin.Admin_Employee;
import com.medicalportal.medicalportal.service.admin.Admin_AdminService;
import com.medicalportal.medicalportal.service.admin.Admin_AppointmentService;
import com.medicalportal.medicalportal.service.admin.Admin_EmployeeService;
import com.medicalportal.medicalportal.service.admin.Admin_PatientService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private final Admin_AdminService adminService;
    private final Admin_AppointmentService appointmentService;
    private final Admin_EmployeeService employeeService;
    private final Admin_PatientService patientService;

    public AdminController(Admin_AdminService adminService, Admin_AppointmentService appointmentService, Admin_EmployeeService employeeService, Admin_PatientService patientService) {
        this.adminService = adminService;
        this.appointmentService = appointmentService;
        this.employeeService = employeeService;
        this.patientService = patientService;
    }

    // =============== AUTHENTICATION HELPER ===============
    
    private boolean isAdminLoggedIn(HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        String role = (String) session.getAttribute("role");
        return "employee".equals(userType) && "Admin".equals(role);
    }
    
    private String checkAdminAccess(HttpSession session) {
        if (!isAdminLoggedIn(session)) {
            return "redirect:/login";
        }
        return null;
    }

    // =============== DASHBOARD ENDPOINT ===============
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        String redirectUrl = checkAdminAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        try {
            // Get statistics for the dashboard
            List<Map<String, Object>> patients = patientService.getAllPatients();
            List<Admin_Doctor> doctors = adminService.getAllDoctors();
            List<Map<String, Object>> employees = employeeService.getAllEmployees();
            List<Map<String, Object>> todaysAppointments = appointmentService.getTodaysAppointments();
            List<Map<String, Object>> allAppointments = appointmentService.getAllAppointments();
            
            // Calculate statistics
            int totalPatients = patients.size();
            int totalDoctors = doctors.size();
            int totalEmployees = employees.size();
            int todayAppointments = todaysAppointments.size();
            int totalAppointments = allAppointments.size();
            
            // Add statistics to model
            model.addAttribute("totalPatients", totalPatients);
            model.addAttribute("totalDoctors", totalDoctors);
            model.addAttribute("totalEmployees", totalEmployees);
            model.addAttribute("todayAppointments", todayAppointments);
            model.addAttribute("totalAppointments", totalAppointments);
            
            // Add appointments list for the table (limit to first 6)
            if (todaysAppointments.size() > 6) {
                model.addAttribute("appointments", todaysAppointments.subList(0, 6));
            } else {
                model.addAttribute("appointments", todaysAppointments);
            }
            
            System.out.println("Dashboard loaded with: " + totalPatients + " patients, " + 
                             totalDoctors + " doctors, " + totalEmployees + " employees, " +
                             todayAppointments + " today's appointments, " + 
                             totalAppointments + " total appointments");
            
        } catch (Exception e) {
            System.err.println("Error loading dashboard: " + e.getMessage());
            e.printStackTrace();
            
            // Add default values in case of error
            model.addAttribute("totalPatients", 0);
            model.addAttribute("totalDoctors", 0);
            model.addAttribute("totalEmployees", 0);
            model.addAttribute("todayAppointments", 0);
            model.addAttribute("totalAppointments", 0);
            model.addAttribute("appointments", java.util.Collections.emptyList());
            model.addAttribute("error", "Error loading dashboard data: " + e.getMessage());
        }
        
        return "admin/Admin-dashboard";
    }

    // =============== APPOINTMENT STATISTICS ENDPOINT ===============
    
    @GetMapping("/dashboard/appointment-stats")
    @ResponseBody
    public Map<String, Object> getAppointmentStats() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, Object>> stats = appointmentService.getAppointmentCountsBySpecialization();
            
            // Prepare data for the chart
            String[] labels = new String[stats.size()];
            int[] data = new int[stats.size()];
            
            for (int i = 0; i < stats.size(); i++) {
                Map<String, Object> stat = stats.get(i);
                labels[i] = stat.get("specialization") != null ? stat.get("specialization").toString() : "Unknown";
                data[i] = stat.get("count") != null ? Integer.parseInt(stat.get("count").toString()) : 0;
            }
            
            response.put("labels", labels);
            response.put("data", data);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }

    // =============== APPOINTMENT TRENDS ENDPOINT ===============
    
    @GetMapping("/appointments/trends")
    @ResponseBody
    public Map<String, Object> getAppointmentTrends() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, Object>> trends = appointmentService.getAppointmentCountsByMonth();
            
            // Prepare data for the chart
            String[] labels = new String[trends.size()];
            int[] data = new int[trends.size()];
            
            for (int i = 0; i < trends.size(); i++) {
                Map<String, Object> trend = trends.get(i);
                labels[i] = trend.get("month") != null ? trend.get("month").toString() : "Unknown";
                data[i] = trend.get("count") != null ? Integer.parseInt(trend.get("count").toString()) : 0;
            }
            
            response.put("labels", labels);
            response.put("data", data);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }

    // =============== DOCTOR MANAGEMENT ENDPOINTS ===============

    @GetMapping("/doctors")
    public String doctors(Model model, HttpSession session) {
        String redirectUrl = checkAdminAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        model.addAttribute("doctors", adminService.getAllDoctors());
        return "admin/Admin-Doctor_management";
    }

    @PostMapping("/doctors/edit/{eid}")
    public String editDoctor(@PathVariable Integer eid,
                             @RequestParam String firstName,
                             @RequestParam String lastName,
                             @RequestParam String email,
                             @RequestParam String gender,
                             @RequestParam String dob,
                             @RequestParam String salary,
                             @RequestParam String phone,
                             @RequestParam String nationalId,
                             @RequestParam String userName,
                             @RequestParam String status,
                             @RequestParam String specialization,
                             @RequestParam(required = false) String password) {
        LocalDate localDob = LocalDate.parse(dob);
        adminService.editDoctor(eid, firstName, lastName, email, gender, localDob, new BigDecimal(salary), phone, nationalId, userName, status, specialization, password);
        return "redirect:/admin/doctors";
    }

    @PostMapping("/doctors/disable/{eid}")
    public String disableDoctor(@PathVariable Integer eid) {
        adminService.disableDoctor(eid);
        return "redirect:/admin/doctors";
    }

    @PostMapping("/doctors/enable/{eid}")
    public String enableDoctor(@PathVariable Integer eid) {
        adminService.enableDoctor(eid);
        return "redirect:/admin/doctors";
    }

    @PostMapping("/doctors/delete/{eid}")
    public String deleteDoctor(@PathVariable Integer eid) {
        adminService.deleteDoctor(eid);
        return "redirect:/admin/doctors";
    }

    @PostMapping("/doctors/add")
    public String addDoctor(@RequestParam String firstName,
                            @RequestParam String lastName,
                            @RequestParam String email,
                            @RequestParam String gender,
                            @RequestParam(required = false) String dob,
                            @RequestParam BigDecimal salary,
                            @RequestParam(required = false) String phone,
                            @RequestParam(required = false) String nationalId,
                            @RequestParam String userName,
                            @RequestParam String specialization,
                            @RequestParam String password,
                            @RequestParam String confirmPassword) {

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            // In a real application, you'd want to handle this error properly
            throw new RuntimeException("Passwords do not match");
        }

        LocalDate localDob = null;
        if (dob != null && !dob.trim().isEmpty()) {
            localDob = LocalDate.parse(dob);
        }

        adminService.addDoctor(firstName, lastName, email, gender, localDob, salary, phone, nationalId, userName, specialization, password);
        return "redirect:/admin/doctors";
    }

    @GetMapping("/doctors/{eid}")
    @ResponseBody
    public Map<String, Object> getDoctorDetails(@PathVariable Integer eid) {
        Map<String, Object> response = new HashMap<>();
        Admin_Doctor doctor = adminService.getAllDoctors().stream()
                .filter(d -> d.getEid() != null && d.getEid().equals(eid))
                .findFirst()
                .orElse(null);
        if (doctor != null && doctor.getEmployee() != null) {
            Admin_Employee employee = doctor.getEmployee();
            response.put("firstName", employee.getFirstName() != null ? employee.getFirstName() : "");
            response.put("lastName", employee.getLastName() != null ? employee.getLastName() : "");
            response.put("email", employee.getEmail() != null ? employee.getEmail() : "");
            response.put("gender", employee.getGender() != null ? employee.getGender() : "Male");
            response.put("dob", employee.getDob() != null ? employee.getDob().toString() : "");
            response.put("salary", employee.getSalary() != null ? employee.getSalary().toString() : "0");
            response.put("phone", employee.getFirstPhoneNumber()); // Use entity method
            response.put("nationalId", employee.getNationalId() != null ? employee.getNationalId() : "");
            response.put("userName", employee.getUserName() != null ? employee.getUserName() : "");
            response.put("status", employee.getStatus() != null ? employee.getStatus() : "ACTIVE");
            response.put("specialization", doctor.getSpecialization() != null ? doctor.getSpecialization() : "");
        } else {
            response.put("firstName", "");
            response.put("lastName", "");
            response.put("email", "");
            response.put("gender", "Male");
            response.put("dob", "");
            response.put("salary", "0");
            response.put("phone", "");
            response.put("nationalId", "");
            response.put("userName", "");
            response.put("status", "ACTIVE");
            response.put("specialization", "");
        }
        return response;
    }

    // =============== EMPLOYEE MANAGEMENT ENDPOINTS ===============

    @GetMapping("/test-db")
    @ResponseBody
    public String testDatabase() {
        try {
            List<Map<String, Object>> employees = employeeService.getAllEmployees();
            StringBuilder result = new StringBuilder("Database connection successful. Found " + employees.size() + " employees.\n\n");

            // Show first employee to check status column
            if (!employees.isEmpty()) {
                Map<String, Object> firstEmployee = employees.get(0);
                result.append("First employee data: ").append(firstEmployee).append("\n\n");
                result.append("Status column exists: ").append(firstEmployee.containsKey("status")).append("\n");
                result.append("Status value: ").append(firstEmployee.get("status"));
            }

            return result.toString();
        } catch (Exception e) {
            return "Database error: " + e.getMessage() + "\n\nFull stack trace:\n" + java.util.Arrays.toString(e.getStackTrace());
        }
    }

    @GetMapping("/employees")
    public String employees(Model model, HttpSession session) {
        String redirectUrl = checkAdminAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        try {
            List<Map<String, Object>> employees = employeeService.getAllEmployees();
            model.addAttribute("employees", employees);
            System.out.println("Found " + employees.size() + " employees");
            return "admin/Admin-Employee_management";
        } catch (Exception e) {
            System.err.println("Error loading employees: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("employees", java.util.Collections.emptyList());
            model.addAttribute("error", "Error loading employees: " + e.getMessage());
            return "admin/Admin-Employee_management";
        }
    }

    @PostMapping("/employees/add")
    public String addEmployee(@RequestParam String firstName,
                              @RequestParam String lastName,
                              @RequestParam String email,
                              @RequestParam String gender,
                              @RequestParam(required = false) String dob,
                              @RequestParam BigDecimal salary,
                              @RequestParam(required = false) String phone,
                              @RequestParam(required = false) String nationalId,
                              @RequestParam String userName,
                              @RequestParam String role,
                              @RequestParam String password,
                              @RequestParam String confirmPassword) {

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            throw new RuntimeException("Passwords do not match");
        }

        LocalDate localDob = null;
        if (dob != null && !dob.trim().isEmpty()) {
            localDob = LocalDate.parse(dob);
        }

        employeeService.addEmployee(firstName, lastName, email, gender, localDob, salary,
                phone, nationalId, userName, role, password);
        return "redirect:/admin/employees";
    }

    @PostMapping("/employees/edit/{eid}")
    public String editEmployee(@PathVariable Integer eid,
                               @RequestParam String firstName,
                               @RequestParam String lastName,
                               @RequestParam String email,
                               @RequestParam String gender,
                               @RequestParam(required = false) String dob,
                               @RequestParam BigDecimal salary,
                               @RequestParam(required = false) String phone,
                               @RequestParam(required = false) String nationalId,
                               @RequestParam String userName,
                               @RequestParam String status,
                               @RequestParam String role,
                               @RequestParam(required = false) String password) {

        LocalDate localDob = null;
        if (dob != null && !dob.trim().isEmpty()) {
            localDob = LocalDate.parse(dob);
        }

        employeeService.updateEmployee(eid, firstName, lastName, email, gender, localDob,
                salary, phone, nationalId, userName, status, role, password);
        return "redirect:/admin/employees";
    }

    @PostMapping("/employees/disable/{eid}")
    public String disableEmployee(@PathVariable Integer eid) {
        employeeService.disableEmployee(eid);
        return "redirect:/admin/employees";
    }

    @PostMapping("/employees/enable/{eid}")
    public String enableEmployee(@PathVariable Integer eid) {
        employeeService.enableEmployee(eid);
        return "redirect:/admin/employees";
    }

    @PostMapping("/employees/delete/{eid}")
    public String deleteEmployee(@PathVariable Integer eid) {
        employeeService.deleteEmployee(eid);
        return "redirect:/admin/employees";
    }

    @GetMapping("/employees/{eid}")
    @ResponseBody
    public Map<String, Object> getEmployeeDetails(@PathVariable Integer eid) {
        Map<String, Object> response = new HashMap<>();
        var employeeOpt = employeeService.getEmployeeById(eid);

        if (employeeOpt.isPresent()) {
            Map<String, Object> employee = employeeOpt.get();
            response.put("firstName", employee.get("first_name") != null ? employee.get("first_name").toString() : "");
            response.put("lastName", employee.get("last_name") != null ? employee.get("last_name").toString() : "");
            response.put("email", employee.get("email") != null ? employee.get("email").toString() : "");
            response.put("gender", employee.get("gender") != null ? employee.get("gender").toString() : "Male");
            response.put("dob", employee.get("dob") != null ? employee.get("dob").toString() : "");
            response.put("salary", employee.get("salary") != null ? employee.get("salary").toString() : "0");
            response.put("nationalId", employee.get("national_id") != null ? employee.get("national_id").toString() : "");
            response.put("userName", employee.get("user_name") != null ? employee.get("user_name").toString() : "");
            response.put("status", employee.get("status") != null ? employee.get("status").toString() : "ACTIVE");
            response.put("role", employee.get("role") != null ? employee.get("role").toString() : "Employee");

            // Get phone numbers
            List<String> phoneNumbers = employeeService.getPhoneNumbersByEid(eid);
            response.put("phone", phoneNumbers.isEmpty() ? "" : phoneNumbers.get(0));
        } else {
            // Return empty values if employee not found
            response.put("firstName", "");
            response.put("lastName", "");
            response.put("email", "");
            response.put("gender", "Male");
            response.put("dob", "");
            response.put("salary", "0");
            response.put("nationalId", "");
            response.put("userName", "");
            response.put("status", "ACTIVE");
            response.put("role", "Employee");
            response.put("phone", "");
        }
        return response;
    }

    // =============== PATIENT MANAGEMENT ENDPOINTS ===============

    @GetMapping("/patients")
    public String patients(Model model, HttpSession session) {
        String redirectUrl = checkAdminAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        try {
            List<Map<String, Object>> patients = patientService.getAllPatients();
            model.addAttribute("patients", patients);
            System.out.println("Found " + patients.size() + " patients");
            return "admin/Admin-Patient_management";
        } catch (Exception e) {
            System.err.println("Error loading patients: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("patients", java.util.Collections.emptyList());
            model.addAttribute("error", "Error loading patients: " + e.getMessage());
            return "admin/Admin-Patient_management";
        }
    }

    @PostMapping("/patients/add")
    public String addPatient(@RequestParam String firstName,
                             @RequestParam String lastName,
                             @RequestParam String email,
                             @RequestParam String gender,
                             @RequestParam(required = false) String dob,
                             @RequestParam(required = false) String phone,
                             @RequestParam(required = false) String nationalId,
                             @RequestParam String password,
                             @RequestParam String confirmPassword) {

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            return "redirect:/admin/patients?error=Password confirmation does not match";
        }

        try {
            LocalDate dateOfBirth = null;
            if (dob != null && !dob.trim().isEmpty()) {
                dateOfBirth = LocalDate.parse(dob);
            }

            // Pass empty string for userName since it's not in the database schema
            patientService.addPatient(firstName, lastName, email, gender, dateOfBirth,
                    phone, nationalId, "", password);
            return "redirect:/admin/patients?success=Patient added successfully";
        } catch (Exception e) {
            System.err.println("Error adding patient: " + e.getMessage());
            return "redirect:/admin/patients?error=Failed to add patient: " + e.getMessage();
        }
    }

    @PostMapping("/patients/edit/{pid}")
    public String editPatient(@PathVariable Integer pid,
                              @RequestParam String firstName,
                              @RequestParam String lastName,
                              @RequestParam String email,
                              @RequestParam String gender,
                              @RequestParam(required = false) String dob,
                              @RequestParam(required = false) String phone,
                              @RequestParam(required = false) String nationalId
                              ) {
        try {
            LocalDate dateOfBirth = null;
            if (dob != null && !dob.trim().isEmpty()) {
                dateOfBirth = LocalDate.parse(dob);
            }

            // Pass empty string for userName since it's not in the database schema
            patientService.updatePatient(pid, firstName, lastName, email, gender,
                    dateOfBirth, phone, nationalId, "");
            return "redirect:/admin/patients?success=Patient updated successfully";
        } catch (Exception e) {
            System.err.println("Error updating patient: " + e.getMessage());
            return "redirect:/admin/patients?error=Failed to update patient: " + e.getMessage();
        }
    }

    @PostMapping("/patients/disable/{pid}")
    public String disablePatient(@PathVariable Integer pid) {
        try {
            patientService.disablePatient(pid);
            return "redirect:/admin/patients?success=Patient disabled successfully";
        } catch (Exception e) {
            System.err.println("Error disabling patient: " + e.getMessage());
            return "redirect:/admin/patients?error=Failed to disable patient: " + e.getMessage();
        }
    }

    @PostMapping("/patients/enable/{pid}")
    public String enablePatient(@PathVariable Integer pid) {
        try {
            patientService.enablePatient(pid);
            return "redirect:/admin/patients?success=Patient enabled successfully";
        } catch (Exception e) {
            System.err.println("Error enabling patient: " + e.getMessage());
            return "redirect:/admin/patients?error=Failed to enable patient: " + e.getMessage();
        }
    }

    @PostMapping("/patients/delete/{pid}")
    public String deletePatient(@PathVariable Integer pid) {
        try {
            patientService.deletePatient(pid);
            return "redirect:/admin/patients?success=Patient deleted successfully";
        } catch (Exception e) {
            System.err.println("Error deleting patient: " + e.getMessage());
            return "redirect:/admin/patients?error=Failed to delete patient: " + e.getMessage();
        }
    }

    @GetMapping("/patients/{pid}")
    @ResponseBody
    public Map<String, Object> getPatientDetails(@PathVariable Integer pid) {
        Map<String, Object> response = new HashMap<>();
        Optional<Map<String, Object>> patientData = patientService.getPatientById(pid);

        if (patientData.isPresent()) {
            Map<String, Object> patient = patientData.get();
            response.put("firstName", patient.get("first_name") != null ? patient.get("first_name") : "");
            response.put("lastName", patient.get("last_name") != null ? patient.get("last_name") : "");
            response.put("email", patient.get("email") != null ? patient.get("email") : "");
            response.put("gender", patient.get("gender") != null ? patient.get("gender") : "Male");
            response.put("dob", patient.get("dob") != null ? patient.get("dob").toString() : "");
            response.put("phone", patient.get("phone_numbers") != null ? patient.get("phone_numbers").toString().split(",")[0].trim() : "");
            response.put("nationalId", patient.get("national_id") != null ? patient.get("national_id") : "");
            response.put("status", patient.get("status") != null ? patient.get("status") : "ACTIVE");
        } else {
            response.put("firstName", "");
            response.put("lastName", "");
            response.put("email", "");
            response.put("gender", "Male");
            response.put("dob", "");
            response.put("phone", "");
            response.put("nationalId", "");
            response.put("status", "ACTIVE");
        }

        return response;
    }

    // =============== APPOINTMENT MANAGEMENT ENDPOINTS ===============

    @GetMapping("/appointments")
    public String appointments(Model model, HttpSession session) {
        String redirectUrl = checkAdminAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        try {
            List<Map<String, Object>> upcomingAppointments = appointmentService.getUpcomingAppointments();
            List<Map<String, Object>> pastAppointments = appointmentService.getPastAppointments();
            List<Map<String, Object>> canceledAppointments = appointmentService.getCanceledAppointments();

            model.addAttribute("upcomingAppointments", upcomingAppointments);
            model.addAttribute("pastAppointments", pastAppointments);
            model.addAttribute("canceledAppointments", canceledAppointments);

            System.out.println("Found " + upcomingAppointments.size() + " upcoming appointments");
            return "admin/Admin-appointments";
        } catch (Exception e) {
            System.err.println("Error loading appointments: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("upcomingAppointments", java.util.Collections.emptyList());
            model.addAttribute("pastAppointments", java.util.Collections.emptyList());
            model.addAttribute("canceledAppointments", java.util.Collections.emptyList());
            model.addAttribute("error", "Error loading appointments: " + e.getMessage());
            return "admin/Admin-appointments";
        }
    }

    @PostMapping("/appointments/cancel/{appointmentId}")
    public String cancelAppointment(@PathVariable Integer appointmentId) {
        try {
            appointmentService.cancelAppointment(appointmentId);
            return "redirect:/admin/appointments?success=Appointment canceled successfully";
        } catch (Exception e) {
            System.err.println("Error canceling appointment: " + e.getMessage());
            return "redirect:/admin/appointments?error=Failed to cancel appointment: " + e.getMessage();
        }
    }

    @PostMapping("/appointments/delete/{appointmentId}")
    public String deleteAppointment(@PathVariable Integer appointmentId) {
        try {
            appointmentService.deleteAppointment(appointmentId);
            return "redirect:/admin/appointments?success=Appointment deleted successfully";
        } catch (Exception e) {
            System.err.println("Error deleting appointment: " + e.getMessage());
            return "redirect:/admin/appointments?error=Failed to delete appointment: " + e.getMessage();
        }
    }

    @GetMapping("/appointments/upcoming")
    @ResponseBody
    public List<Map<String, Object>> getUpcomingAppointments() {
        return appointmentService.getUpcomingAppointments();
    }

    @GetMapping("/appointments/past")
    @ResponseBody
    public List<Map<String, Object>> getPastAppointments() {
        return appointmentService.getPastAppointments();
    }

    @GetMapping("/appointments/canceled")
    @ResponseBody
    public List<Map<String, Object>> getCanceledAppointments() {
        return appointmentService.getCanceledAppointments();
    }

    // =============== REPORTS ENDPOINT ===============

    @GetMapping("/reports")
    public String reports(HttpSession session) {
        String redirectUrl = checkAdminAccess(session);
        if (redirectUrl != null) return redirectUrl;
        
        return "admin/Admin-reports";
    }
}

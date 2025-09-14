package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.entity.Appointment;
import com.medicalportal.medicalportal.entity.Doctor;
import com.medicalportal.medicalportal.entity.Patient;
import com.medicalportal.medicalportal.entity.TimeSlot;
import com.medicalportal.medicalportal.service.AppointmentService;
import com.medicalportal.medicalportal.service.DoctorService;
import com.medicalportal.medicalportal.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Main_controller {
    
    @Autowired
    private PatientService patientService;
    
    @Autowired
    private DoctorService doctorService;
    
    @Autowired
    private AppointmentService appointmentService;
    
    @GetMapping("/")
    public String index() {
        return "index"; // Maps to index.jsp
    }
    
    @GetMapping("/home")
    public String home() {
        return "home"; // Maps to home.jsp
    }
    
    @GetMapping("/login")
    public String login() {
        return "login"; // Maps to login.jsp
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String username, 
                              @RequestParam String password,
                              RedirectAttributes redirectAttributes) {
        // Basic validation - in a real application, you would validate against database
        if (username != null && !username.trim().isEmpty() && 
            password != null && !password.trim().isEmpty()) {
            
            // Check for receptionist credentials
            if ("reception".equals(username) && "reception123".equals(password)) {
                // Redirect to receptionist appointments page
                return "redirect:/receptionist/appointments";
            }
            
            // For other users, redirect to home page
            // In a real application, you would set session attributes here
            return "redirect:/home";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid username or password");
            return "redirect:/login";
        }
    }
    
    @GetMapping("/register")
    public String register() {
        return "register"; // Maps to register.jsp
    }
    
    @PostMapping("/register")
    public String processRegister(@RequestParam String firstName,
                                 @RequestParam String lastName,
                                 @RequestParam String username,
                                 @RequestParam String email,
                                 @RequestParam String phone,
                                 @RequestParam String nationalId,
                                 @RequestParam String dob,
                                 @RequestParam String gender,
                                 @RequestParam String employeeType,
                                 @RequestParam String password,
                                 @RequestParam String confirmPassword,
                                 RedirectAttributes redirectAttributes) {
        // Basic validation
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            nationalId == null || nationalId.trim().isEmpty() ||
            dob == null || dob.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            employeeType == null || employeeType.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            redirectAttributes.addFlashAttribute("error", "All fields are required");
            return "redirect:/register";
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/register";
        }
        
        // In a real application, you would save the user to database here
        // For now, redirect to login page with success message
        redirectAttributes.addFlashAttribute("success", "Registration successful! Please login with your credentials.");
        return "redirect:/login";
    }
    
    @GetMapping("/bookAppointment")
    public String bookAppointment() {
        return "bookAppointment"; // Maps to bookAppointment.jsp
    }
    
    @PostMapping("/bookAppointment")
    public String processAppointment(@RequestParam String doctorId,
                                   @RequestParam String appointmentDate,
                                   @RequestParam String appointmentTime,
                                   @RequestParam(required = false) String patientNotes,
                                   RedirectAttributes redirectAttributes) {
        // Basic validation
        if (doctorId == null || doctorId.trim().isEmpty() ||
            appointmentDate == null || appointmentDate.trim().isEmpty() ||
            appointmentTime == null || appointmentTime.trim().isEmpty()) {
            
            redirectAttributes.addFlashAttribute("error", "All appointment fields are required");
            return "redirect:/bookAppointment";
        }
        
        // In a real application, you would save the appointment to database here
        // For now, redirect to home page with success message
        redirectAttributes.addFlashAttribute("success", "Appointment booked successfully! You will receive a confirmation email shortly.");
        return "redirect:/home";
    }
    
    @GetMapping("/receptionist/dashboard")
    public String receptionistDashboard(Model model) {
        // Redirect to appointments page as the main dashboard
        return "redirect:/receptionist/appointments";
    }
    
    @GetMapping("/receptionist/appointments")
    public String receptionistAppointments(Model model) {
        try {
            // Load appointments from database
            List<Appointment> upcomingAppointments = appointmentService.getUpcomingAppointments();
            List<Appointment> pastAppointments = appointmentService.getPastAppointments();
            List<Appointment> canceledAppointments = appointmentService.getAppointmentsByStatus("Canceled");
            
            // Get today's appointments
            LocalDate today = LocalDate.now();
            List<Appointment> todaysAppointments = appointmentService.getAppointmentsByDate(today);
            
            // Create stats object
            Map<String, Object> stats = new HashMap<>();
            stats.put("todayAppointments", todaysAppointments.size());
            stats.put("upcomingAppointments", upcomingAppointments.size());
            stats.put("newPatients", patientService.getAllPatients().size());
            stats.put("totalDoctors", doctorService.getAllDoctors().size());
            
            // Create receptionist object
            Map<String, Object> receptionist = new HashMap<>();
            receptionist.put("name", "Receptionist");
            
            // Create recent activities
            List<Map<String, String>> recentActivities = new ArrayList<>();
            recentActivities.add(Map.of("description", "New appointment created"));
            recentActivities.add(Map.of("description", "Patient registered"));
            recentActivities.add(Map.of("description", "Doctor schedule updated"));
            
            // Add data to model
            model.addAttribute("upcomingAppointments", upcomingAppointments);
            model.addAttribute("pastAppointments", pastAppointments);
            model.addAttribute("canceledAppointments", canceledAppointments);
            model.addAttribute("todaysAppointments", todaysAppointments);
            model.addAttribute("stats", stats);
            model.addAttribute("receptionist", receptionist);
            model.addAttribute("recentActivities", recentActivities);
            
            return "receptionist_appointments"; // Maps to receptionist_appointments.jsp
        } catch (Exception e) {
            // If database connection fails, return empty lists
            model.addAttribute("upcomingAppointments", List.of());
            model.addAttribute("pastAppointments", List.of());
            model.addAttribute("canceledAppointments", List.of());
            model.addAttribute("todaysAppointments", List.of());
            model.addAttribute("stats", Map.of("todayAppointments", 0, "upcomingAppointments", 0, "newPatients", 0, "totalDoctors", 0));
            model.addAttribute("receptionist", Map.of("name", "User"));
            model.addAttribute("recentActivities", List.of());
            return "receptionist_appointments";
        }
    }
    
    @GetMapping("/receptionist/create-appointment")
    public String createAppointment(Model model) {
        try {
            // Load patients and doctors from database
            List<Patient> patients = patientService.getAllPatients();
            List<Doctor> doctors = doctorService.getAllDoctors();
            
            // If no doctors exist, create some sample doctors
            if (doctors.isEmpty()) {
                createSampleDoctors();
                doctors = doctorService.getAllDoctors();
            }
            
            // Add data to model
            model.addAttribute("patientsList", patients);
            model.addAttribute("doctorsList", doctors);
            
            return "create_appointment"; // Maps to create_appointment.jsp
        } catch (Exception e) {
            // If database connection fails, return empty lists
            model.addAttribute("patientsList", List.of());
            model.addAttribute("doctorsList", List.of());
            return "create_appointment";
        }
    }
    
    @PostMapping("/receptionist/create-appointment")
    public String processCreateAppointment(@RequestParam String patientId,
                                         @RequestParam String doctorId,
                                         @RequestParam String appointmentDate,
                                         @RequestParam String appointmentTime,
                                         @RequestParam String appointmentType,
                                         @RequestParam(required = false) String notes,
                                         RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (patientId == null || patientId.trim().isEmpty() ||
                doctorId == null || doctorId.trim().isEmpty() ||
                appointmentDate == null || appointmentDate.trim().isEmpty() ||
                appointmentTime == null || appointmentTime.trim().isEmpty()) {
                
                redirectAttributes.addFlashAttribute("error", "All required fields must be filled");
                return "redirect:/receptionist/create-appointment";
            }
            
            // Get patient and doctor from database
            Patient patient = patientService.getPatientById(Long.parseLong(patientId)).orElse(null);
            Doctor doctor = doctorService.getDoctorById(Long.parseLong(doctorId)).orElse(null);
            
            if (patient == null || doctor == null) {
                redirectAttributes.addFlashAttribute("error", "Invalid patient or doctor selected");
                return "redirect:/receptionist/create-appointment";
            }
            
            // Parse appointment date and time
            LocalDate date = LocalDate.parse(appointmentDate);
            LocalTime time = LocalTime.parse(appointmentTime, DateTimeFormatter.ofPattern("HH:mm"));
            LocalDateTime appointmentDateTime = LocalDateTime.of(date, time);
            
            // Create and save appointment
            appointmentService.createAppointment(
                "Dr. " + doctor.getEid(), // Using eid as doctor name for now
                patient.getFirstName(),
                patient.getLastName(),
                appointmentDateTime,
                notes != null ? notes : appointmentType
            );
            
            redirectAttributes.addFlashAttribute("success", "Appointment created successfully!");
            return "redirect:/receptionist/appointments";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating appointment: " + e.getMessage());
            return "redirect:/receptionist/create-appointment";
        }
    }
    
    @GetMapping("/receptionist/patients")
    public String patientManagement(Model model) {
        try {
            // Load patients from database
            List<Patient> patients = patientService.getAllPatients();
            model.addAttribute("patientsList", patients);
            return "patient_management"; // Maps to patient_management.jsp
        } catch (Exception e) {
            model.addAttribute("patientsList", List.of());
            return "patient_management";
        }
    }
    
    @PostMapping("/managePatient")
    public String processPatientManagement(@RequestParam String patientId,
                                         @RequestParam String firstName,
                                         @RequestParam String lastName,
                                         @RequestParam String dob,
                                         @RequestParam String gender,
                                         @RequestParam String contact,
                                         @RequestParam(required = false) String email,
                                         @RequestParam(required = false) String address,
                                         RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                dob == null || dob.trim().isEmpty() ||
                gender == null || gender.trim().isEmpty() ||
                contact == null || contact.trim().isEmpty()) {
                
                redirectAttributes.addFlashAttribute("error", "All required fields must be filled");
                return "redirect:/receptionist/patients";
            }
            
            Patient patient;
            boolean isUpdate = !patientId.equals("0");
            
            if (isUpdate) {
                // Update existing patient
                patient = patientService.getPatientById(Long.parseLong(patientId)).orElse(null);
                if (patient == null) {
                    redirectAttributes.addFlashAttribute("error", "Patient not found");
                    return "redirect:/receptionist/patients";
                }
            } else {
                // Create new patient
                patient = new Patient();
                // Generate a temporary national ID and password for new patients
                patient.setNationalId("TEMP_" + System.currentTimeMillis());
                patient.setPassword("temp123");
            }
            
            // Set patient data
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setDob(LocalDate.parse(dob));
            patient.setGender(gender);
            patient.setAddress(address);
            patient.setEmail(email != null ? email : "noemail@example.com");
            
            // Save patient
            patientService.savePatient(patient);
            
            redirectAttributes.addFlashAttribute("success", "Patient " + (isUpdate ? "updated" : "added") + " successfully!");
            return "redirect:/receptionist/patients";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error saving patient: " + e.getMessage());
            return "redirect:/receptionist/patients";
        }
    }
    
    @PostMapping("/deletePatient")
    public String processDeletePatient(@RequestParam String patientId,
                                     RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (patientId == null || patientId.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Invalid patient ID");
                return "redirect:/receptionist/patients";
            }
            
            // Delete patient from database
            patientService.deletePatient(Long.parseLong(patientId));
            
            redirectAttributes.addFlashAttribute("success", "Patient deleted successfully!");
            return "redirect:/receptionist/patients";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting patient: " + e.getMessage());
            return "redirect:/receptionist/patients";
        }
    }
    
    @GetMapping("/receptionist/doctors-availability")
    public String doctorAvailability(Model model) {
        try {
            // Load doctors from database
            List<Doctor> doctors = doctorService.getAllDoctors();
            
            // If no doctors exist, create some sample doctors
            if (doctors.isEmpty()) {
                createSampleDoctors();
                doctors = doctorService.getAllDoctors();
            }
            
            model.addAttribute("doctorsList", doctors);
            return "doctor_availability"; // Maps to doctor_availability.jsp
        } catch (Exception e) {
            model.addAttribute("doctorsList", List.of());
            return "doctor_availability";
        }
    }
    
    // Method to create sample doctors
    private void createSampleDoctors() {
        try {
            // Create sample doctors
            Doctor doctor1 = new Doctor(1001L, "Cardiology", true);
            Doctor doctor2 = new Doctor(1002L, "Neurology", true);
            Doctor doctor3 = new Doctor(1003L, "Orthopedics", true);
            Doctor doctor4 = new Doctor(1004L, "Pediatrics", true);
            Doctor doctor5 = new Doctor(1005L, "Dermatology", true);
            Doctor doctor6 = new Doctor(1006L, "General Medicine", true);
            
            // Save doctors to database
            doctorService.saveDoctor(doctor1);
            doctorService.saveDoctor(doctor2);
            doctorService.saveDoctor(doctor3);
            doctorService.saveDoctor(doctor4);
            doctorService.saveDoctor(doctor5);
            doctorService.saveDoctor(doctor6);
            
        } catch (Exception e) {
            // Log error but don't throw exception
            System.err.println("Error creating sample doctors: " + e.getMessage());
        }
    }
    
    @PostMapping("/checkAvailability")
    public String processCheckAvailability(@RequestParam String doctorId,
                                        @RequestParam String checkDate,
                                        Model model,
                                        RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (doctorId == null || doctorId.trim().isEmpty() ||
                checkDate == null || checkDate.trim().isEmpty()) {
                
                redirectAttributes.addFlashAttribute("error", "Please select both doctor and date");
                return "redirect:/receptionist/doctors-availability";
            }
            
            // Get doctor information
            Doctor doctor = doctorService.getDoctorById(Long.parseLong(doctorId)).orElse(null);
            if (doctor == null) {
                redirectAttributes.addFlashAttribute("error", "Doctor not found");
                return "redirect:/receptionist/doctors-availability";
            }
            
            // Parse the date
            LocalDate date = LocalDate.parse(checkDate);
            
            // Generate time slots for the doctor on the specified date
            List<TimeSlot> timeSlots = doctorService.generateTimeSlotsForDate(Long.parseLong(doctorId), date);
            
            // Create availability result object
            AvailabilityResult availabilityResult = new AvailabilityResult();
            availabilityResult.setDoctorName("Dr. " + doctor.getEid());
            availabilityResult.setDate(checkDate);
            availabilityResult.setSlots(convertTimeSlotsToSlotInfo(timeSlots));
            
            // Add data to model
            model.addAttribute("availabilityResult", availabilityResult);
            model.addAttribute("doctorsList", doctorService.getAllDoctors());
            
            return "doctor_availability";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error checking availability: " + e.getMessage());
            return "redirect:/receptionist/doctors-availability";
        }
    }
    
    // Helper method to convert TimeSlot entities to SlotInfo objects
    private List<SlotInfo> convertTimeSlotsToSlotInfo(List<TimeSlot> timeSlots) {
        List<SlotInfo> slotInfos = new ArrayList<>();
        for (TimeSlot timeSlot : timeSlots) {
            SlotInfo slotInfo = new SlotInfo();
            slotInfo.setTime(timeSlot.getTimeSlot().toString());
            slotInfo.setStatus(timeSlot.getIsAvailable() ? "available" : "booked");
            slotInfos.add(slotInfo);
        }
        return slotInfos;
    }
    
    // Inner classes for data transfer
    public static class AvailabilityResult {
        private String doctorName;
        private String date;
        private List<SlotInfo> slots;
        
        // Getters and setters
        public String getDoctorName() { return doctorName; }
        public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
        public String getDate() { return date; }
        public void setDate(String date) { this.date = date; }
        public List<SlotInfo> getSlots() { return slots; }
        public void setSlots(List<SlotInfo> slots) { this.slots = slots; }
    }
    
    public static class SlotInfo {
        private String time;
        private String status;
        
        // Getters and setters
        public String getTime() { return time; }
        public void setTime(String time) { this.time = time; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
    
    @PostMapping("/manageSchedule")
    public String processManageSchedule(@RequestParam String doctorId,
                                      @RequestParam(required = false) String monday_start,
                                      @RequestParam(required = false) String monday_end,
                                      @RequestParam(required = false) String leaveDate,
                                      @RequestParam(required = false) String leaveReason,
                                      RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (doctorId == null || doctorId.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Please select a doctor");
                return "redirect:/receptionist/doctors-availability";
            }
            
            Long doctorIdLong = Long.parseLong(doctorId);
            
            // Update Monday schedule if provided
            if (monday_start != null && monday_end != null && 
                !monday_start.trim().isEmpty() && !monday_end.trim().isEmpty()) {
                doctorService.updateDoctorWeeklySchedule(doctorIdLong, "MONDAY", monday_start, monday_end, true);
            }
            
            // Handle leave/unavailability if provided
            if (leaveDate != null && !leaveDate.trim().isEmpty()) {
                LocalDate leaveDateParsed = LocalDate.parse(leaveDate);
                // Mark the entire day as unavailable
                doctorService.updateDoctorWeeklySchedule(doctorIdLong, leaveDateParsed.getDayOfWeek().toString(), 
                    "00:00", "00:00", false);
            }
            
            redirectAttributes.addFlashAttribute("success", "Doctor schedule updated successfully!");
            return "redirect:/receptionist/doctors-availability";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating schedule: " + e.getMessage());
            return "redirect:/receptionist/doctors-availability";
        }
    }
    
    @PostMapping("/addDoctor")
    public String processAddDoctor(@RequestParam String eid,
                                 @RequestParam String specialization,
                                 @RequestParam(required = false) Boolean available,
                                 RedirectAttributes redirectAttributes) {
        try {
            // Basic validation
            if (eid == null || eid.trim().isEmpty() ||
                specialization == null || specialization.trim().isEmpty()) {
                
                redirectAttributes.addFlashAttribute("error", "Doctor ID and specialization are required");
                return "redirect:/receptionist/doctors-availability";
            }
            
            // Create new doctor
            Doctor doctor = new Doctor();
            doctor.setEid(Long.parseLong(eid));
            doctor.setSpecialization(specialization);
            doctor.setAvailable(available != null ? available : true);
            
            // Save doctor to database
            doctorService.saveDoctor(doctor);
            
            redirectAttributes.addFlashAttribute("success", "Doctor added successfully!");
            return "redirect:/receptionist/doctors-availability";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding doctor: " + e.getMessage());
            return "redirect:/receptionist/doctors-availability";
        }
    }
}
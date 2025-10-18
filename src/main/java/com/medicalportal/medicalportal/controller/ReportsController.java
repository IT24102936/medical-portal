package com.medicalportal.medicalportal.controller;

import com.medicalportal.medicalportal.service.AppointmentService;
import com.medicalportal.medicalportal.util.ExcelGeneratorUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/reports")
public class ReportsController {

    private final AppointmentService appointmentService;
    private final ExcelGeneratorUtil excelGeneratorUtil;

    public ReportsController(AppointmentService appointmentService, ExcelGeneratorUtil excelGeneratorUtil) {
        this.appointmentService = appointmentService;
        this.excelGeneratorUtil = excelGeneratorUtil;
    }

    @GetMapping("/appointments")
    public ResponseEntity<byte[]> generateAppointmentsReport(
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate) {
        
        try {
            List<Map<String, Object>> appointments;
            
            // If date range is provided, filter appointments
            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                // For now, we'll get all appointments and filter in memory
                // In a production environment, you would add a method to the repository to filter by date range
                appointments = appointmentService.getAllAppointments();
                appointments = filterAppointmentsByDateRange(appointments, startDate, endDate);
            } else {
                // Get all appointments
                appointments = appointmentService.getAllAppointments();
            }

            // Generate Excel file
            byte[] excelData = excelGeneratorUtil.generateAppointmentsExcel(appointments);

            // Set response headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            String filename = "appointments_report_" + LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + ".xlsx";
            headers.setContentDispositionFormData("attachment", filename);

            return new ResponseEntity<>(excelData, headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private List<Map<String, Object>> filterAppointmentsByDateRange(List<Map<String, Object>> appointments, String startDateStr, String endDateStr) {
        LocalDate startDate = LocalDate.parse(startDateStr);
        LocalDate endDate = LocalDate.parse(endDateStr);
        
        return appointments.stream()
                .filter(appointment -> {
                    String dateStr = (String) appointment.get("appointment_date");
                    if (dateStr == null || dateStr.isEmpty()) {
                        return false;
                    }
                    LocalDate appointmentDate = LocalDate.parse(dateStr);
                    return !appointmentDate.isBefore(startDate) && !appointmentDate.isAfter(endDate);
                })
                .toList();
    }
}
package com.medicalportal.medicalportal.repository.admin;

import com.medicalportal.medicalportal.entity.admin.Admin_Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Repository
public interface Admin_AppointmentRepository extends JpaRepository<Admin_Appointment, Integer> {

    // Get all appointments with doctor and patient details
    @Query(value = """
        SELECT a.appointment_id, a.appointment_time, a.status,
               CONCAT(e_doc.first_name, ' ', e_doc.last_name) as doctor_name,
               d.specialization as doctor_specialization,
               CONCAT(p.first_name, ' ', p.last_name) as patient_name,
               p.patient_id,
               e_doc.eid as doctor_eid
        FROM appointment a
        LEFT JOIN doctor_views_appointment dva ON a.appointment_id = dva.appointment_id
        LEFT JOIN doctor d ON dva.doctor_eid = d.eid
        LEFT JOIN employee e_doc ON d.eid = e_doc.eid
        LEFT JOIN patient_appointment_booking pab ON a.appointment_id = pab.appointment_id
        LEFT JOIN patient p ON pab.patient_id = p.patient_id
        ORDER BY a.appointment_time
        """, nativeQuery = true)
    List<Map<String, Object>> findAllAppointmentsWithDetails();

    // Get appointment counts by doctor specialization
    @Query(value = """
        SELECT d.specialization as specialization, COUNT(*) as count
        FROM appointment a
        LEFT JOIN doctor_views_appointment dva ON a.appointment_id = dva.appointment_id
        LEFT JOIN doctor d ON dva.doctor_eid = d.eid
        WHERE a.status != 'CANCELED'
        GROUP BY d.specialization
        ORDER BY count DESC
        """, nativeQuery = true)
    List<Map<String, Object>> findAppointmentCountsBySpecialization();

    // Get appointment counts by month for trends
    @Query(value = """
        SELECT DATE_FORMAT(a.appointment_time, '%Y-%m') as month, COUNT(*) as count
        FROM appointment a
        WHERE a.status != 'CANCELED'
        GROUP BY DATE_FORMAT(a.appointment_time, '%Y-%m')
        ORDER BY month
        LIMIT 12
        """, nativeQuery = true)
    List<Map<String, Object>> findAppointmentCountsByMonth();

    // Get upcoming appointments (future dates)
    @Query(value = """
        SELECT a.appointment_id, a.appointment_time, a.status,
               CONCAT(e_doc.first_name, ' ', e_doc.last_name) as doctor_name,
               d.specialization as doctor_specialization,
               CONCAT(p.first_name, ' ', p.last_name) as patient_name,
               p.patient_id,
               e_doc.eid as doctor_eid
        FROM appointment a
        LEFT JOIN doctor_views_appointment dva ON a.appointment_id = dva.appointment_id
        LEFT JOIN doctor d ON dva.doctor_eid = d.eid
        LEFT JOIN employee e_doc ON d.eid = e_doc.eid
        LEFT JOIN patient_appointment_booking pab ON a.appointment_id = pab.appointment_id
        LEFT JOIN patient p ON pab.patient_id = p.patient_id
        WHERE a.appointment_time >= NOW() AND a.status != 'CANCELED'
        ORDER BY a.appointment_time
        """, nativeQuery = true)
    List<Map<String, Object>> findUpcomingAppointments();

    // Get today's appointments
    @Query(value = """
        SELECT a.appointment_id, a.appointment_time, a.status,
               CONCAT(e_doc.first_name, ' ', e_doc.last_name) as doctor_name,
               d.specialization as doctor_specialization,
               CONCAT(p.first_name, ' ', p.last_name) as patient_name,
               p.patient_id,
               e_doc.eid as doctor_eid
        FROM appointment a
        LEFT JOIN doctor_views_appointment dva ON a.appointment_id = dva.appointment_id
        LEFT JOIN doctor d ON dva.doctor_eid = d.eid
        LEFT JOIN employee e_doc ON d.eid = e_doc.eid
        LEFT JOIN patient_appointment_booking pab ON a.appointment_id = pab.appointment_id
        LEFT JOIN patient p ON pab.patient_id = p.patient_id
        WHERE DATE(a.appointment_time) = CURDATE() AND a.status != 'CANCELED'
        ORDER BY a.appointment_time
        """, nativeQuery = true)
    List<Map<String, Object>> findTodaysAppointments();

    // Get past appointments
    @Query(value = """
        SELECT a.appointment_id, a.appointment_time, a.status,
               CONCAT(e_doc.first_name, ' ', e_doc.last_name) as doctor_name,
               d.specialization as doctor_specialization,
               CONCAT(p.first_name, ' ', p.last_name) as patient_name,
               p.patient_id,
               e_doc.eid as doctor_eid
        FROM appointment a
        LEFT JOIN doctor_views_appointment dva ON a.appointment_id = dva.appointment_id
        LEFT JOIN doctor d ON dva.doctor_eid = d.eid
        LEFT JOIN employee e_doc ON d.eid = e_doc.eid
        LEFT JOIN patient_appointment_booking pab ON a.appointment_id = pab.appointment_id
        LEFT JOIN patient p ON pab.patient_id = p.patient_id
        WHERE a.appointment_time < NOW() AND a.status != 'CANCELED'
        ORDER BY a.appointment_time DESC
        """, nativeQuery = true)
    List<Map<String, Object>> findPastAppointments();

    // Get canceled appointments
    @Query(value = """
        SELECT a.appointment_id, a.appointment_time, a.status,
               CONCAT(e_doc.first_name, ' ', e_doc.last_name) as doctor_name,
               d.specialization as doctor_specialization,
               CONCAT(p.first_name, ' ', p.last_name) as patient_name,
               p.patient_id,
               e_doc.eid as doctor_eid
        FROM appointment a
        LEFT JOIN doctor_views_appointment dva ON a.appointment_id = dva.appointment_id
        LEFT JOIN doctor d ON dva.doctor_eid = d.eid
        LEFT JOIN employee e_doc ON d.eid = e_doc.eid
        LEFT JOIN patient_appointment_booking pab ON a.appointment_id = pab.appointment_id
        LEFT JOIN patient p ON pab.patient_id = p.patient_id
        WHERE a.status = 'CANCELED'
        ORDER BY a.appointment_time DESC
        """, nativeQuery = true)
    List<Map<String, Object>> findCanceledAppointments();

    // Cancel appointment
    @Modifying
    @Transactional
    @Query(value = "UPDATE appointment SET status = 'CANCELED' WHERE appointment_id = :appointmentId", nativeQuery = true)
    void cancelAppointment(@Param("appointmentId") Integer appointmentId);

    // Delete appointment
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM appointment WHERE appointment_id = :appointmentId", nativeQuery = true)
    void deleteAppointment(@Param("appointmentId") Integer appointmentId);

    // Create new appointment
    @Modifying
    @Transactional
    @Query(value = """
        INSERT INTO appointment (appointment_id, appointment_time, status, receptionist_eid)
        VALUES (:appointmentId, :appointmentTime, :status, :receptionistEid)
        """, nativeQuery = true)
    void insertAppointment(@Param("appointmentId") Integer appointmentId,
                           @Param("appointmentTime") LocalDateTime appointmentTime,
                           @Param("status") String status,
                           @Param("receptionistEid") Integer receptionistEid);

    // Get next available appointment ID
    @Query(value = "SELECT COALESCE(MAX(appointment_id), 0) + 1 FROM appointment", nativeQuery = true)
    Integer getNextAppointmentId();

    // Link appointment to doctor
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO doctor_views_appointment (doctor_eid, appointment_id) VALUES (:doctorEid, :appointmentId)", nativeQuery = true)
    void linkAppointmentToDoctor(@Param("doctorEid") Integer doctorEid, @Param("appointmentId") Integer appointmentId);

    // Link appointment to patient
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO patient_appointment_booking (patient_id, appointment_id) VALUES (:patientId, :appointmentId)", nativeQuery = true)
    void linkAppointmentToPatient(@Param("patientId") Integer patientId, @Param("appointmentId") Integer appointmentId);

    // Delete appointment links when deleting appointment
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_views_appointment WHERE appointment_id = :appointmentId", nativeQuery = true)
    void deleteAppointmentDoctorLink(@Param("appointmentId") Integer appointmentId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM patient_appointment_booking WHERE appointment_id = :appointmentId", nativeQuery = true)
    void deleteAppointmentPatientLink(@Param("appointmentId") Integer appointmentId);
}

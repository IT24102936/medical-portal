package com.medicalportal.medicalportal.repository.admin;

import com.medicalportal.medicalportal.entity.admin.Admin_Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface Admin_DoctorRepository extends JpaRepository<Admin_Doctor, Integer> {
    @Query(value = "SELECT d.* FROM doctor d JOIN employee e ON e.eid = d.eid", nativeQuery = true)
    List<Admin_Doctor> findAll();

    @Query(value = "SELECT d.* FROM doctor d JOIN employee e ON e.eid = d.eid WHERE d.eid = :eid", nativeQuery = true)
    Optional<Admin_Doctor> findById(@Param("eid") Integer eid);

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM doctor d WHERE d.eid = :eid", nativeQuery = true)
    boolean existsById(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "UPDATE employee e SET e.status = 'DISABLED' WHERE e.eid = :eid", nativeQuery = true)
    void disableDoctor(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "UPDATE employee e SET e.status = 'ACTIVE' WHERE e.eid = :eid", nativeQuery = true)
    void enableDoctor(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "UPDATE employee e JOIN doctor d ON e.eid = d.eid SET " +
            "e.first_name = :firstName, " +
            "e.last_name = :lastName, " +
            "e.email = :email, " +
            "e.gender = :gender, " +
            "e.dob = :dob, " +
            "e.salary = :salary, " +
            "e.national_id = :nationalId, " +
            "e.user_name = :userName, " +
            "e.status = :status, " +
            "d.specialization = :specialization " +
            "WHERE e.eid = :eid", nativeQuery = true)
    void editDoctor(@Param("eid") Integer eid, @Param("firstName") String firstName,
                    @Param("lastName") String lastName, @Param("email") String email,
                    @Param("gender") String gender, @Param("dob") LocalDate dob,
                    @Param("salary") BigDecimal salary, @Param("nationalId") String nationalId,
                    @Param("userName") String userName, @Param("status") String status,
                    @Param("specialization") String specialization);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO employee (eid, first_name, last_name, email, gender, dob, salary, national_id, user_name, status, password) " +
            "VALUES (:eid, :firstName, :lastName, :email, :gender, :dob, :salary, :nationalId, :userName, :status, :password)", nativeQuery = true)
    void insertEmployee(@Param("eid") Integer eid, @Param("firstName") String firstName,
                        @Param("lastName") String lastName, @Param("email") String email,
                        @Param("gender") String gender, @Param("dob") LocalDate dob,
                        @Param("salary") BigDecimal salary, @Param("nationalId") String nationalId,
                        @Param("userName") String userName, @Param("status") String status,
                        @Param("password") String password);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO doctor (eid, specialization) VALUES (:eid, :specialization)", nativeQuery = true)
    void insertDoctor(@Param("eid") Integer eid, @Param("specialization") String specialization);

    // Delete methods for doctor removal - must be called in correct order due to foreign key constraints
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_patient_checkup WHERE doctor_eid = :eid", nativeQuery = true)
    void deleteDoctorPatientCheckup(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_issues_prescription WHERE doctor_eid = :eid", nativeQuery = true)
    void deleteDoctorIssuesPrescription(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_issues_lab_order WHERE doctor_eid = :eid", nativeQuery = true)
    void deleteDoctorIssuesLabOrder(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_views_appointment WHERE doctor_eid = :eid", nativeQuery = true)
    void deleteDoctorViewsAppointment(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor_views_report WHERE doctor_eid = :eid", nativeQuery = true)
    void deleteDoctorViewsReport(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM doctor WHERE eid = :eid", nativeQuery = true)
    void deleteDoctorRecord(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM employee_phone WHERE eid = :eid", nativeQuery = true)
    void deleteEmployeePhones(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM employee WHERE eid = :eid", nativeQuery = true)
    void deleteEmployeeRecord(@Param("eid") Integer eid);

    @Query(value = "SELECT p.phone_number FROM employee_phone p WHERE p.eid = :eid", nativeQuery = true)
    List<String> findPhoneNumbersByEid(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM employee_phone WHERE eid = :eid", nativeQuery = true)
    void deletePhoneNumbersByEid(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO employee_phone (eid, phone_number) VALUES (:eid, :phoneNumber)", nativeQuery = true)
    void insertPhoneNumber(@Param("eid") Integer eid, @Param("phoneNumber") String phoneNumber);

    @Modifying
    @Transactional
    @Query(value = "UPDATE employee SET password = :password WHERE eid = :eid", nativeQuery = true)
    void updateEmployeePassword(@Param("eid") Integer eid, @Param("password") String password);

    @Query(value = "SELECT COALESCE(MAX(eid), 0) + 1 FROM employee", nativeQuery = true)
    Integer getNextEmployeeId();
    
    // Check if username is already taken
    @Query(value = "SELECT COUNT(*) FROM employee WHERE user_name = :userName", nativeQuery = true)
    int countByUserName(@Param("userName") String userName);
    
    // Check if email is already taken
    @Query(value = "SELECT COUNT(*) FROM employee WHERE email = :email", nativeQuery = true)
    int countByEmail(@Param("email") String email);
    
    // Check if username is already taken by another doctor (for updates)
    @Query(value = "SELECT COUNT(*) FROM employee WHERE user_name = :userName AND eid != :eid", nativeQuery = true)
    int countByUserNameAndEidNot(@Param("userName") String userName, @Param("eid") Integer eid);
    
    // Check if email is already taken by another doctor (for updates)
    @Query(value = "SELECT COUNT(*) FROM employee WHERE email = :email AND eid != :eid", nativeQuery = true)
    int countByEmailAndEidNot(@Param("email") String email, @Param("eid") Integer eid);
    
    // Helper methods to check existence
    default boolean existsByUserName(String userName) {
        return countByUserName(userName) > 0;
    }
    
    default boolean existsByEmail(String email) {
        return countByEmail(email) > 0;
    }
    
    default boolean existsByUserNameAndEidNot(String userName, Integer eid) {
        return countByUserNameAndEidNot(userName, eid) > 0;
    }
    
    default boolean existsByEmailAndEidNot(String email, Integer eid) {
        return countByEmailAndEidNot(email, eid) > 0;
    }
}

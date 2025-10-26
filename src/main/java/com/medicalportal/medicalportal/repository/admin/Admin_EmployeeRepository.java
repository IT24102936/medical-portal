package com.medicalportal.medicalportal.repository.admin;

import com.medicalportal.medicalportal.entity.admin.Admin_Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public interface Admin_EmployeeRepository extends JpaRepository<Admin_Employee, Integer> {
    
    // Get all employees excluding doctors and admins, with their roles
    @Query(value = """
        SELECT e.eid, e.first_name, e.last_name, e.email, e.gender, e.dob, 
               e.salary, e.national_id, e.user_name, e.status,
               CASE 
                   WHEN r.eid IS NOT NULL THEN 'Receptionist'
                   WHEN lt.eid IS NOT NULL THEN 'Lab Technician'
                   WHEN p.eid IS NOT NULL THEN 'Pharmacist'
                   WHEN fa.eid IS NOT NULL THEN 'Finance Admin'
                   ELSE 'Employee'
               END as role
        FROM employee e
        LEFT JOIN receptionist r ON e.eid = r.eid
        LEFT JOIN lab_technician lt ON e.eid = lt.eid
        LEFT JOIN pharmacist p ON e.eid = p.eid
        LEFT JOIN finance_admin fa ON e.eid = fa.eid
        WHERE NOT EXISTS (SELECT 1 FROM doctor d WHERE d.eid = e.eid)
        AND NOT EXISTS (SELECT 1 FROM admin a WHERE a.eid = e.eid)
        ORDER BY e.first_name, e.last_name
        """, nativeQuery = true)
    List<Map<String, Object>> findAllEmployeesExcludingDoctorsAndAdmins();

    // Get employee by ID excluding doctors and admins
    @Query(value = """
        SELECT e.eid, e.first_name, e.last_name, e.email, e.gender, e.dob, 
               e.salary, e.national_id, e.user_name, e.status,
               CASE 
                   WHEN r.eid IS NOT NULL THEN 'Receptionist'
                   WHEN lt.eid IS NOT NULL THEN 'Lab Technician'
                   WHEN p.eid IS NOT NULL THEN 'Pharmacist'
                   WHEN fa.eid IS NOT NULL THEN 'Finance Admin'
                   ELSE 'Employee'
               END as role
        FROM employee e
        LEFT JOIN receptionist r ON e.eid = r.eid
        LEFT JOIN lab_technician lt ON e.eid = lt.eid
        LEFT JOIN pharmacist p ON e.eid = p.eid
        LEFT JOIN finance_admin fa ON e.eid = fa.eid
        WHERE e.eid = :eid
        AND NOT EXISTS (SELECT 1 FROM doctor d WHERE d.eid = e.eid)
        AND NOT EXISTS (SELECT 1 FROM admin a WHERE a.eid = e.eid)
        """, nativeQuery = true)
    Optional<Map<String, Object>> findEmployeeByIdExcludingDoctorsAndAdmins(@Param("eid") Integer eid);

    // Update employee information
    @Modifying
    @Transactional
    @Query(value = """
        UPDATE employee SET 
            first_name = :firstName, 
            last_name = :lastName, 
            email = :email, 
            gender = :gender, 
            dob = :dob, 
            salary = :salary, 
            national_id = :nationalId, 
            user_name = :userName, 
            status = :status
        WHERE eid = :eid
        """, nativeQuery = true)
    void updateEmployee(@Param("eid") Integer eid, @Param("firstName") String firstName,
                       @Param("lastName") String lastName, @Param("email") String email,
                       @Param("gender") String gender, @Param("dob") LocalDate dob,
                       @Param("salary") BigDecimal salary, @Param("nationalId") String nationalId,
                       @Param("userName") String userName, @Param("status") String status);

    // Insert new employee
    @Modifying
    @Transactional
    @Query(value = """
        INSERT INTO employee (eid, first_name, last_name, email, gender, dob, salary, 
                             national_id, user_name, status, password) 
        VALUES (:eid, :firstName, :lastName, :email, :gender, :dob, :salary, 
                :nationalId, :userName, :status, :password)
        """, nativeQuery = true)
    void insertEmployee(@Param("eid") Integer eid, @Param("firstName") String firstName,
                       @Param("lastName") String lastName, @Param("email") String email,
                       @Param("gender") String gender, @Param("dob") LocalDate dob,
                       @Param("salary") BigDecimal salary, @Param("nationalId") String nationalId,
                       @Param("userName") String userName, @Param("status") String status,
                       @Param("password") String password);

    // Insert role-specific records
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO receptionist (eid) VALUES (:eid)", nativeQuery = true)
    void insertReceptionist(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO lab_technician (eid) VALUES (:eid)", nativeQuery = true)
    void insertLabTechnician(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO pharmacist (eid) VALUES (:eid)", nativeQuery = true)
    void insertPharmacist(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO finance_admin (eid) VALUES (:eid)", nativeQuery = true)
    void insertFinanceAdmin(@Param("eid") Integer eid);

    // Delete role-specific records
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM receptionist WHERE eid = :eid", nativeQuery = true)
    void deleteReceptionist(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM lab_technician WHERE eid = :eid", nativeQuery = true)
    void deleteLabTechnician(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM pharmacist WHERE eid = :eid", nativeQuery = true)
    void deletePharmacist(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM finance_admin WHERE eid = :eid", nativeQuery = true)
    void deleteFinanceAdmin(@Param("eid") Integer eid);

    // Phone number operations
    @Query(value = "SELECT phone_number FROM employee_phone WHERE eid = :eid", nativeQuery = true)
    List<String> findPhoneNumbersByEid(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM employee_phone WHERE eid = :eid", nativeQuery = true)
    void deletePhoneNumbersByEid(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO employee_phone (eid, phone_number) VALUES (:eid, :phoneNumber)", nativeQuery = true)
    void insertPhoneNumber(@Param("eid") Integer eid, @Param("phoneNumber") String phoneNumber);

    // Status operations
    @Modifying
    @Transactional
    @Query(value = "UPDATE employee SET status = 'DISABLED' WHERE eid = :eid", nativeQuery = true)
    void disableEmployee(@Param("eid") Integer eid);

    @Modifying
    @Transactional
    @Query(value = "UPDATE employee SET status = 'ACTIVE' WHERE eid = :eid", nativeQuery = true)
    void enableEmployee(@Param("eid") Integer eid);

    // Password update
    @Modifying
    @Transactional
    @Query(value = "UPDATE employee SET password = :password WHERE eid = :eid", nativeQuery = true)
    void updateEmployeePassword(@Param("eid") Integer eid, @Param("password") String password);

    // Delete employee (will be used for complete deletion)
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM employee WHERE eid = :eid", nativeQuery = true)
    void deleteEmployeeRecord(@Param("eid") Integer eid);

    // Get next employee ID
    @Query(value = "SELECT COALESCE(MAX(eid), 0) + 1 FROM employee", nativeQuery = true)
    Integer getNextEmployeeId();

    // Check what role an employee has
    @Query(value = """
        SELECT 
            CASE 
                WHEN EXISTS(SELECT 1 FROM receptionist WHERE eid = :eid) THEN 'Receptionist'
                WHEN EXISTS(SELECT 1 FROM lab_technician WHERE eid = :eid) THEN 'Lab Technician'
                WHEN EXISTS(SELECT 1 FROM pharmacist WHERE eid = :eid) THEN 'Pharmacist'
                WHEN EXISTS(SELECT 1 FROM finance_admin WHERE eid = :eid) THEN 'Finance Admin'
                ELSE 'Employee'
            END as role
        """, nativeQuery = true)
    String getEmployeeRole(@Param("eid") Integer eid);
    
    // Check if username is already taken
    @Query(value = "SELECT COUNT(*) FROM employee WHERE user_name = :userName", nativeQuery = true)
    int countByUserName(@Param("userName") String userName);
    
    // Check if email is already taken
    @Query(value = "SELECT COUNT(*) FROM employee WHERE email = :email", nativeQuery = true)
    int countByEmail(@Param("email") String email);
    
    // Check if username is already taken by another employee (for updates)
    @Query(value = "SELECT COUNT(*) FROM employee WHERE user_name = :userName AND eid != :eid", nativeQuery = true)
    int countByUserNameAndEidNot(@Param("userName") String userName, @Param("eid") Integer eid);
    
    // Check if email is already taken by another employee (for updates)
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
    
    // Add method to find employee by email
    @Query("SELECT e FROM Admin_Employee e WHERE e.email = :email")
    Admin_Employee findByEmail(@Param("email") String email);
    
    // Check if employee is an admin
    @Query(value = "SELECT COUNT(*) FROM admin WHERE eid = :eid", nativeQuery = true)
    int countAdminsByEid(@Param("eid") Integer eid);
    
    // Check if employee is a doctor
    @Query(value = "SELECT COUNT(*) FROM doctor WHERE eid = :eid", nativeQuery = true)
    int countDoctorsByEid(@Param("eid") Integer eid);
    
    // Check if employee is a lab technician
    @Query(value = "SELECT COUNT(*) FROM lab_technician WHERE eid = :eid", nativeQuery = true)
    int countLabTechniciansByEid(@Param("eid") Integer eid);
    
    // Check if employee is a pharmacist
    @Query(value = "SELECT COUNT(*) FROM pharmacist WHERE eid = :eid", nativeQuery = true)
    int countPharmacistsByEid(@Param("eid") Integer eid);
    
    // Check if employee is a receptionist
    @Query(value = "SELECT COUNT(*) FROM receptionist WHERE eid = :eid", nativeQuery = true)
    int countReceptionistsByEid(@Param("eid") Integer eid);
    
    // Check if employee is a finance admin
    @Query(value = "SELECT COUNT(*) FROM finance_admin WHERE eid = :eid", nativeQuery = true)
    int countFinanceAdminsByEid(@Param("eid") Integer eid);
    
    // Helper methods
    default boolean isAdmin(Integer eid) {
        return countAdminsByEid(eid) > 0;
    }
    
    default boolean isDoctor(Integer eid) {
        return countDoctorsByEid(eid) > 0;
    }
    
    default boolean isLabTechnician(Integer eid) {
        return countLabTechniciansByEid(eid) > 0;
    }
    
    default boolean isPharmacist(Integer eid) {
        return countPharmacistsByEid(eid) > 0;
    }
    
    default boolean isReceptionist(Integer eid) {
        return countReceptionistsByEid(eid) > 0;
    }
    
    default boolean isFinanceAdmin(Integer eid) {
        return countFinanceAdminsByEid(eid) > 0;
    }
}

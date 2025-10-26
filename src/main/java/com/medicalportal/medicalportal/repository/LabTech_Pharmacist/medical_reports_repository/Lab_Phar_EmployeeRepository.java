package com.medicalportal.medicalportal.repository.LabTech_Pharmacist.medical_reports_repository;

import com.medicalportal.medicalportal.entity.LabTech_Pharmacist.medical_report_entities.Lab_Phar_Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface Lab_Phar_EmployeeRepository extends JpaRepository<Lab_Phar_Employee, Integer> {
    
    // Authentication queries
    @Query("SELECT e FROM Lab_Phar_Employee e WHERE e.userName = :userName")
    Optional<Lab_Phar_Employee> findByUserName(@Param("userName") String userName);
    
    @Query("SELECT e FROM Lab_Phar_Employee e WHERE e.email = :email")
    Optional<Lab_Phar_Employee> findByEmail(@Param("email") String email);
    
    @Query("SELECT e FROM Lab_Phar_Employee e WHERE e.nationalId = :nationalId")
    Optional<Lab_Phar_Employee> findByNationalId(@Param("nationalId") String nationalId);
    
    @Query("SELECT e FROM Lab_Phar_Employee e WHERE e.userName = :userName AND e.password = :password")
    Optional<Lab_Phar_Employee> findByUserNameAndPassword(@Param("userName") String userName, @Param("password") String password);
    
    @Query("SELECT e FROM Lab_Phar_Employee e WHERE e.email = :email AND e.password = :password")
    Optional<Lab_Phar_Employee> findByEmailAndPassword(@Param("email") String email, @Param("password") String password);
    
    // Check if username exists
    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END FROM Lab_Phar_Employee e WHERE e.userName = :userName")
    boolean existsByUserName(@Param("userName") String userName);
    
    // Check if email exists
    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END FROM Lab_Phar_Employee e WHERE e.email = :email")
    boolean existsByEmail(@Param("email") String email);
    
    // Check if national ID exists
    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END FROM Lab_Phar_Employee e WHERE e.nationalId = :nationalId")
    boolean existsByNationalId(@Param("nationalId") String nationalId);
    
    // Find all employees
    @Query("SELECT e FROM Lab_Phar_Employee e ORDER BY e.id")
    List<Lab_Phar_Employee> findAll();
    
    // Find employee by ID
    @Query("SELECT e FROM Lab_Phar_Employee e WHERE e.id = :id")
    Optional<Lab_Phar_Employee> findById(@Param("id") Integer id);
}
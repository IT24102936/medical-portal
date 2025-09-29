package com.medicalportal.medicalportal.repository;

import com.medicalportal.medicalportal.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.math.BigDecimal;
import java.time.LocalDate;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    
    // Authentication queries
    @Query("SELECT e FROM Employee e WHERE e.userName = :userName")
    Optional<Employee> findByUserName(@Param("userName") String userName);
    
    @Query("SELECT e FROM Employee e WHERE e.email = :email")
    Optional<Employee> findByEmail(@Param("email") String email);
    
    @Query("SELECT e FROM Employee e WHERE e.nationalId = :nationalId")
    Optional<Employee> findByNationalId(@Param("nationalId") String nationalId);
    
    @Query("SELECT e FROM Employee e WHERE e.userName = :userName AND e.password = :password")
    Optional<Employee> findByUserNameAndPassword(@Param("userName") String userName, @Param("password") String password);
    
    @Query("SELECT e FROM Employee e WHERE e.email = :email AND e.password = :password")
    Optional<Employee> findByEmailAndPassword(@Param("email") String email, @Param("password") String password);
    
    // Check if username exists
    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END FROM Employee e WHERE e.userName = :userName")
    boolean existsByUserName(@Param("userName") String userName);
    
    // Check if email exists
    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END FROM Employee e WHERE e.email = :email")
    boolean existsByEmail(@Param("email") String email);
    
    // Check if national ID exists
    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END FROM Employee e WHERE e.nationalId = :nationalId")
    boolean existsByNationalId(@Param("nationalId") String nationalId);
    
    // Find all employees
    @Query("SELECT e FROM Employee e ORDER BY e.id")
    List<Employee> findAll();
    
    // Find employee by ID
    @Query("SELECT e FROM Employee e WHERE e.id = :id")
    Optional<Employee> findById(@Param("id") Integer id);
}
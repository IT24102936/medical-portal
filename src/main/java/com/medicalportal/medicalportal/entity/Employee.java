package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "employee")
public class Employee {
    @Id
    @Column(name = "eid")
    private Integer eid;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "national_id")
    private String nationalId;

    @Column(name = "gender")
    private String gender;

    @Column(name = "dob")
    private LocalDate dob;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "user_name")
    private String userName;

    @Column(name = "salary")
    private BigDecimal salary;

    @Column(name = "status")
    private String status;

    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<EmployeePhone> phones;

    // Getters and setters
    public Integer getEid() { return eid; }
    public void setEid(Integer eid) { this.eid = eid; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getNationalId() { return nationalId; }
    public void setNationalId(String nationalId) { this.nationalId = nationalId; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public BigDecimal getSalary() { return salary; }
    public void setSalary(BigDecimal salary) { this.salary = salary; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public List<EmployeePhone> getPhones() { return phones; }
    public void setPhones(List<EmployeePhone> phones) { this.phones = phones; }

    // Helper method for first phone number
    public String getFirstPhoneNumber() {
        return phones != null && !phones.isEmpty() ? phones.get(0).getPhoneNumber() : "";
    }
}

@Entity
@Table(name = "employee_phone")
class EmployeePhone {
    @EmbeddedId
    private EmployeePhoneId id;

    @ManyToOne
    @MapsId("eid")
    @JoinColumn(name = "eid")
    private Employee employee;

    @Column(name = "phone_number", insertable = false, updatable = false)
    private String phoneNumber;

    // Getters and setters
    public EmployeePhoneId getId() { return id; }
    public void setId(EmployeePhoneId id) { this.id = id; }
    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
}

@Embeddable
class EmployeePhoneId implements Serializable {
    private static final long serialVersionUID = 1L;

    @Column(name = "eid")
    private Integer eid;

    @Column(name = "phone_number")
    private String phoneNumber;

    // Default constructor
    public EmployeePhoneId() {}

    // Parameterized constructor
    public EmployeePhoneId(Integer eid, String phoneNumber) {
        this.eid = eid;
        this.phoneNumber = phoneNumber;
    }

    // Getters, setters, equals, and hashCode
    public Integer getEid() { return eid; }
    public void setEid(Integer eid) { this.eid = eid; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EmployeePhoneId that = (EmployeePhoneId) o;
        return Objects.equals(eid, that.eid) && Objects.equals(phoneNumber, that.phoneNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eid, phoneNumber);
    }
}
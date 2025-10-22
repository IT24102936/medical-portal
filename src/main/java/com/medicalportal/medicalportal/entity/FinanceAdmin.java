package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "finance_admin")
@PrimaryKeyJoinColumn(name = "eid")
public class FinanceAdmin extends Employee {
    // Finance admin specific fields can be added here
}

package com.medicalportal.medicalportal.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "medical_report")
public class MedicalReport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "report_id", nullable = false)
    private Integer id;

    @Column(name = "report_date", nullable = false)
    private LocalDate reportDate;

    @Column(name = "report_type", length = 100)
    private String reportType;

    @Column(name = "document_path")
    private String documentPath;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDate getReportDate() {
        return reportDate;
    }

    public void setReportDate(LocalDate reportDate) {
        this.reportDate = reportDate;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public String getDocumentPath() {
        return documentPath;
    }

    public void setDocumentPath(String documentPath) {
        this.documentPath = documentPath;
    }

}
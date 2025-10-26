<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescription Details - Medisphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 100%);
            min-height: 100vh;
        }
        .prescription-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            padding: 2rem;
        }
        .header-section {
            border-bottom: 3px solid #13a4ec;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
        .info-row {
            padding: 0.75rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-label {
            font-weight: 600;
            color: #0d171b;
            min-width: 150px;
        }
        .info-value {
            color: #6c757d;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="shadow-sm sticky-top bg-white">
        <nav class="navbar navbar-expand-lg bg-white py-2 px-3 px-lg-5">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="/pharmacist">
                    <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 50px;" class="me-2">
                    <div>
                        <h2 class="mb-0 fs-3" style="color: #0d171b;">Medisphere</h2>
                        <small class="text-muted">Pharmacist Portal</small>
                    </div>
                </a>
                <a href="/pharmacist" class="btn btn-outline-primary">
                    <span class="material-symbols-outlined me-2" style="font-size: 20px; vertical-align: middle;">arrow_back</span>
                    Back to Dashboard
                </a>
            </div>
        </nav>
    </header>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Flash Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="prescription-card">
                    <div class="header-section">
                        <h2 class="mb-2">
                            <span class="material-symbols-outlined" style="font-size: 2rem; vertical-align: middle; color: #13a4ec;">receipt_long</span>
                            Prescription Details
                        </h2>
                        <p class="text-muted mb-0">Complete prescription information and history</p>
                    </div>

                    <!-- Prescription Information -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3" style="color: #13a4ec;">📋 Basic Information</h5>
                            
                            <div class="info-row">
                                <div class="row">
                                    <div class="col-md-4 info-label">Prescription ID:</div>
                                    <div class="col-md-8 info-value">#RX${prescription.id}</div>
                                </div>
                            </div>
                            
                            <div class="info-row">
                                <div class="row">
                                    <div class="col-md-4 info-label">Issue Date:</div>
                                    <div class="col-md-8 info-value">
                                        <c:choose>
                                            <c:when test="${not empty prescriptionDetails}">
                                                ${prescriptionDetails.issueDate}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Doctor Information -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3" style="color: #13a4ec;">👨‍⚕️ Doctor Information</h5>
                            
                            <div class="info-row">
                                <div class="row">
                                    <div class="col-md-4 info-label">Doctor ID:</div>
                                    <div class="col-md-8 info-value">
                                        <c:choose>
                                            <c:when test="${not empty prescriptionDetails}">
                                                Dr. ID: ${prescriptionDetails.doctorEid.id}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="info-row">
                                <div class="row">
                                    <div class="col-md-4 info-label">Specialization:</div>
                                    <div class="col-md-8 info-value">
                                        <c:choose>
                                            <c:when test="${not empty prescriptionDetails}">
                                                ${prescriptionDetails.doctorEid.specialization}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Patient Information -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3" style="color: #13a4ec;">🧑‍🤝‍🧑 Patient Information</h5>
                            
                            <div class="info-row">
                                <div class="row">
                                    <div class="col-md-4 info-label">Patient ID:</div>
                                    <div class="col-md-8 info-value">
                                        <c:choose>
                                            <c:when test="${not empty prescriptionDetails}">
                                                ${prescriptionDetails.patient.id}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="info-row">
                                <div class="row">
                                    <div class="col-md-4 info-label">Patient Name:</div>
                                    <div class="col-md-8 info-value">
                                        <c:choose>
                                            <c:when test="${not empty prescriptionDetails}">
                                                ${prescriptionDetails.patient.firstName} ${prescriptionDetails.patient.lastName}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Prescription Description -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3" style="color: #13a4ec;">💊 Prescription Description</h5>
                            <div class="p-3" style="background-color: #f8f9fa; border-radius: 10px; border-left: 4px solid #13a4ec;">
                                <p class="mb-0" style="white-space: pre-wrap;">${prescription.description}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="d-flex justify-content-between">
                                <a href="/pharmacist" class="btn btn-secondary">
                                    <span class="material-symbols-outlined me-2" style="font-size: 18px; vertical-align: middle;">arrow_back</span>
                                    Back to Dashboard
                                </a>
                                <div>
                                    <a href="/pharmacist/prescription/edit/${prescription.id}" class="btn btn-warning me-2">
                                        <span class="material-symbols-outlined me-1" style="font-size: 18px; vertical-align: middle;">edit</span>
                                        Edit
                                    </a>
                                    <form method="post" action="/pharmacist/prescription/delete/${prescription.id}" style="display: inline;" 
                                          onsubmit="return confirm('Are you sure you want to delete this prescription? This action cannot be undone.');">
                                        <button type="submit" class="btn btn-danger">
                                            <span class="material-symbols-outlined me-1" style="font-size: 18px; vertical-align: middle;">delete</span>
                                            Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);
    </script>
</body>
</html>

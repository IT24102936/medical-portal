<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/28/2025
  Time: 11:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Prescription - Medisphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/DoctorStyle.css">
</head>
<body>
<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="medical-container">
                <!-- Header -->
                <div class="medical-header">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h1 class="h3 mb-0">
                                <i class="fas fa-heartbeat me-2"></i>Medisphere
                            </h1>
                            <p class="mb-0">Create New Prescription</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="d-flex align-items-center justify-content-end">
                                <div class="me-3">
                                    <span class="fw-bold">Dr. ${doctor.firstName} ${doctor.lastName}</span>
                                    <br>
                                    <small class="text-light">${doctor.specialization}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-0">
                    <!-- Sidebar -->
                    <div class="col-md-3 medical-sidebar">
                        <nav class="nav flex-column">
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile">
                                <i class="fas fa-user me-2"></i>My Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/appointments">
                                <i class="fas fa-calendar-check me-2"></i>Appointments
                            </a>
                            <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                                <i class="fas fa-prescription me-2"></i>Prescriptions
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/edit-profile">
                                <i class="fas fa-edit me-2"></i>Edit Profile
                            </a>
                        </nav>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9 medical-content">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2>
                                <i class="fas fa-prescription me-2"></i>Create New Prescription
                            </h2>
                            <a href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions"
                               class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Prescriptions
                            </a>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="card">
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions/create">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="patientId" class="form-label">Patient ID *</label>
                                            <input type="number" class="form-control" id="patientId" name="patientId"
                                                   required min="1" placeholder="Enter patient ID">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="patientName" class="form-label">Patient Name *</label>
                                            <input type="text" class="form-control" id="patientName" name="patientName"
                                                   required placeholder="Enter patient full name">
                                        </div>

                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Prescription Description *</label>
                                        <textarea class="form-control" id="description" name="description"
                                                  rows="6" required
                                                  placeholder="Enter prescription details including medicines, dosage, instructions, etc. (Minimum 10 characters)"
                                                  minlength="10" maxlength="1000"></textarea>
                                        <div class="form-text">
                                            Please include: Medicines, Dosage, Frequency, Duration, and any special instructions.
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="issueDate" class="form-label">Issue Date</label>
                                            <input type="date" class="form-control" id="issueDate" name="issueDate"
                                                   value="${prescription.issueDate}">
                                        </div>
                                    </div>

                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save me-2"></i>Create Prescription
                                        </button>
                                        <a href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions"
                                           class="btn btn-secondary">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const description = document.getElementById('description');

        form.addEventListener('submit', function(e) {
            if (description.value.trim().length < 10) {
                e.preventDefault();
                alert('Description must be at least 10 characters long.');
                description.focus();
            }
        });
    });
</script>
</body>
</html>
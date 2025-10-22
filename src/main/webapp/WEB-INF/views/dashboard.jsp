<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/18/2025
  Time: 1:36 AM
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - Medisphere</title>
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
                            <p class="mb-0">Doctor Dashboard</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="d-flex align-items-center justify-content-end">
                                <div class="me-3">
                                    <!-- CHANGED: Added session check for doctor object -->
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.doctor}">
                                            <span class="fw-bold">Dr. ${sessionScope.doctor.firstName} ${sessionScope.doctor.lastName}</span>
                                            <br>
                                            <small class="text-light">${sessionScope.doctor.specialization}</small>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="fw-bold">Dr. Demo User</span>
                                            <br>
                                            <small class="text-light">General Practitioner</small>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="dropdown">
                                    <button class="btn btn-outline-light dropdown-toggle" type="button"
                                            data-bs-toggle="dropdown">
                                        <i class="fas fa-user-md"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <!-- CHANGED: Added session check for doctor ID -->
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/dashboard">
                                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/profile">
                                            <i class="fas fa-user me-2"></i>Profile
                                        </a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-0">
                    <!-- Sidebar -->
                    <div class="col-md-3 medical-sidebar">
                        <nav class="nav flex-column">
                            <!-- CHANGED: Added session check for doctor ID in all links -->
                            <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/profile">
                                <i class="fas fa-user me-2"></i>My Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/appointments">
                                <i class="fas fa-calendar-check me-2"></i>Appointments
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/edit-profile">
                                <i class="fas fa-edit me-2"></i>Edit Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                                <i class="fas fa-prescription me-2"></i>Prescriptions
                            </a>
                        </nav>
                    </div>

                    <!-- Main Content Area -->
                    <div class="col-md-9 p-4">
                        <div class="row">
                            <div class="col-12">
                                <h2>Welcome to Your Dashboard</h2>
                                <p class="text-muted">Here you can manage your appointments, schedule, and profile.</p>
                            </div>
                        </div>

                        <!-- CHANGED: Added demo content for dashboard -->
                        <div class="row mt-4">
                            <div class="col-md-4 mb-4">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <div class="text-primary mb-3">
                                            <i class="fas fa-calendar-check fa-2x"></i>
                                        </div>
                                        <h5 class="card-title">Appointments</h5>
                                        <p class="card-text">Manage your upcoming appointments</p>
                                        <a href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/appointments" class="btn btn-primary btn-sm">View Appointments</a>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 mb-4">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <div class="text-success mb-3">
                                            <i class="fas fa-calendar-alt fa-2x"></i>
                                        </div>
                                        <h5 class="card-title">Prescription</h5>
                                        <p class="card-text">View and create prescription</p>
                                        <a href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/prescriptions" class="btn btn-success btn-sm">Create Prescription</a>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 mb-4">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <div class="text-info mb-3">
                                            <i class="fas fa-user-md fa-2x"></i>
                                        </div>
                                        <h5 class="card-title">Profile</h5>
                                        <p class="card-text">Update your professional information</p>
                                        <a href="${pageContext.request.contextPath}/doctor/${not empty sessionScope.doctor ? sessionScope.doctor.id : '1'}/profile" class="btn btn-info btn-sm">View Profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

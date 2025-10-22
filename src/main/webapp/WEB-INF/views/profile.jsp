<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/18/2025
  Time: 1:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Profile - Medisphere</title>
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
                            <p class="mb-0">Doctor Profile</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="d-flex align-items-center justify-content-end">
                                <div class="me-3">
                                    <span class="fw-bold">Dr. ${doctor.firstName} ${doctor.lastName}</span>
                                    <br>
                                    <small class="text-light">${doctor.specialization}</small>
                                </div>
                                <div class="dropdown">
                                    <button class="btn btn-outline-light dropdown-toggle" type="button"
                                            data-bs-toggle="dropdown">
                                        <i class="fas fa-user-md"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/${doctor.id}/dashboard">
                                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile">
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                            <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile">
                                <i class="fas fa-user me-2"></i>My Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/appointments">
                                <i class="fas fa-calendar-check me-2"></i>Appointments
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/edit-profile">
                                <i class="fas fa-edit me-2"></i>Edit Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                                <i class="fas fa-prescription me-2"></i>Prescriptions
                            </a>
                        </nav>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9 p-4">
                        <h2 class="section-title">Doctor Profile</h2>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>


                        <!-- Profile Card -->
                        <div class="profile-container">
                            <div class="profile-header-gradient">
                                <div class="profile-avatar-large">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <div class="profile-name">Dr. ${doctor.firstName} ${doctor.lastName}</div>
                                <div class="profile-specialty">${doctor.specialization}</div>
                            </div>

                            <div class="info-section">
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Username</div>
                                        <div class="info-value">${doctor.username}</div>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-envelope"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Email</div>
                                        <div class="info-value">${doctor.email}</div>
                                    </div>
                                </div>
                                <%--
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-phone"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Contact</div>
                                        <div class="info-value">${doctor.phoneNumber}</div>
                                    </div>
                                </div>
                                --%>

                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-stethoscope"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Specialization</div>
                                        <div class="info-value">${doctor.specialization}</div>
                                    </div>
                                </div>

                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-id-card"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">National ID</div>
                                        <div class="info-value">${doctor.nationalId}</div>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="info-icon">
                                        <i class="fas fa-birthday-cake"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Date of Birth</div>
                                        <div class="info-value">${doctor.dateOfBirth}</div>
                                    </div>
                                </div>
                            </div>


                            <div class="card-footer text-center py-4">
                                <a href="${pageContext.request.contextPath}/doctor/${doctor.id}/edit-profile"
                                   class="btn btn-edit-profile">
                                    <i class="fas fa-edit me-2"></i>Edit Profile
                                </a>
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



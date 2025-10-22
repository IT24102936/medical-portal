<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/18/2025
  Time: 11:58 AM
  To change this template use File | Settings | File Template
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.medicalportal.medicalportal.entity.Doctor" %>
<c:set var="doctor" value="${not empty doctor ? doctor : sessionScope.doctor}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - Medisphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/DoctorStyle.css">
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
                            <p class="mb-0">Edit Doctor Profile</p>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile">
                                <i class="fas fa-user me-2"></i>My Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/appointments">
                                <i class="fas fa-calendar-check me-2"></i>Appointments
                            </a>
                            <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/${doctor.id}/edit-profile">
                                <i class="fas fa-edit me-2"></i>Edit Profile
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                                <i class="fas fa-prescription me-2"></i>Prescriptions
                            </a>
                        </nav>
                    </div>

                    <!-- Main Content -->
                    <div class="col-md-9 p-4">
                        <h2>Edit Doctor Profile</h2>

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

                        <form action="${pageContext.request.contextPath}/doctor/${doctor.id}/update-profile" method="post">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">First Name</label>
                                            <input type="text" class="form-control" name="firstName"
                                                   value="${doctor.firstName}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Last Name</label>
                                            <input type="text" class="form-control" name="lastName"
                                                   value="${doctor.lastName}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" name="username"
                                               value="${doctor.username}" readonly>
                                        <small class="text-muted">Username cannot be changed</small>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" class="form-control" name="email"
                                                   value="${doctor.email}" required>
                                        </div>
                                       <%--
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Phone Number</label>
                                            <input type="tel" class="form-control" name="phoneNumber"
                                                   value="${doctor.phoneNumber}">
                                        </div>
                                        --%>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Specialization</label>
                                            <input type="text" class="form-control" name="specialization"
                                                   value="${doctor.specialization}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">National ID *</label>
                                            <input type="text" class="form-control" name="nationalId"
                                                   value="${doctor.nationalId}" required readonly>
                                            <small class="text-muted">National ID cannot be changed</small>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Date of Birth *</label>
                                            <input type="date" class="form-control" name="dateOfBirth"
                                                   value="${doctor.dateOfBirth}" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Gender *</label>
                                            <select class="form-control" name="gender" required>
                                                <option value="">Select Gender</option>
                                                <option value="Male" ${doctor.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${doctor.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${doctor.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>


                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">New Password (leave blank to keep current)</label>
                                            <input type="password" class="form-control" name="password">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Confirm New Password</label>
                                            <input type="password" class="form-control" name="confirmPassword">
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Update Profile
                                    </button>
                                    <a href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile"
                                       class="btn btn-secondary">
                                        <i class="fas fa-times me-2"></i>Cancel
                                    </a>

                                    <!-- Delete Profile Button with Confirmation -->
                                    <button type="button" class="btn btn-danger float-end"
                                            data-bs-toggle="modal" data-bs-target="#deleteProfileModal">
                                        <i class="fas fa-trash me-2"></i>Delete Profile
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Profile Modal -->
<div class="modal fade" id="deleteProfileModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Profile Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger">
                    <strong>Warning!</strong> This action cannot be undone. All your data, including appointments and schedules, will be permanently deleted.
                </div>
                <p>Are you sure you want to delete your profile?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form action="${pageContext.request.contextPath}/doctor/${doctor.id}/delete-profile" method="post">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Yes, Delete My Profile
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Password confirmation validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.querySelector('input[name="password"]');
        const confirmPassword = document.querySelector('input[name="confirmPassword"]');

        if (password.value !== confirmPassword.value) {
            e.preventDefault();
            alert('Passwords do not match!');
            confirmPassword.focus();
        }
    });
</script>
</body>
</html>


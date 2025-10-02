<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="context-path" content="${pageContext.request.contextPath}" />
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Medisphere - Patient Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="stylesheet" href="/css/Admin-Patient_management.css" />

    <style>
        .is-invalid {
            border-color: #dc3545 !important;
        }
        .patient-avatar-large {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 1rem;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .patient-avatar-large img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>

<div class="d-flex flex-column flex-grow-1">
    <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm px-4">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#" style="gap: 0.75rem;">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 48px;">
                <span class="h4 mb-0" style="letter-spacing: -0.02em; font-weight: 900; font-family: 'Inter', sans-serif;">Medisphere</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav main-nav" style="gap: 1rem;">
                    <li class="nav-item"><a class="nav-link" href="/admin/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/appointments">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link active" href="/admin/patients">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/doctors">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/employees">Employees</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/reports">Reports</a></li>
                </ul>

                <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0">
                    <button class="btn btn-icon" id="themeToggle" style="color: #6c757d; --bs-btn-hover-bg: #f8f9fa; --bs-btn-hover-color: #343a40;">
                        <span class="material-symbols-outlined" id="themeIcon"> dark_mode </span>
                    </button>

                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle profile-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="rounded-circle profile-image" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuA3boPg3H5g65efIn-gaUO97A7z7vSo3zvnJwpXLtPek270t0wZTVPKt_K_IlVndXPXT4g5uljDogjVObHId6jQVZPNgMbYz62vbNrpUltGAxVXxlNM8snOB-lewtYGwz45ZJB1TdjLGWGSAhFkCvJDswSzA4KvEVBKZPfUfaTt5D_rNs4QxLxSRzk6W2hXAx_OwMzmkSnOeG-1aRn4yMfL8WAWxeEl9NhtT1lWPTAHJ6n6cHSfnKXQjShoeQujS0oA9TP1v6AzGNLj');"></div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item d-flex align-items-center gap-2" href="#">
                                    <span class="material-symbols-outlined">logout</span>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <main class="flex-grow-1 p-4 p-lg-5">
        <div class="container-xl">
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-5">
                <h1 class="h2 fw-bold mb-3 mb-sm-0">Patient Management</h1>
                <button class="btn btn-primary d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#addPatientModal">
                    <span class="material-symbols-outlined"> add </span>
                    Add New Patient
                </button>
            </div>

            <!-- Error/Success Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="mb-5 d-flex justify-content-start">
                <div class="w-100" style="max-width: 24rem;">
                    <div class="search-input-container">
                        <span class="material-symbols-outlined"> search </span>
                        <input class="form-control" id="patientSearchInput" placeholder="Search for patients by name or ID" type="search" />
                    </div>
                </div>
            </div>

            <div class="card shadow-sm overflow-hidden">
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead>
                        <tr>
                            <th class="px-4 py-3">Id</th> <!-- Renamed from "Patient ID" to "Id" -->
                            <th class="px-4 py-3">Name</th>
                            <th class="px-4 py-3">Email</th>
                            <th class="px-4 py-3">Contact</th>
                            <th class="px-4 py-3">Gender</th>
                            <th class="px-4 py-3">Status</th>
                            <th class="px-4 py-3">Actions</th>
                        </tr>
                        </thead>
                        <tbody id="patientTableBody">
                        <c:choose>
                            <c:when test="${not empty patients}">
                                <c:forEach var="patient" items="${patients}">
                                    <tr data-patient-id="${patient.patient_id}"> <!-- Updated from patient.pid to patient_id -->
                                        <td class="px-4 py-3 text-muted">${patient.patient_id}</td> <!-- Updated from patient.pid to patient_id -->
                                        <td class="px-4 py-3 fw-medium">${patient.first_name} ${patient.last_name}</td>
                                        <td class="px-4 py-3 text-muted">${patient.email}</td>
                                        <td class="px-4 py-3 text-muted">
                                            <c:choose>
                                                <c:when test="${not empty patient.phone_numbers}">
                                                    ${patient.phone_numbers}
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3 text-muted">${patient.gender}</td>
                                        <td class="px-4 py-3">
                                            <c:choose>
                                                <c:when test="${patient.status == 'ACTIVE'}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">Disabled</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3">
                                            <div class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center gap-2">
                                                <c:choose>
                                                    <c:when test="${patient.status == 'ACTIVE'}">
                                                        <button class="btn btn-outline-warning btn-action btn-action-disable" data-patient-id="${patient.patient_id}"> <!-- Updated from patient.pid to patient_id -->
                                                            <span class="material-symbols-outlined"> block </span> Disable
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-outline-success btn-action btn-action-enable" data-patient-id="${patient.patient_id}"> <!-- Updated from patient.pid to patient_id -->
                                                            <span class="material-symbols-outlined"> check_circle </span> Enable
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                                <button class="btn btn-outline-primary btn-action btn-action-edit" data-patient-id="${patient.patient_id}"> <!-- Updated from patient.pid to patient_id -->
                                                    <span class="material-symbols-outlined"> edit </span> Edit
                                                </button>
                                                <button class="btn btn-outline-danger btn-action btn-action-delete" data-patient-id="${patient.patient_id}"> <!-- Updated from patient.pid to patient_id -->
                                                    <span class="material-symbols-outlined"> delete </span> Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="px-4 py-5 text-center text-muted">
                                        <div class="d-flex flex-column align-items-center gap-2">
                                            <span class="material-symbols-outlined" style="font-size: 48px; opacity: 0.5;">person_off</span>
                                            <span>No Patients Found</span>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <footer class="mt-auto border-top bg-white py-4">
        <div class="container">
            <p class="text-center text-muted small mb-0">© 2025 Medisphere. All rights reserved.</p>
        </div>
    </footer>
</div>

<!-- Add Patient Modal -->
<div class="modal fade" id="addPatientModal" tabindex="-1" aria-labelledby="addPatientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addPatientModalLabel">Add New Patient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="addPatientForm" action="/admin/patients/add" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-12 text-center mb-4">
                            <div class="patient-avatar-large" id="addAvatarPreview">
                                <img src="https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👤" alt="Avatar" id="addAvatarImg">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addFirstName" class="form-label">First Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="addFirstName" name="firstName" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addLastName" class="form-label">Last Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="addLastName" name="lastName" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="addEmail" name="email" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addGender" class="form-label">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="addGender" name="gender" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addDob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="addDob" name="dob">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addPhone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="addPhone" name="phone" placeholder="+94771234567">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addNationalId" class="form-label">National ID</label>
                                <input type="text" class="form-control" id="addNationalId" name="nationalId" placeholder="123456789V">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addUserName" class="form-label">Username <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="addUserName" name="userName" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addPassword" class="form-label">Password <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="addPassword" name="password" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="addConfirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" id="addConfirmPassword" name="confirmPassword" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Patient Modal -->
<div class="modal fade" id="editPatientModal" tabindex="-1" aria-labelledby="editPatientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPatientModalLabel">Edit Patient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editPatientForm" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="editPatientId" name="pid">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-12 text-center mb-4">
                            <div class="patient-avatar-large" id="editAvatarPreview">
                                <img src="https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👤" alt="Avatar" id="editAvatarImg">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editFirstName" class="form-label">First Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editLastName" class="form-label">Last Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editLastName" name="lastName" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="editEmail" name="email" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editGender" class="form-label">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="editGender" name="gender" required>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editDob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="editDob" name="dob">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editPhone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="editPhone" name="phone" placeholder="+94771234567">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editNationalId" class="form-label">National ID</label>
                                <input type="text" class="form-control" id="editNationalId" name="nationalId" placeholder="123456789V">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="editUserName" class="form-label">Username <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editUserName" name="userName" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/Admin-Patient_management.js"></script>
</body>
</html>
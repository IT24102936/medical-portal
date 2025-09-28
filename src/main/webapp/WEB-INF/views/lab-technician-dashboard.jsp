<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab Technician Dashboard - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <link rel="stylesheet" href="/css/lab-technician-dashboard.css">
    <style>
        /* Fallback styles for lab technician dashboard */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 100%);
            min-height: 100vh;
        }
        .text-dark-blue {
            color: #0d171b !important;
        }
        .dashboard-main {
            background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 50%, #bbdefb 100%);
            padding-bottom: 2rem;
        }
        .welcome-card {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(19, 164, 236, 0.1);
            position: relative;
        }
        .welcome-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #13a4ec, #0b8acb);
        }
        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1rem;
            background: rgba(19, 164, 236, 0.05);
            border-radius: 12px;
            transition: transform 0.3s ease;
        }
        .stat-item:hover {
            transform: translateY(-5px);
        }
        .stat-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: #13a4ec;
        }
        .stat-label {
            font-size: 0.85rem;
            color: #0d171b;
            text-align: center;
        }
        .dashboard-card {
            background: white;
            border-radius: 20px;
            padding: 0;
            border: 1px solid rgba(19, 164, 236, 0.1);
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }
        .dashboard-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 35px rgba(19, 164, 236, 0.15);
            border-color: #13a4ec;
        }
        .dashboard-card .card-header {
            padding: 1.5rem 1.5rem 1rem 1.5rem;
            border-bottom: none;
            background: transparent;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .dashboard-card .icon-wrapper {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .dashboard-card .card-title {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            color: #0d171b;
        }
        .dashboard-card .card-body {
            padding: 0 1.5rem 1rem 1.5rem;
        }
        .dashboard-card .card-description {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            line-height: 1.5;
        }
        .dashboard-card .card-stats {
            margin-bottom: 0;
        }
        .dashboard-card .stat-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }
        .dashboard-card .stat-row:last-child {
            border-bottom: none;
        }
        .dashboard-card .stat-label {
            font-size: 0.85rem;
            color: #6c757d;
        }
        .dashboard-card .stat-value {
            font-weight: 600;
            font-size: 0.9rem;
        }
        .dashboard-card .card-footer {
            padding: 1rem 1.5rem 1.5rem 1.5rem;
            background: rgba(19, 164, 236, 0.03);
            border-top: 1px solid rgba(19, 164, 236, 0.1);
        }
        .dashboard-card .action-text {
            color: #13a4ec;
            font-weight: 500;
            font-size: 0.85rem;
        }
        .btn-primary {
            background-color: #13a4ec !important;
            border-color: #13a4ec !important;
        }
        .btn-primary:hover {
            background-color: #0b8acb !important;
            border-color: #0b8acb !important;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(19, 164, 236, 0.3);
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="shadow-sm sticky-top">
    <nav class="navbar navbar-expand-lg bg-white py-2 px-3 px-lg-5">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 50px;" class="me-2">
                <div>
                    <h2 class="text-dark-blue mb-0 fs-3">Medisphere</h2>
                    <small class="text-muted">Lab Technician Dashboard</small>
                </div>
            </a>

            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown">
                        <span class="material-symbols-outlined me-2">person</span>
                        <span class="d-none d-md-inline">Sarah Johnson</span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#profileModal">
                            <span class="material-symbols-outlined me-2">person</span>View Profile
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="/logout">
                            <span class="material-symbols-outlined me-2">logout</span>Logout
                        </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="dashboard-main">
    <div class="container-fluid px-4 py-4">

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

        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="welcome-card">
                    <h1 class="display-6 fw-bold text-dark-blue mb-2">🔬 Welcome Back, Sarah!</h1>
                    <p class="lead text-secondary mb-3">Manage laboratory operations and test processing efficiently</p>
                    <div class="d-flex flex-wrap gap-3">
                        <div class="stat-item">
                            <span class="stat-number">${totalPendingOrders}</span>
                            <span class="stat-label">Pending Orders</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">${totalOrdersToday}</span>
                            <span class="stat-label">Orders Today</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">${totalReports}</span>
                            <span class="stat-label">Medical Reports</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="row g-4 mb-5">

            <!-- Lab Technician Profile Card -->
            <div class="col-lg-6 col-xl-4">
                <div class="dashboard-card h-100" data-bs-toggle="modal" data-bs-target="#profileModal" style="cursor: pointer;">
                    <div class="card-header">
                        <div class="icon-wrapper bg-primary">
                            <span class="material-symbols-outlined">person</span>
                        </div>
                        <h3 class="card-title">👩‍🔬 My Profile</h3>
                    </div>
                    <div class="card-body">
                        <p class="card-description">View and update your personal information and contact details</p>
                        <div class="card-stats">
                            <div class="stat-row">
                                <span class="stat-label">Employee ID:</span>
                                <span class="stat-value">LAB001</span>
                            </div>
                            <div class="stat-row">
                                <span class="stat-label">Position:</span>
                                <span class="stat-value">Senior Lab Technician</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <span class="action-text">👆 Click to Manage Profile →</span>
                    </div>
                </div>
            </div>

            <!-- Doctor Orders Card -->
            <div class="col-lg-6 col-xl-4">
                <div class="dashboard-card h-100" data-bs-toggle="modal" data-bs-target="#doctorOrdersModal" style="cursor: pointer;">
                    <div class="card-header">
                        <div class="icon-wrapper bg-success">
                            <span class="material-symbols-outlined">medical_information</span>
                        </div>
                        <h3 class="card-title">👨‍⚕️ Doctor Orders</h3>
                    </div>
                    <div class="card-body">
                        <p class="card-description">View and process lab test orders received from doctors</p>
                        <div class="card-stats">
                            <div class="stat-row">
                                <span class="stat-label">Total Orders:</span>
                                <span class="stat-value text-warning">${totalPendingOrders}</span>
                            </div>
                            <div class="stat-row">
                                <span class="stat-label">Today:</span>
                                <span class="stat-value text-success">${totalOrdersToday}</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <span class="action-text">👆 Click to View Doctor Orders →</span>
                    </div>
                </div>
            </div>

            <!-- Medical Reports Card -->
            <div class="col-lg-6 col-xl-4">
                <div class="dashboard-card h-100" data-bs-toggle="modal" data-bs-target="#medicalReportsModal" style="cursor: pointer;">
                    <div class="card-header">
                        <div class="icon-wrapper bg-info">
                            <span class="material-symbols-outlined">description</span>
                        </div>
                        <h3 class="card-title">📄 Lab Reports</h3>
                    </div>
                    <div class="card-body">
                        <p class="card-description">Manage medical reports and upload drive links for patient records</p>
                        <div class="card-stats">
                            <div class="stat-row">
                                <span class="stat-label">Total Reports:</span>
                                <span class="stat-value text-info">${totalReports}</span>
                            </div>
                            <div class="stat-row">
                                <span class="stat-label">Today:</span>
                                <span class="stat-value text-primary">${reportsToday}</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <span class="action-text">👆 Click to Manage Lab Reports →</span>
                    </div>
                </div>
            </div>

    </div>
</main>

<footer class="text-white py-5" style="background-color: #0d171b;">
    <div class="container">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center text-center text-md-start">
            <div class="mb-3 mb-md-0">
                <p class="mb-0 text-secondary">© 2025 Medisphere. All rights reserved.</p>
            </div>
            <nav class="nav justify-content-center mb-3 mb-md-0">
                <a class="nav-link text-secondary" href="./home.html">Home</a>
                <a class="nav-link text-secondary" href="#">About</a>
                <a class="nav-link text-secondary" href="pharmacy-home.jsp">Pharmacy</a>
                <a class="nav-link text-secondary" href="laboratory-services.jsp">Laboratory</a>
            </nav>
            <div class="d-flex justify-content-center">
                <a href="#" class="text-secondary me-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16"><path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.142-.003-.282-.008-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/></svg></a>
                <a href="#" class="text-secondary me-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16"><path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"/></svg></a>
                <a href="#" class="text-secondary"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-linkedin" viewBox="0 0 16 16"><path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.305 0-1.854.935-2.169 1.59h-.03v-1.34H6.649v7.225h2.402z"/></svg></a>
            </div>
        </div>
    </div>
</footer>

<!-- Profile Modal -->
<div class="modal fade" id="profileModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">👩‍🔬 Lab Technician Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="/lab-technician/profile/update">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Employee ID</label>
                            <input type="text" class="form-control" value="LAB001" readonly>
                            <small class="text-muted">Cannot be modified</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Position</label>
                            <input type="text" class="form-control" value="Senior Lab Technician" readonly>
                            <small class="text-muted">Cannot be modified</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">First Name</label>
                            <input type="text" class="form-control" name="firstName" value="Sarah" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Last Name</label>
                            <input type="text" class="form-control" name="lastName" value="Johnson" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Address</label>
                            <textarea class="form-control" name="address" rows="3" required>789 Laboratory Avenue, Science District, City, State 12345</textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Contact Number</label>
                            <input type="tel" class="form-control" name="contactNumber" value="(+94) 77 123 4567" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Doctor Orders Modal -->
<div class="modal fade" id="doctorOrdersModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">👨‍⚕️ Doctor Test Orders Management</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="doctorOrdersTable">
                        <thead class="table-success">
                        <tr>
                            <th>Lab Order ID</th>
                            <th>Patient Name</th>
                            <th>Doctor ID</th>
                            <th>Test Description</th>
                            <th>Issue Date</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="order" items="${doctorOrders}">
                            <tr>
                                <td>#${order.labOrder.id}</td>
                                <td>${order.patient.firstName} ${order.patient.lastName}</td>
                                <td>Dr. ${order.doctorEid.id}</td>
                                <td>${order.labOrder.description}</td>
                                <td>${order.issueDate}</td>
                                <td>
                                    <form method="post" action="/lab-technician/order/accept" style="display: inline;">
                                        <input type="hidden" name="doctorEid" value="${order.doctorEid.id}">
                                        <input type="hidden" name="labOrderId" value="${order.labOrder.id}">
                                        <input type="hidden" name="patientId" value="${order.patient.id}">
                                        <button type="submit" class="btn btn-sm btn-success me-1">Accept</button>
                                    </form>
                                    <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#resultsModal" 
                                            data-doctor-eid="${order.doctorEid.id}" 
                                            data-lab-order-id="${order.labOrder.id}" 
                                            data-patient-id="${order.patient.id}"
                                            data-description="${order.labOrder.description}">📊 Submit Results</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Results Submission Modal -->
<div class="modal fade" id="resultsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">📊 Submit Lab Results</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="/lab-technician/order/submit-results" id="resultsForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <h6 class="fw-bold mb-2">Test Information</h6>
                                <div id="testInfo"></div>
                            </div>
                        </div>
                        
                        <input type="hidden" name="doctorEid" id="hiddenDoctorEid">
                        <input type="hidden" name="labOrderId" id="hiddenLabOrderId">
                        <input type="hidden" name="patientId" id="hiddenPatientId">
                        
                        <div class="col-12">
                            <label class="form-label fw-bold">Lab Results</label>
                            <textarea class="form-control" name="results" rows="4" 
                                     placeholder="Enter detailed lab results..." required></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Submit Results</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Medical Reports Modal -->
<div class="modal fade" id="medicalReportsModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">📄 Medical Reports Management</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- Add New Report Section -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="card-title mb-0">➕ Submit New Medical Report</h6>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/lab-technician/medical-report/submit" id="medicalReportForm">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Report Type</label>
                                    <select class="form-select" name="reportType" required>
                                        <option value="">Select Report Type</option>
                                        <option value="Blood Test">Blood Test</option>
                                        <option value="Urine Analysis">Urine Analysis</option>
                                        <option value="X-Ray">X-Ray</option>
                                        <option value="MRI Scan">MRI Scan</option>
                                        <option value="CT Scan">CT Scan</option>
                                        <option value="ECG">ECG</option>
                                        <option value="Ultrasound">Ultrasound</option>
                                        <option value="Pathology">Pathology</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Patient</label>
                                    <select class="form-select" name="patientId" required>
                                        <option value="">Select Patient</option>
                                        <c:forEach var="patient" items="${patients}">
                                            <option value="${patient.id}">${patient.firstName} ${patient.lastName} (ID: ${patient.id})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-bold">Document Link (Google Drive/Cloud Storage)</label>
                                    <input type="url" class="form-control" name="documentPath" 
                                           placeholder="https://drive.google.com/file/d/..." required>
                                    <small class="text-muted">Please provide a shareable Google Drive link or other cloud storage URL</small>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">
                                        <span class="material-symbols-outlined me-2">upload</span>
                                        Submit Report
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Existing Reports Table -->
                <div class="card">
                    <div class="card-header">
                        <h6 class="card-title mb-0">📁 Existing Medical Reports</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover" id="medicalReportsTable">
                                <thead class="table-info">
                                <tr>
                                    <th>Report ID</th>
                                    <th>Patient Name</th>
                                    <th>Report Type</th>
                                    <th>Report Date</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="report" items="${medicalReports}">
                                    <tr>
                                        <td>#${report.id}</td>
                                        <td>${report.patient.firstName} ${report.patient.lastName}</td>
                                        <td>
                                            <span class="badge bg-info">${report.reportType}</span>
                                        </td>
                                        <td>${report.reportDate}</td>
                                        <td>
                                            <a href="${report.documentPath}" target="_blank" class="btn btn-sm btn-success me-1">
                                                <span class="material-symbols-outlined">visibility</span>
                                                View
                                            </a>
                                            <form method="post" action="/lab-technician/medical-report/delete/${report.id}" 
                                                  style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this report?');">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <span class="material-symbols-outlined">delete</span>
                                                    Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty medicalReports}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            <span class="material-symbols-outlined d-block mb-2" style="font-size: 3rem;">description</span>
                                            No medical reports found. Submit a new report above.
                                        </td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
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

        // Handle results modal data population
        const resultsModal = document.getElementById('resultsModal');
        if (resultsModal) {
            resultsModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const doctorEid = button.getAttribute('data-doctor-eid');
                const labOrderId = button.getAttribute('data-lab-order-id');
                const patientId = button.getAttribute('data-patient-id');
                const description = button.getAttribute('data-description');

                // Populate hidden fields
                document.getElementById('hiddenDoctorEid').value = doctorEid;
                document.getElementById('hiddenLabOrderId').value = labOrderId;
                document.getElementById('hiddenPatientId').value = patientId;

                // Update test info display
                document.getElementById('testInfo').innerHTML = 
                    '<strong>Lab Order ID:</strong> #' + labOrderId + '<br>' +
                    '<strong>Test Description:</strong> ' + description + '<br>' +
                    '<strong>Doctor ID:</strong> ' + doctorEid + '<br>' +
                    '<strong>Patient ID:</strong> ' + patientId;
            });
        }

        // Handle medical report form submission with validation
        const medicalReportForm = document.getElementById('medicalReportForm');
        if (medicalReportForm) {
            medicalReportForm.addEventListener('submit', function(event) {
                const documentPath = document.querySelector('input[name="documentPath"]').value;
                
                // Basic validation for Google Drive or HTTPS links
                if (!isValidDriveLink(documentPath)) {
                    event.preventDefault();
                    alert('Please provide a valid Google Drive link or HTTPS URL. Examples:\n' +
                          '• https://drive.google.com/file/d/...\n' +
                          '• https://docs.google.com/document/d/...\n' +
                          '• Any HTTPS URL');
                    return false;
                }
            });
        }

        // Function to validate drive links
        function isValidDriveLink(url) {
            if (!url || url.trim() === '') return false;
            
            // Check for valid URL format
            try {
                new URL(url);
            } catch {
                return false;
            }
            
            // Check for Google Drive patterns or HTTPS
            return url.includes('drive.google.com') || 
                   url.includes('docs.google.com') || 
                   url.startsWith('https://');
        }

        // Add confirmation for delete actions
        const deleteButtons = document.querySelectorAll('form[action*="delete"] button[type="submit"]');
        deleteButtons.forEach(button => {
            button.addEventListener('click', function(event) {
                if (!confirm('Are you sure you want to delete this medical report? This action cannot be undone.')) {
                    event.preventDefault();
                    return false;
                }
            });
        });

        // Enhanced table interactions
        const tables = document.querySelectorAll('table');
        tables.forEach(table => {
            const rows = table.querySelectorAll('tbody tr');
            rows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.backgroundColor = 'rgba(19, 164, 236, 0.05)';
                });
                row.addEventListener('mouseleave', function() {
                    this.style.backgroundColor = '';
                });
            });
        });

        // Add loading states to forms
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', function() {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn && !submitBtn.disabled) {
                    const originalText = submitBtn.innerHTML;
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Processing...';
                    
                    // Re-enable after 5 seconds as fallback
                    setTimeout(() => {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = originalText;
                    }, 5000);
                }
            });
        });
    });
</script>
</body>
</html>
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
    <link rel="stylesheet" href="../../resources/static/css/lab-technician-dashboard.css">
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
                        <li><a class="dropdown-item" href="#" onclick="showProfile()">
                            <span class="material-symbols-outlined me-2">person</span>View Profile
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="#" onclick="logout()">
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

        <!-- Welcome Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="welcome-card">
                    <h1 class="display-6 fw-bold text-dark-blue mb-2">🔬 Welcome Back, Sarah!</h1>
                    <p class="lead text-secondary mb-3">Manage laboratory operations and test processing efficiently</p>
                    <div class="d-flex flex-wrap gap-3">
                        <div class="stat-item">
                            <span class="stat-number">18</span>
                            <span class="stat-label">Pending Tests</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">32</span>
                            <span class="stat-label">Tests in Progress</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">95%</span>
                            <span class="stat-label">Equipment Ready</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="row g-4 mb-5">

            <!-- Lab Technician Profile Card -->
            <div class="col-lg-6 col-xl-4">
                <div class="dashboard-card h-100" onclick="showProfile()">
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
                        <span class="action-text">Manage Profile →</span>
                    </div>
                </div>
            </div>

            <!-- Doctor Orders Card -->
            <div class="col-lg-6 col-xl-4">
                <div class="dashboard-card h-100" onclick="showDoctorOrders()">
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
                                <span class="stat-label">Pending:</span>
                                <span class="stat-value text-warning">12</span>
                            </div>
                            <div class="stat-row">
                                <span class="stat-label">Completed Today:</span>
                                <span class="stat-value text-success">24</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <span class="action-text">View Doctor Orders →</span>
                    </div>
                </div>
            </div>

            <!-- Patient Orders Card -->
            <div class="col-lg-6 col-xl-4">
                <div class="dashboard-card h-100" onclick="showPatientOrders()">
                    <div class="card-header">
                        <div class="icon-wrapper bg-info">
                            <span class="material-symbols-outlined">patient_list</span>
                        </div>
                        <h3 class="card-title">👥 Patient Orders</h3>
                    </div>
                    <div class="card-body">
                        <p class="card-description">Manage lab test bookings submitted directly by patients</p>
                        <div class="card-stats">
                            <div class="stat-row">
                                <span class="stat-label">New Bookings:</span>
                                <span class="stat-value text-info">6</span>
                            </div>
                            <div class="stat-row">
                                <span class="stat-label">In Progress:</span>
                                <span class="stat-value text-warning">8</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <span class="action-text">View Patient Orders →</span>
                    </div>
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
            <div class="modal-body">
                <form id="profileForm">
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
                            <input type="text" class="form-control" id="firstName" value="Sarah">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Last Name</label>
                            <input type="text" class="form-control" id="lastName" value="Johnson">
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Address</label>
                            <textarea class="form-control" id="address" rows="3">789 Laboratory Avenue, Science District, City, State 12345</textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Contact Number</label>
                            <input type="tel" class="form-control" id="contactNumber" value="(+94) 77 123 4567">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="updateProfile()">Update Profile</button>
            </div>
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
                <!-- Search and Filter Controls -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="input-group">
                                <span class="input-group-text">
                                    <span class="material-symbols-outlined">search</span>
                                </span>
                            <input type="text" class="form-control" placeholder="Search by patient name..." id="doctorSearchInput">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="doctorTestTypeFilter">
                            <option value="">All Test Types</option>
                            <option value="Blood Tests">Blood Tests</option>
                            <option value="Urine Analysis">Urine Analysis</option>
                            <option value="Microbiology">Microbiology</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="doctorPriorityFilter">
                            <option value="">All Priorities</option>
                            <option value="Urgent">Urgent</option>
                            <option value="Normal">Normal</option>
                            <option value="Routine">Routine</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-outline-secondary w-100" onclick="clearDoctorFilters()">Clear</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover" id="doctorOrdersTable">
                        <thead class="table-success">
                        <tr>
                            <th>Order ID</th>
                            <th>Patient Name</th>
                            <th>Doctor</th>
                            <th>Test Type</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr data-patient="Emily Wilson" data-test="Blood Tests" data-priority="Urgent">
                            <td>#DOC001</td>
                            <td>Emily Wilson</td>
                            <td>Dr. Anderson</td>
                            <td>Complete Blood Count</td>
                            <td><span class="badge bg-danger">Urgent</span></td>
                            <td><span class="badge bg-warning">Pending</span></td>
                            <td>
                                <button class="btn btn-sm btn-success me-1" onclick="acceptOrder('DOC001', 'doctor')">Accept</button>
                                <button class="btn btn-sm btn-primary me-1" onclick="submitResults('DOC001', 'doctor')" style="display: none;">📊 Submit Results</button>
                            </td>
                        </tr>
                        <tr data-patient="Michael Brown" data-test="Urine Analysis" data-priority="Normal">
                            <td>#DOC002</td>
                            <td>Michael Brown</td>
                            <td>Dr. Martinez</td>
                            <td>Urine Analysis</td>
                            <td><span class="badge bg-info">Normal</span></td>
                            <td><span class="badge bg-info">In Progress</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary me-1" onclick="submitResults('DOC002', 'doctor')">📊 Submit Results</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Patient Orders Modal -->
<div class="modal fade" id="patientOrdersModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">👥 Patient Test Orders Management</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="patientOrdersTable">
                        <thead class="table-info">
                        <tr>
                            <th>Booking ID</th>
                            <th>Patient Name</th>
                            <th>Contact</th>
                            <th>Selected Tests</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr data-patient="John Doe" data-test="Blood Tests" data-status="New">
                            <td>#LAB-123456</td>
                            <td>John Doe <small class="text-muted">(M, 35)</small></td>
                            <td>(+94) 77 123 4567</td>
                            <td>Complete Blood Count, Lipid Panel</td>
                            <td><span class="badge bg-primary">New</span></td>
                            <td>
                                <button class="btn btn-sm btn-success me-1" onclick="acceptOrder('LAB-123456', 'patient')">Assign</button>
                                <button class="btn btn-sm btn-primary me-1" onclick="submitResults('LAB-123456', 'patient')" style="display: none;">📊 Submit Results</button>
                            </td>
                        </tr>
                        <tr data-patient="Jane Smith" data-test="Thyroid Function" data-status="In Progress">
                            <td>#LAB-123457</td>
                            <td>Jane Smith <small class="text-muted">(F, 28)</small></td>
                            <td>(+94) 71 987 6543</td>
                            <td>Thyroid Function Test</td>
                            <td><span class="badge bg-warning">In Progress</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary me-1" onclick="submitResults('LAB-123457', 'patient')">📊 Submit Results</button>
                            </td>
                        </tr>
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
            <div class="modal-body">
                <form id="resultsForm" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <h6 class="fw-bold mb-2">Test Information</h6>
                                <div id="testInfo"></div>
                            </div>
                        </div>

                        <!-- File Upload Area -->
                        <div class="col-12">
                            <label class="form-label fw-bold">📎 Upload Lab Result Files</label>
                            <div class="upload-area" id="uploadArea">
                                <div class="upload-content">
                                    <span class="material-symbols-outlined upload-icon">cloud_upload</span>
                                    <p class="upload-text">Drag and drop lab result files here or click to upload</p>
                                    <p class="upload-hint">(PDF, JPG, JPEG, PNG files allowed - Max 10MB)</p>
                                </div>
                                <input type="file" id="fileInput" name="resultFiles" accept=".pdf,.jpg,.jpeg,.png" multiple style="display: none;">
                            </div>
                            <div class="upload-success" id="uploadSuccess" style="display: none;">
                                <span class="material-symbols-outlined success-icon">check_circle</span>
                                <span class="success-text">Files selected successfully!</span>
                                <div id="fileList" class="file-list"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="saveResults()">Submit Results</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showProfile() {
        new bootstrap.Modal(document.getElementById('profileModal')).show();
    }

    function showDoctorOrders() {
        new bootstrap.Modal(document.getElementById('doctorOrdersModal')).show();
    }

    function showPatientOrders() {
        new bootstrap.Modal(document.getElementById('patientOrdersModal')).show();
    }

    function updateProfile() {
        const firstName = document.getElementById('firstName').value;
        const lastName = document.getElementById('lastName').value;
        alert('Profile updated successfully!\nName: ' + firstName + ' ' + lastName);
        bootstrap.Modal.getInstance(document.getElementById('profileModal')).hide();
    }

    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            alert('Logging out...');
        }
    }

    function acceptOrder(orderId, orderType) {
        const tableId = orderType === 'doctor' ? 'doctorOrdersTable' : 'patientOrdersTable';
        const rows = document.querySelectorAll(`#${tableId} tbody tr`);

        rows.forEach(row => {
            if (row.cells[0].textContent.includes(orderId)) {
                const statusBadge = row.querySelector('.badge:not(.bg-danger):not(.bg-info)');
                const acceptBtn = row.querySelector('button[onclick*="acceptOrder"]');
                const submitBtn = row.querySelector('button[onclick*="submitResults"]');

                if (statusBadge) {
                    statusBadge.className = orderType === 'doctor' ? 'badge bg-info' : 'badge bg-warning';
                    statusBadge.textContent = 'In Progress';
                }

                if (acceptBtn) acceptBtn.style.display = 'none';
                if (submitBtn) submitBtn.style.display = 'inline-block';
            }
        });

        alert(`Order ${orderId} has been accepted and is now in progress.`);
    }

    function submitResults(orderId, orderType) {
        const testInfoDiv = document.getElementById('testInfo');
        testInfoDiv.innerHTML = `
                <strong>Order ID:</strong> #${orderId}<br>
                <strong>Order Type:</strong> ${orderType === 'doctor' ? 'Doctor Referral' : 'Patient Booking'}
            `;

        document.getElementById('resultsForm').dataset.orderId = orderId;
        document.getElementById('resultsForm').dataset.orderType = orderType;

        new bootstrap.Modal(document.getElementById('resultsModal')).show();
    }

    function saveResults() {
        const form = document.getElementById('resultsForm');
        const orderId = form.dataset.orderId;
        const orderType = form.dataset.orderType;

        const testResult = document.getElementById('testResult').value;
        const detailedResults = document.getElementById('detailedResults').value;
        const fileInput = document.getElementById('fileInput');

        if (!testResult || !detailedResults) {
            alert('Please fill in all required fields.');
            return;
        }

        // Check if files are uploaded
        const hasFiles = fileInput.files.length > 0;
        let fileInfo = '';
        if (hasFiles) {
            const fileNames = Array.from(fileInput.files).map(file => file.name).join(', ');
            fileInfo = `\nUploaded files: ${fileNames}`;
        }

        // Update order status to completed
        const tableId = orderType === 'doctor' ? 'doctorOrdersTable' : 'patientOrdersTable';
        const rows = document.querySelectorAll(`#${tableId} tbody tr`);

        rows.forEach(row => {
            if (row.cells[0].textContent.includes(orderId)) {
                const statusBadge = row.querySelector('.badge:not(.bg-danger):not(.bg-info)');
                if (statusBadge) {
                    statusBadge.className = 'badge bg-success';
                    statusBadge.textContent = 'Completed';
                }

                const actionsCell = row.cells[row.cells.length - 1];
                actionsCell.innerHTML = '<button class="btn btn-sm btn-outline-success">View Results</button>';
            }
        });

        alert(`Results for order ${orderId} have been submitted successfully!${fileInfo}`);
        bootstrap.Modal.getInstance(document.getElementById('resultsModal')).hide();
        form.reset();
    }

    function clearDoctorFilters() {
        document.getElementById('doctorSearchInput').value = '';
        document.getElementById('doctorTestTypeFilter').value = '';
        document.getElementById('doctorPriorityFilter').value = '';
    }

    // Add interactive animations
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.dashboard-card');
        cards.forEach((card, index) => {
            card.style.animationDelay = (index * 0.1) + 's';
            card.classList.add('fade-in-up');
        });

        // File upload functionality
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const uploadSuccess = document.getElementById('uploadSuccess');
        const fileList = document.getElementById('fileList');
        let selectedFiles = [];

        // Click to upload
        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });

        // Drag and drop functionality
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.classList.add('drag-over');
        });

        uploadArea.addEventListener('dragleave', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('drag-over');
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.classList.remove('drag-over');
            const files = Array.from(e.dataTransfer.files);
            handleFileSelection(files);
        });

        // File input change
        fileInput.addEventListener('change', (e) => {
            const files = Array.from(e.target.files);
            handleFileSelection(files);
        });

        function handleFileSelection(files) {
            // Filter valid files
            const validFiles = files.filter(file => {
                const validTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png'];
                const maxSize = 10 * 1024 * 1024; // 10MB
                return validTypes.includes(file.type) && file.size <= maxSize;
            });

            if (validFiles.length > 0) {
                selectedFiles = validFiles;
                displaySelectedFiles();
                uploadArea.style.display = 'none';
                uploadSuccess.style.display = 'block';
            } else {
                alert('Please select valid files (PDF, JPG, JPEG, PNG) under 10MB.');
            }
        }

        function displaySelectedFiles() {
            fileList.innerHTML = '';
            selectedFiles.forEach((file, index) => {
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';
                fileItem.innerHTML = `
                        <span class="material-symbols-outlined">description</span>
                        <span class="file-name">${file.name}</span>
                        <span class="file-size">(${(file.size / 1024 / 1024).toFixed(2)} MB)</span>
                        <button type="button" class="remove-file" onclick="removeFile(${index})">
                            <span class="material-symbols-outlined">close</span>
                        </button>
                    `;
                fileList.appendChild(fileItem);
            });
        }

        // Make removeFile function global
        window.removeFile = function(index) {
            selectedFiles.splice(index, 1);
            if (selectedFiles.length === 0) {
                uploadArea.style.display = 'block';
                uploadSuccess.style.display = 'none';
                fileInput.value = '';
            } else {
                displaySelectedFiles();
            }
        }

        // Reset upload area when modal is closed
        document.getElementById('resultsModal').addEventListener('hidden.bs.modal', function() {
            selectedFiles = [];
            uploadArea.style.display = 'block';
            uploadSuccess.style.display = 'none';
            fileInput.value = '';
            fileList.innerHTML = '';
        });
    });
</script>
</body>
</html>
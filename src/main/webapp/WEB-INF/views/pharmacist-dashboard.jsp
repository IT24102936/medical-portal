<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacist Dashboard - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    
    <link rel="stylesheet" href="/css/pharmacist-dashboard.css">
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
                        <small class="text-muted">Pharmacist Dashboard</small>
                    </div>
                </a>
                
                <!-- User Info & Logout -->
                <div class="d-flex align-items-center">
                    <div class="dropdown">
                        <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown">
                            <span class="material-symbols-outlined me-2">person</span>
                            <span class="d-none d-md-inline">Dr. John Smith</span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">
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
                        <h1 class="display-6 fw-bold text-dark-blue mb-2">🏥 Welcome Back, Dr. Smith!</h1>
                        <p class="lead text-secondary mb-3">Manage your pharmacy operations efficiently</p>
                        <div class="d-flex flex-wrap gap-3">
                            <div class="stat-item">
                                <span class="stat-number">${totalPrescriptions}</span>
                                <span class="stat-label">Total Prescriptions</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number">${totalItems}</span>
                                <span class="stat-label">Items in Stock</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number">${lowStockCount > 0 ? ((totalItems - lowStockCount) * 100 / totalItems) : 100}%</span>
                                <span class="stat-label">Stock Level</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Dashboard Cards -->
            <div class="row g-4 mb-5">
                
                <!-- Pharmacist Profile Card -->
                <div class="col-lg-6 col-xl-4">
                    <div class="dashboard-card h-100" data-bs-toggle="modal" data-bs-target="#profileModal" style="cursor: pointer;">
                        <div class="card-header">
                            <div class="icon-wrapper bg-primary">
                                <span class="material-symbols-outlined">person</span>
                            </div>
                            <h3 class="card-title">👨‍⚕️ My Profile</h3>
                        </div>
                        <div class="card-body">
                            <p class="card-description">View and update your personal information and contact details</p>
                            <div class="card-stats">
                                <div class="stat-row">
                                    <span class="stat-label">Employee ID:</span>
                                    <span class="stat-value">EMP001</span>
                                </div>
                                <div class="stat-row">
                                    <span class="stat-label">Position:</span>
                                    <span class="stat-value">Senior Pharmacist</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <span class="action-text">👆 Click to Manage Profile →</span>
                        </div>
                    </div>
                </div>

                <!-- Prescriptions Card -->
                <div class="col-lg-6 col-xl-4">
                    <div class="dashboard-card h-100" data-bs-toggle="modal" data-bs-target="#prescriptionsModal" style="cursor: pointer;">
                        <div class="card-header">
                            <div class="icon-wrapper bg-success">
                                <span class="material-symbols-outlined">receipt_long</span>
                            </div>
                            <h3 class="card-title">💊 Prescriptions</h3>
                        </div>
                        <div class="card-body">
                            <p class="card-description">View and process prescriptions received from doctors</p>
                            <div class="card-stats">
                                <div class="stat-row">
                                    <span class="stat-label">Total Prescriptions:</span>
                                    <span class="stat-value text-success">${totalPrescriptions}</span>
                                </div>
                                <div class="stat-row">
                                    <span class="stat-label">Inventory Items:</span>
                                    <span class="stat-value text-info">${totalItems}</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <span class="action-text">👆 Click to View Prescriptions →</span>
                        </div>
                    </div>
                </div>

                <!-- Inventory Card -->
                <div class="col-lg-6 col-xl-4">
                    <div class="dashboard-card h-100" data-bs-toggle="modal" data-bs-target="#inventoryModal" style="cursor: pointer;">
                        <div class="card-header">
                            <div class="icon-wrapper bg-info">
                                <span class="material-symbols-outlined">inventory_2</span>
                            </div>
                            <h3 class="card-title">📦 Inventory</h3>
                        </div>
                        <div class="card-body">
                            <p class="card-description">Manage medication stock levels and inventory</p>
                            <div class="card-stats">
                                <div class="stat-row">
                                    <span class="stat-label">Total Items:</span>
                                    <span class="stat-value">${totalItems}</span>
                                </div>
                                <div class="stat-row">
                                    <span class="stat-label">Low Stock:</span>
                                    <span class="stat-value text-danger">${lowStockCount}</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <span class="action-text">👆 Click to Manage Inventory →</span>
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
                    <h5 class="modal-title">👨‍⚕️ Pharmacist Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/pharmacist/profile/update">
                    <div class="modal-body">
                        <div class="row g-3">
                            <!-- Non-editable fields -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Employee ID</label>
                                <input type="text" class="form-control" value="EMP001" readonly>
                                <small class="text-muted">Cannot be modified</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Position</label>
                                <input type="text" class="form-control" value="Senior Pharmacist" readonly>
                                <small class="text-muted">Cannot be modified</small>
                            </div>
                            
                            <!-- Editable fields -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">First Name</label>
                                <input type="text" class="form-control" name="firstName" value="John" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Last Name</label>
                                <input type="text" class="form-control" name="lastName" value="Smith" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold">Address</label>
                                <textarea class="form-control" name="address" rows="3" required>123 Medical Center Drive, Healthcare District, City, State 12345</textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Contact Number</label>
                                <input type="tel" class="form-control" name="contactNumber" value="+1 (555) 123-4567" required>
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

    <!-- Prescriptions Modal -->
    <div class="modal fade" id="prescriptionsModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">💊 Prescriptions Management</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- Add New Prescription -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="action-text">💊 Prescription Management</span>
                        <div>
                            <a href="#addPrescriptionModal" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-dismiss="modal">
                                <span class="material-symbols-outlined me-1">add</span>Add New Prescription
                            </a>
                        </div>
                    </div>

                    <%-- Inside prescriptionsModal --%>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-primary">
                            <tr>
                                <th>Prescription ID</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="prescription" items="${prescriptions}">
                                <tr>
                                    <td>#RX${prescription.id}</td>
                                    <td>${prescription.description}</td>
                                    <td>
                                        <button class="btn btn-sm btn-info me-1" data-bs-toggle="modal" data-bs-target="#viewPrescriptionModal" 
                                                data-prescription-id="${prescription.id}" 
                                                data-prescription-desc="${prescription.description}">View Details</button>
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

    <!-- Inventory Modal -->
    <div class="modal fade" id="inventoryModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">📦 Inventory Management</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="input-group" style="max-width: 300px;">
                            <span class="input-group-text">
                                <span class="material-symbols-outlined">search</span>
                            </span>
                            <input type="text" class="form-control" placeholder="Search medications...">
                        </div>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addMedicineModal" data-bs-dismiss="modal">
                            <span class="material-symbols-outlined me-1">add</span>Add New Item
                        </button>
                    </div>

                    <%-- Inside inventoryModal --%>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-info">
                            <tr>
                                <th>Inventory ID</th>
                                <th>Description</th>
                                <th>Current Stock</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${inventory}">
                                <tr>
                                    <td>#INV${item.id}</td>
                                    <td>${item.description}</td>
                                    <td>${item.count}</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#editStockModal" 
                                                data-description="${item.description}" 
                                                data-id="${item.id}" 
                                                data-count="${item.count}">Edit Stock</button>
                                        <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#restockModal" 
                                                data-description="${item.description}" 
                                                data-id="${item.id}" 
                                                data-count="${item.count}">Restock</button>
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

    <!-- Add Medicine Modal -->
    <div class="modal fade" id="addMedicineModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">💊 Add New Inventory Item</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/pharmacist/inventory/add">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-bold">Description *</label>
                                <textarea class="form-control" name="description" rows="3" placeholder="Enter medicine description, usage, and instructions" required></textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Initial Stock Count *</label>
                                <input type="number" class="form-control" name="stockCount" min="0" placeholder="Enter initial quantity" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Pharmacist EID *</label>
                                <input type="number" class="form-control" name="pharmacistEid" value="1" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Medicine</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Restock Modal -->
    <div class="modal fade" id="restockModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">📦 Restock Inventory Item</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/pharmacist/inventory/restock">
                    <div class="modal-body">
                        <div class="alert alert-info">
                            <h6 class="fw-bold mb-2">Inventory Item Information</h6>
                            <div id="restockMedicineInfo"></div>
                        </div>
                        <input type="hidden" id="restockInventoryId" name="inventoryId">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Current Stock</label>
                            <input type="number" class="form-control" id="currentStock" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Add Quantity *</label>
                            <input type="number" class="form-control" name="additionalStock" min="1" placeholder="Enter quantity to add" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">Confirm Restock</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- View Prescription Modal -->
    <div class="modal fade" id="viewPrescriptionModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">📜 Prescription Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Prescription ID</label>
                            <input type="text" class="form-control" id="viewPrescriptionId" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Status</label>
                            <div class="form-check mt-2">
                                <input class="form-check-input" type="checkbox" id="fulfilledStatus" disabled>
                                <label class="form-check-label fw-bold text-success" for="fulfilledStatus">
                                    ✅ Mark as Fulfilled
                                </label>
                                <small class="d-block text-muted">Future functionality - not yet connected to backend</small>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Description</label>
                            <textarea class="form-control" id="viewPrescriptionDesc" rows="4" readonly></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <form method="post" id="deletePrescriptionForm" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this prescription? This action cannot be undone.')">
                        <button type="submit" class="btn btn-danger">
                            <span class="material-symbols-outlined me-1" style="font-size: 16px;">delete</span>
                            Delete Prescription
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit/Reduce Stock Modal -->
    <div class="modal fade" id="editStockModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">✏️ Edit Inventory Stock</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/pharmacist/inventory/reduce">
                    <div class="modal-body">
                        <div class="alert alert-warning">
                            <h6 class="fw-bold mb-2">Inventory Item Information</h6>
                            <div id="editMedicineInfo"></div>
                        </div>
                        <input type="hidden" id="editInventoryId" name="inventoryId">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Current Stock</label>
                            <input type="number" class="form-control" id="editCurrentStock" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Reduction Amount *</label>
                            <input type="number" class="form-control" name="reductionAmount" min="1" placeholder="Enter quantity to reduce" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Reason for Reduction</label>
                            <select class="form-select" name="reason" required>
                                <option value="">Select reason</option>
                                <option value="dispensed">Dispensed to Patient</option>
                                <option value="expired">Expired Medicine</option>
                                <option value="damaged">Damaged/Defective</option>
                                <option value="transfer">Transfer to Another Location</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-warning">Confirm Reduction</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Prescription Modal -->
    <div class="modal fade" id="addPrescriptionModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">💊 Add New Prescription</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="/pharmacist/prescription/add">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-bold">Prescription Description *</label>
                                <textarea class="form-control" name="description" rows="4" 
                                         placeholder="Enter prescription details (e.g., Aspirin 81mg, take one tablet daily with food.)" 
                                         required></textarea>
                                <small class="text-muted">Include medication name, dosage, and instructions</small>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Prescription</button>
                    </div>
                </form>
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

            // Handle prescription view modal
            const viewPrescriptionModal = document.getElementById('viewPrescriptionModal');
            if (viewPrescriptionModal) {
                viewPrescriptionModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const prescriptionId = button.getAttribute('data-prescription-id');
                    const prescriptionDesc = button.getAttribute('data-prescription-desc');

                    document.getElementById('viewPrescriptionId').value = '#RX' + prescriptionId;
                    document.getElementById('viewPrescriptionDesc').value = prescriptionDesc;
                    
                    // Set up delete form action
                    const deleteForm = document.getElementById('deletePrescriptionForm');
                    deleteForm.action = '/pharmacist/prescription/delete/' + prescriptionId;
                });
            }

            // Handle restock modal
            const restockModal = document.getElementById('restockModal');
            if (restockModal) {
                restockModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const medicineId = button.getAttribute('data-id');
                    const description = button.getAttribute('data-description');
                    const currentStock = button.getAttribute('data-count');

                    document.getElementById('restockInventoryId').value = medicineId;
                    document.getElementById('currentStock').value = currentStock;
                    document.getElementById('restockMedicineInfo').innerHTML =
                        '<strong>Item:</strong> ' + description + '<br><strong>Current Stock:</strong> ' + currentStock;
                });
            }

            // Handle edit stock modal
            const editStockModal = document.getElementById('editStockModal');
            if (editStockModal) {
                editStockModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const medicineId = button.getAttribute('data-id');
                    const description = button.getAttribute('data-description');
                    const currentStock = button.getAttribute('data-count');

                    document.getElementById('editInventoryId').value = medicineId;
                    document.getElementById('editCurrentStock').value = currentStock;
                    document.getElementById('editMedicineInfo').innerHTML =
                        '<strong>Item:</strong> ' + description + '<br><strong>Current Stock:</strong> ' + currentStock;
                });
            }
        });
    </script>
</body>
</html>
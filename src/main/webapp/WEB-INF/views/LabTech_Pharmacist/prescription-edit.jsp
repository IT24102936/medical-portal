<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Prescription - Medisphere</title>
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
            border-bottom: 3px solid #ffc107;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
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
                <a href="/pharmacist/prescription/view/${prescription.id}" class="btn btn-outline-primary">
                    <span class="material-symbols-outlined me-2" style="font-size: 20px; vertical-align: middle;">arrow_back</span>
                    Back to Details
                </a>
            </div>
        </nav>
    </header>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Flash Messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                </c:if>

                <div class="prescription-card">
                    <div class="header-section">
                        <h2 class="mb-2">
                            <span class="material-symbols-outlined" style="font-size: 2rem; vertical-align: middle; color: #ffc107;">edit</span>
                            Edit Prescription
                        </h2>
                        <p class="text-muted mb-0">Update prescription description and details</p>
                    </div>

                    <form method="post" action="/pharmacist/prescription/update">
                        <input type="hidden" name="prescriptionId" value="${prescription.id}">
                        
                        <div class="alert alert-info mb-4">
                            <strong><span class="material-symbols-outlined" style="vertical-align: middle; font-size: 20px;">info</span> Important:</strong> 
                            Doctor and Patient information cannot be changed after prescription creation.
                        </div>

                        <!-- Read-only Information -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Prescription ID</label>
                                <input type="text" class="form-control" value="#RX${prescription.id}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Patient Name</label>
                                <input type="text" class="form-control" value="${not empty prescriptionDetails ? prescriptionDetails.patient.firstName : 'N/A'} ${not empty prescriptionDetails ? prescriptionDetails.patient.lastName : ''}" readonly>
                            </div>
                        </div>

                        <!-- Editable Field -->
                        <div class="mb-4">
                            <label class="form-label fw-bold">Prescription Description *</label>
                            <textarea class="form-control" name="description" rows="6" required 
                                      placeholder="Enter medication name, dosage, and instructions">${prescription.description}</textarea>
                            <small class="text-muted">Include complete medication information, dosage, and patient instructions</small>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between">
                            <a href="/pharmacist/prescription/view/${prescription.id}" class="btn btn-secondary">
                                <span class="material-symbols-outlined me-1" style="font-size: 18px; vertical-align: middle;">cancel</span>
                                Cancel
                            </a>
                            <button type="submit" class="btn btn-warning">
                                <span class="material-symbols-outlined me-1" style="font-size: 18px; vertical-align: middle;">save</span>
                                Update Prescription
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

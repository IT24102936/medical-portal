<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medisphere - Doctor Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin-Doctor_management.css" />
    <meta name="context-path" content="${pageContext.request.contextPath}" />
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    
    <style>
        .is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
        }
        .doctor-avatar-large {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto;
        }
        .doctor-avatar-large img {
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
                    <li class="nav-item"><a class="nav-link" href="/admin/patients">Patients</a></li>
                    <li class="nav-item"><a class="nav-link active" href="/admin/doctors">Doctors</a></li>
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
            <!-- Error and Success Messages -->
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error!</strong> ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> ${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-5">
                <h1 class="h2 fw-bold mb-3 mb-sm-0">Doctor Management</h1>
                <button class="btn btn-primary d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#addDoctorModal">
                    <span class="material-symbols-outlined"> add </span>
                    Add New Doctor
                </button>
            </div>

            <div class="mb-5 d-flex justify-content-start">
                <div class="w-100" style="max-width: 24rem;">
                    <div class="search-input-container">
                        <span class="material-symbols-outlined"> search </span>
                        <input class="form-control" id="doctorSearchInput" placeholder="Search doctors by name, specialization..." type="search" />
                    </div>
                </div>
            </div>

            <div class="card shadow-sm overflow-hidden">
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead>
                        <tr>
                            <th class="px-4 py-3">Doctor</th>
                            <th class="px-4 py-3">Specialization</th>
                            <th class="px-4 py-3">Contact</th>
                            <th class="px-4 py-3">Status</th>
                            <th class="px-4 py-3">Actions</th>
                        </tr>
                        </thead>
                        <tbody id="doctorTableBody">
                        <c:forEach var="doctor" items="${doctors}">
                            <tr>
                                <td class="px-4 py-3">
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="profile-image rounded-circle" style="background-image: url('<c:choose><c:when test="${not empty doctor.employee and doctor.employee.gender == 'Female'}">/img/female-doc.png</c:when><c:otherwise>/img/doctor.png</c:otherwise></c:choose>'); width: 40px; height: 40px; background-size: cover;"></div>
                                        <span>Dr. ${doctor.employee.firstName} ${doctor.employee.lastName}</span>
                                    </div>
                                </td>
                                <td class="px-4 py-3">${doctor.specialization}</td>
                                <td class="px-4 py-3">${doctor.employee.email}</td>
                                <td class="px-4 py-3">
                                    <span class="status-badge ${doctor.employee.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">
                                            ${doctor.employee.status}
                                    </span>
                                </td>
                                <td class="px-4 py-3">
                                    <div class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center gap-2">
                                        <button class="btn btn-outline-secondary btn-action btn-action-edit" data-eid="${doctor.eid}" data-salary="${doctor.employee.salary}">
                                            <span class="material-symbols-outlined">edit</span> Edit
                                        </button>
                                        <c:choose>
                                            <c:when test="${doctor.employee.status == 'ACTIVE'}">
                                                <button type="button" class="btn btn-professional-disable btn-action btn-action-disable" data-eid="${doctor.eid}">
                                                    <span class="material-symbols-outlined">block</span> Disable
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-professional-enable btn-action btn-action-enable" data-eid="${doctor.eid}">
                                                    <span class="material-symbols-outlined">check_circle</span> Enable
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                        <button class="btn btn-outline-danger btn-action btn-action-delete" data-eid="${doctor.eid}">
                                            <span class="material-symbols-outlined">delete</span> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Edit Doctor Modal -->
    <div class="modal fade" id="editDoctorModal" tabindex="-1" aria-labelledby="editDoctorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editDoctorModalLabel">Edit Doctor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editDoctorForm" method="post">
                        <input type="hidden" name="eid" value="">
                        <!-- Avatar Section -->
                        <div class="text-center mb-4">
                            <div class="doctor-avatar-large mx-auto mb-3" id="doctorAvatar">
                                <img src="" alt="Doctor Avatar" class="img-fluid rounded-circle" style="width: 120px; height: 120px; object-fit: cover;">
                            </div>
                            <h4 class="text-muted"><b>Doctor Profile</b></h4>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input type="text" class="form-control" id="phone" name="phone">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" name="dob">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nationalId" class="form-label">National ID</label>
                                    <input type="text" class="form-control" id="nationalId" name="nationalId">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userName" class="form-label">Username <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="userName" name="userName" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="password" class="form-label">New Password (optional)</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Leave blank to keep current">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="salary" class="form-label">Salary</label>
                                    <input type="number" step="0.01" class="form-control" id="salary" name="salary" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="ACTIVE">ACTIVE</option>
                                        <option value="DISABLED">DISABLED</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="specialization" class="form-label">Specialization</label>
                            <input type="text" class="form-control" id="specialization" name="specialization" required>
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Doctor Modal -->
    <div class="modal fade" id="addDoctorModal" tabindex="-1" aria-labelledby="addDoctorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addDoctorModalLabel">Add New Doctor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addDoctorForm" method="post" action="${pageContext.request.contextPath}/admin/doctors/add">
                        <!-- Avatar Section -->
                        <div class="text-center mb-4">
                            <div class="doctor-avatar-large mx-auto mb-3">
                                <img src="${pageContext.request.contextPath}/img/doctor.png" alt="Doctor Avatar" class="img-fluid rounded-circle" style="width: 120px; height: 120px; object-fit: cover;">
                            </div>
                            <h4 class="text-muted"><b>New Doctor Profile</b></h4>
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
                                    <label for="addPhone" class="form-label">Phone</label>
                                    <input type="text" class="form-control" id="addPhone" name="phone">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="addGender" class="form-label">Gender <span class="text-danger">*</span></label>
                                    <select class="form-select" id="addGender" name="gender" required>
                                        <option value="">Select Gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="addDob" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="addDob" name="dob">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="addNationalId" class="form-label">National ID</label>
                                    <input type="text" class="form-control" id="addNationalId" name="nationalId">
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

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="addSalary" class="form-label">Salary <span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control" id="addSalary" name="salary" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="addSpecialization" class="form-label">Specialization <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="addSpecialization" name="specialization" required>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add Doctor</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer class="mt-auto border-top bg-white py-4">
        <div class="container">
            <p class="text-center text-muted small mb-0">© 2025 Medisphere. All rights reserved.</p>
        </div>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/Admin-Doctor_management.js"></script>
</body>
</html>
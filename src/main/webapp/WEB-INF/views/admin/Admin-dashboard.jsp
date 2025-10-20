<!-- src/main/webapp/WEB-INF/views/admin/Admin-dashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medisphere - Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link href="/css/Admin-dashboard.css" rel="stylesheet" />
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
                    <li class="nav-item"><a class="nav-link active" href="#">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/appointments">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/patients">Patients</a></li>
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

    <main class="flex-grow-1 p-4 p-md-5">
        <div class="container-xxl">
            <div class="row g-4 g-lg-5">
                <div class="col-lg-8">
                    <div class="d-flex flex-column gap-5">
                        <h2 class="fw-bold" style="font-size: 1.875rem;">Welcome back, Admin</h2>

                        <div class="row g-4">
                            <div class="col-12 col-sm-6 col-xl-4">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Total Patient</p>
                                        <p class="h3 fw-bold mt-2">${totalPatients}</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+10%</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-xl-4">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Today's Appointments</p>
                                        <p class="h3 fw-bold mt-2">${todayAppointments}</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+5%</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-xl-4">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Total Doctors</p>
                                        <p class="h3 fw-bold mt-2">${totalDoctors}</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+8%</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex flex-column gap-3">
                            <h3 class="h5 fw-bold">Quick Links</h3>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <a href="/admin/patients" class="card shadow-sm h-100 text-decoration-none">
                                        <div class="card-body d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-primary bg-opacity-10 p-3">
                                                <span class="material-symbols-outlined text-primary">groups</span>
                                            </div>
                                            <div>
                                                <h4 class="h6 fw-bold mb-1">Patient Management</h4>
                                                <p class="text-muted small mb-0">Manage all patients</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-6">
                                    <a href="/admin/doctors" class="card shadow-sm h-100 text-decoration-none">
                                        <div class="card-body d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-success bg-opacity-10 p-3">
                                                <span class="material-symbols-outlined text-success">medical_information</span>
                                            </div>
                                            <div>
                                                <h4 class="h6 fw-bold mb-1">Doctor Management</h4>
                                                <p class="text-muted small mb-0">Manage all doctors</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-6">
                                    <a href="/admin/employees" class="card shadow-sm h-100 text-decoration-none">
                                        <div class="card-body d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-info bg-opacity-10 p-3">
                                                <span class="material-symbols-outlined text-info">badge</span>
                                            </div>
                                            <div>
                                                <h4 class="h6 fw-bold mb-1">Employee Management</h4>
                                                <p class="text-muted small mb-0">Manage all employees</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-md-6">
                                    <a href="/admin/appointments" class="card shadow-sm h-100 text-decoration-none">
                                        <div class="card-body d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-warning bg-opacity-10 p-3">
                                                <span class="material-symbols-outlined text-warning">calendar_month</span>
                                            </div>
                                            <div>
                                                <h4 class="h6 fw-bold mb-1">Appointments</h4>
                                                <p class="text-muted small mb-0">Manage appointments</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex flex-column gap-3">
                            <h3 class="h5 fw-bold">Today's Appointments</h3>
                            <table class="table align-middle">
                                <thead>
                                <tr>
                                    <th class="px-4 py-3">Patient Name</th>
                                    <th class="px-4 py-3">Doctor Name</th>
                                    <th class="px-4 py-3">Doctor Specialization</th>
                                    <th class="px-4 py-3">Time</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="appointment" items="${appointments}">
                                    <tr>
                                        <td class="px-4 py-3 fw-medium">${appointment.patient_name}</td>
                                        <td class="px-4 py-3 text-muted">${appointment.doctor_name}</td>
                                        <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-red-light px-3 py-2">${appointment.doctor_specialization}</span></td>
                                        <td class="px-4 py-3 text-muted">${appointment.appointment_time_formatted}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty appointments}">
                                    <tr>
                                        <td colspan="4" class="px-4 py-3 text-center text-muted">No appointments scheduled for today</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                            <div class="d-flex justify-content-end mt-2">
                                <nav aria-label="Appointment navigation">
                                    <ul class="pagination">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="/admin/appointments">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <aside class="d-flex flex-column gap-5">
                        <h3 class="h5 fw-bold">Appointment Analytics</h3>
                        <div class="card shadow-sm">
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <p class="small text-muted fw-medium">Appointments by Doctor Specialization</p>
                                        <p class="h4 fw-bold mt-1">${totalAppointments}</p>
                                    </div>
                                    
                                </div>
                                <div class="chart-container mx-auto" style="height: 140px; max-width: 140px;">
                                    <canvas id="appointmentsByTypeChart"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="card shadow-sm">
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <p class="small text-muted fw-medium">Appointment Trends</p>
                                        <p class="h4 fw-bold mt-1">${totalAppointments}</p>
                                    </div>
                                    
                                </div>
                                <div class="chart-container" style="height: 200px;">
                                    <canvas id="appointmentTrendsChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </aside>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/Admin-dashboard.js"></script>
</body>
</html>
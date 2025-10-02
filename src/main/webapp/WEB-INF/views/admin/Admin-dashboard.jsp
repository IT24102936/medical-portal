<!-- src/main/webapp/WEB-INF/views/admin/Admin-dashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                    <li class="nav-item"><a class="nav-link" href="#">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Employees</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Reports</a></li>
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
                        <h2 class="fw-bold" style="font-size: 1.875rem;">Welcome back, Pasindu Samarasingha</h2>

                        <div class="row g-4">
                            <div class="col-12 col-sm-6 col-xl-3">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Total Patient</p>
                                        <p class="h3 fw-bold mt-2">1,250</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+10%</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-xl-3">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Today's Appointments</p>
                                        <p class="h3 fw-bold mt-2">12</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+5%</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-xl-3">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Total Doctors</p>
                                        <p class="h3 fw-bold mt-2">28</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+8%</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-xl-3">
                                <div class="card shadow-sm h-100">
                                    <div class="card-body">
                                        <p class="text-muted small fw-medium">Monthly Revenue</p>
                                        <p class="h3 fw-bold mt-2">$25,000</p>
                                        <p class="small fw-medium text-success mb-0 mt-1">+12%</p>
                                    </div>
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
                                <tr>
                                    <td class="px-4 py-3 fw-medium">Sophia Clark</td>
                                    <td class="px-4 py-3 text-muted">Dr. Emily White</td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-red-light px-3 py-2">Cardiology</span></td>
                                    <td class="px-4 py-3 text-muted">9:00 AM</td>
                                </tr>
                                <tr>
                                    <td class="px-4 py-3 fw-medium">Ethan Bennett</td>
                                    <td class="px-4 py-3 text-muted">Dr. James Green</td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-yellow-light px-3 py-2">Dermatology</span></td>
                                    <td class="px-4 py-3 text-muted">10:30 AM</td>
                                </tr>
                                <tr>
                                    <td class="px-4 py-3 fw-medium">Olivia Carter</td>
                                    <td class="px-4 py-3 text-muted">Dr. Olivia Blue</td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-green-light px-3 py-2">Pediatrics</span></td>
                                    <td class="px-4 py-3 text-muted">1:00 PM</td>
                                </tr>
                                <tr>
                                    <td class="px-4 py-3 fw-medium">Liam Davis</td>
                                    <td class="px-4 py-3 text-muted">Dr. Benjamin Gray</td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-blue-light px-3 py-2">Neurology</span></td>
                                    <td class="px-4 py-3 text-muted">2:30 PM</td>
                                </tr>
                                <tr>
                                    <td class="px-4 py-3 fw-medium">Ava Evans</td>
                                    <td class="px-4 py-3 text-muted">Dr. Ava Black</td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-purple-light px-3 py-2">Oncology</span></td>
                                    <td class="px-4 py-3 text-muted">4:00 PM</td>
                                </tr>
                                <tr>
                                    <td class="px-4 py-3 fw-medium">Noah Wilson</td>
                                    <td class="px-4 py-3 text-muted">Dr. Lucas Crimson</td>
                                    <td class="px-4 py-3"><span class="badge rounded-pill fw-medium bg-teal-light px-3 py-2">Orthopedics</span></td>
                                    <td class="px-4 py-3 text-muted">4:15 PM</td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="d-flex justify-content-end mt-2">
                                <nav aria-label="Appointment navigation">
                                    <ul class="pagination">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">Next</a>
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
                                        <p class="h4 fw-bold mt-1">120</p>
                                    </div>
                                    <div class="d-flex align-items-center gap-1 small fw-medium text-success">
                                        <span class="material-symbols-outlined" style="font-size: 1rem;"> trending_up </span>
                                        <span>+15%</span>
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
                                        <p class="h4 fw-bold mt-1">250</p>
                                    </div>
                                    <div class="d-flex align-items-center gap-1 small fw-medium text-success">
                                        <span class="material-symbols-outlined" style="font-size: 1rem;"> trending_up </span>
                                        <span>+10%</span>
                                    </div>
                                </div>
                                <div class="chart-container">
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
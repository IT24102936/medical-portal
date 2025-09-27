<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medisphere - Appointments</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="stylesheet" href="/css/Admin-appointments.css" />
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
                    <li class="nav-item"><a class="nav-link" href="#">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">Appointments</a></li>
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

    <main class="flex-grow-1 p-4 p-lg-5">
        <div class="container-xl">
            <h1 class="h2 fw-bold mb-4">Appointments</h1>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link" id="nav-past-tab" data-bs-toggle="tab" data-bs-target="#nav-past" type="button" role="tab" aria-controls="nav-past" aria-selected="false">Past</button>
                    <button class="nav-link active" id="nav-upcoming-tab" data-bs-toggle="tab" data-bs-target="#nav-upcoming" type="button" role="tab" aria-controls="nav-upcoming" aria-selected="true">Upcoming</button>
                    <button class="nav-link" id="nav-canceled-tab" data-bs-toggle="tab" data-bs-target="#nav-canceled" type="button" role="tab" aria-controls="nav-canceled" aria-selected="false">Canceled</button>
                </div>
            </nav>

            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade" id="nav-past" role="tabpanel" aria-labelledby="nav-past-tab">
                    <div class="py-4">
                        <div class="card shadow-sm overflow-hidden">
                            <div class="table-responsive">
                                <table class="table align-middle mb-0">
                                    <thead>
                                    <tr>
                                        <th class="p-3">Doctor Name</th>
                                        <th class="p-3">Patient Name</th>
                                        <th class="p-3">Date</th>
                                        <th class="p-3">Status</th>
                                        <th class="p-3"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="p-3 fw-medium">Dr. Emily White</td>
                                        <td class="p-3 fw-medium">Sophia Clark</td>
                                        <td class="p-3 text-muted">2025-09-15</td>
                                        <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-completed px-2 py-1">Completed</span></td>
                                        <td class="p-3 text-end"><button class="btn btn-sm btn-outline-secondary">View Details</button></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade show active" id="nav-upcoming" role="tabpanel" aria-labelledby="nav-upcoming-tab">
                    <div class="py-4">
                        <div class="row g-3 align-items-end mb-4">
                            <div class="col-sm-6 col-lg-3">
                                <label class="form-label small" for="doctor-name-filter">Doctor Name</label>
                                <input type="text" class="form-control" id="doctor-name-filter" placeholder="e.g., Dr. White">
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <label class="form-label small" for="patient-name-filter">Patient Name</label>
                                <input type="text" class="form-control" id="patient-name-filter" placeholder="e.g., Sophia Clark">
                            </div>
                            <div class="col-sm-6 col-lg-4">
                                <div class="row g-3">
                                    <div class="col">
                                        <label class="form-label small" for="start-date-filter">Start Date</label>
                                        <input type="date" class="form-control" id="start-date-filter">
                                    </div>
                                    <div class="col">
                                        <label class="form-label small" for="end-date-filter">End Date</label>
                                        <input type="date" class="form-control" id="end-date-filter">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-2">
                                <button class="btn btn-secondary w-100" id="clearFilters">Clear</button>
                            </div>
                        </div>

                        <div class="card shadow-sm overflow-hidden">
                            <div class="table-responsive">
                                <table class="table align-middle mb-0">
                                    <thead>
                                    <tr>
                                        <th class="p-3">Doctor Name</th>
                                        <th class="p-3">Doctor Specialization</th>
                                        <th class="p-3">Patient Name</th>
                                        <th class="p-3">Date</th>
                                        <th class="p-3">Time</th>
                                        <th class="p-3">Status</th>
                                        <th class="p-3"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="upcomingAppointmentsBody">
                                    <tr>
                                        <td class="p-3 fw-medium">Dr. Emily White</td>
                                        <td class="p-3 text-muted">Cardiology</td>
                                        <td class="p-3 fw-medium">Sophia Clark</td>
                                        <td class="p-3 text-muted">2025-09-25</td>
                                        <td class="p-3 text-muted">10:00 AM</td>
                                        <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-scheduled px-2 py-1">Scheduled</span></td>
                                        <td class="p-3 text-end"><button class="btn btn-sm btn-outline-danger">Cancel</button></td>
                                    </tr>
                                    <tr>
                                        <td class="p-3 fw-medium">Dr. James Green</td>
                                        <td class="p-3 text-muted">Dermatology</td>
                                        <td class="p-3 fw-medium">Ethan Bennett</td>
                                        <td class="p-3 text-muted">2025-09-26</td>
                                        <td class="p-3 text-muted">11:30 AM</td>
                                        <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-scheduled px-2 py-1">Scheduled</span></td>
                                        <td class="p-3 text-end"><button class="btn btn-sm btn-outline-danger">Cancel</button></td>
                                    </tr>
                                    <tr>
                                        <td class="p-3 fw-medium">Dr. Olivia Blue</td>
                                        <td class="p-3 text-muted">Pediatrics</td>
                                        <td class="p-3 fw-medium">Olivia Carter</td>
                                        <td class="p-3 text-muted">2025-10-02</td>
                                        <td class="p-3 text-muted">09:00 AM</td>
                                        <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-scheduled px-2 py-1">Scheduled</span></td>
                                        <td class="p-3 text-end"><button class="btn btn-sm btn-outline-danger">Cancel</button></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="nav-canceled" role="tabpanel" aria-labelledby="nav-canceled-tab">
                    <div class="py-4">
                        <div class="card shadow-sm overflow-hidden">
                            <div class="table-responsive">
                                <table class="table align-middle mb-0">
                                    <thead>
                                    <tr>
                                        <th class="p-3">Doctor Name</th>
                                        <th class="p-3">Patient Name</th>
                                        <th class="p-3">Original Date</th>
                                        <th class="p-3">Status</th>
                                        <th class="p-3"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="p-3 fw-medium">Dr. Benjamin Gray</td>
                                        <td class="p-3 fw-medium">Liam Davis</td>
                                        <td class="p-3 text-muted">2025-09-18</td>
                                        <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-canceled px-2 py-1">Canceled</span></td>
                                        <td class="p-3 text-end"><button class="btn btn-sm btn-outline-danger">Delete</button></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
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
<script src="/js/Admin-appointments.js"></script>
</body>
</html>
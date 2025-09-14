<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medisphere - Receptionist Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            /* Light Theme Variables */
            --primary-50: #eff8ff;
            --primary-100: #dff0ff;
            --primary-200: #b9e2ff;
            --primary-300: #85d2ff;
            --primary-400: #4cbaff;
            --primary-500: #219fff;
            --primary-600: #0a87ff;
            --primary-700: #0075e3;
            --primary-800: #0260b8;
            --primary-900: #094f95;
            --primary-950: #0c335e;

            --bs-body-bg: #f8f9fa;
            --bs-body-color: #343a40;
            --bs-navbar-bg: #ffffff;
            --bs-card-bg: #ffffff;
            --bs-card-border-color: #dee2e6;
            --bs-text-muted: #6c757d;
            --bs-border-color: #e5e7eb;
            --bs-primary-rgb: 0, 117, 227;

            /* Dark Theme Variables */
            --dark-bg: #111827;
            --dark-body-color: #e2e8f0;
            --dark-navbar-bg: #1f2937;
            --dark-card-bg: #1f2937;
            --dark-card-border-color: #374151;
            --dark-text-muted: #9ca3af;
            --dark-border-color: #374151;
        }

        body {
            font-family: Inter, "Noto Sans", sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Dark Theme Styles */
        body.dark-theme {
            --bs-body-bg: var(--dark-bg);
            --bs-body-color: var(--dark-body-color);
            --bs-navbar-bg: var(--dark-navbar-bg);
            --bs-card-bg: var(--dark-card-bg);
            --bs-card-border-color: var(--dark-card-border-color);
            --bs-text-muted: var(--dark-text-muted);
            --bs-border-color: var(--dark-border-color);
        }

        body.dark-theme .navbar,
        body.dark-theme footer {
            background-color: var(--dark-navbar-bg) !important;
            border-color: var(--dark-card-border-color) !important;
        }

        body.dark-theme footer p {
            color: var(--dark-text-muted);
        }

        body.dark-theme .navbar-brand span,
        body.dark-theme .main-nav .nav-link {
            color: var(--dark-body-color) !important;
        }
        body.dark-theme .main-nav .nav-link:hover { color: var(--primary-400) !important; }
        body.dark-theme .main-nav .nav-link.active { color: var(--primary-400) !important; }

        body.dark-theme .btn-icon {
            color: var(--dark-body-color) !important;
            --bs-btn-hover-bg: var(--dark-card-border-color) !important;
            border-color: var(--dark-card-border-color) !important;
        }

        body.dark-theme .form-control {
            background-color: var(--dark-card-bg);
            border-color: var(--dark-card-border-color);
            color: var(--dark-body-color);
        }
        body.dark-theme .form-control::placeholder {
            color: var(--dark-text-muted);
        }

        body.dark-theme .table {
            --bs-table-bg: var(--dark-card-bg);
            --bs-table-border-color: var(--dark-border-color);
            color: var(--dark-body-color);
        }
        body.dark-theme thead {
            background-color: transparent;
        }
        body.dark-theme .table th {
            color: var(--dark-body-color);
        }

        body.dark-theme .table td.text-muted { color: var(--dark-text-muted) !important; }

        body.dark-theme .nav-tabs {
            --bs-nav-tabs-border-color: var(--dark-border-color);
        }
        body.dark-theme .nav-tabs .nav-link {
            color: var(--dark-text-muted);
            border-bottom-color: transparent;
        }
        body.dark-theme .nav-tabs .nav-link.active {
            color: var(--primary-400);
            border-color: var(--dark-border-color) var(--dark-border-color) var(--primary-400);
            background: transparent;
        }

        body.dark-theme .list-group-item {
            background-color: var(--dark-card-bg);
            border-color: var(--dark-border-color);
        }

        /* General Component Styles */
        .main-nav .nav-link { font-size: 0.9rem; color: #4b5563; font-weight: 500; }
        .main-nav .nav-link:hover { color: #111827; }
        .main-nav .nav-link.active { color: var(--primary-700); font-weight: 600; }

        @media (min-width: 992px) {
            .navbar-nav.main-nav { flex: 1; justify-content: center; }
        }

        .profile-image { width: 40px; height: 40px; background-size: cover; background-position: center; }
        .dropdown-item .material-symbols-outlined { vertical-align: bottom; font-size: 1.25rem; }
        .profile-dropdown-toggle::after { display: none; }

        #themeToggle.btn-icon {
            border: 1px solid var(--bs-border-color);
            border-radius: 0.375rem;
            width: 40px;
            height: 40px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .form-control:focus {
            border-color: var(--primary-700);
            box-shadow: 0 0 0 .25rem rgba(var(--bs-primary-rgb), 0.25);
        }

        .nav-tabs {
            --bs-nav-tabs-border-width: 2px;
            --bs-nav-tabs-link-active-border-color: var(--primary-700);
        }
        .nav-tabs .nav-link {
            color: var(--bs-text-muted);
            font-weight: 500;
        }
        .nav-tabs .nav-link.active {
            color: var(--primary-700);
            font-weight: 700;
        }

        /* Custom Status Badges */
        .badge.bg-status-scheduled { background-color: #dcfce7 !important; color: #166534 !important; }
        .badge.bg-status-completed { background-color: #e5e7eb !important; color: #374151 !important; }
        .badge.bg-status-canceled { background-color: #fee2e2 !important; color: #991b1b !important; }

        body.dark-theme .badge.bg-status-scheduled { background-color: #166534 !important; color: #dcfce7 !important; }
        body.dark-theme .badge.bg-status-completed { background-color: #4b5563 !important; color: #d1d5db !important; }
        body.dark-theme .badge.bg-status-canceled { background-color: #991b1b !important; color: #fee2e2 !important; }

        .stat-card-icon {
            font-size: 2.5rem;
            color: var(--primary-700);
            opacity: 0.7;
        }
    </style>
</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<div class="d-flex flex-column flex-grow-1">
    <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm px-4">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${contextPath}/receptionist/dashboard" style="gap: 0.75rem;">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 48px;">
                <span class="h4 mb-0" style="letter-spacing: -0.02em; font-weight: 900; font-family: 'Inter', sans-serif;">Medisphere</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav main-nav" style="gap: 1rem;">
                    <li class="nav-item"><a class="nav-link active" href="${contextPath}/receptionist/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/receptionist/appointments">Appointment</a></li>
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/receptionist/patients">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/receptionist/doctors-availability">Doctors availability</a></li>
                </ul>

                <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0">
                    <button class="btn btn-icon" id="themeToggle" style="color: #6c757d; --bs-btn-hover-bg: #f8f9fa; --bs-btn-hover-color: #343a40;">
                        <span class="material-symbols-outlined" id="themeIcon"> dark_mode </span>
                    </button>

                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle profile-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            <c:set var="profileImg" value="${not empty receptionist.profileImageUrl ? receptionist.profileImageUrl : 'https://via.placeholder.com/40'}" />
                            <div class="rounded-circle profile-image" style="background-image: url('${profileImg}');"></div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item d-flex align-items-center gap-2" href="${contextPath}/logout">
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
            <div class="mb-4">
                <h1 class="h2 fw-bold mb-0">Receptionist Dashboard</h1>
                <p class="text-muted">Welcome back, <c:out value="${receptionist.name}" default="User"/>!</p>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-6 col-xl-3">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body d-flex align-items-center">
                            <i class="bi bi-calendar-check stat-card-icon me-3"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">Today's Appointments</h6>
                                <h4 class="card-title fw-bold mt-1"><c:out value="${stats.todayAppointments}" default="0"/></h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body d-flex align-items-center">
                            <i class="bi bi-calendar-event stat-card-icon me-3"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">Upcoming (Week)</h6>
                                <h4 class="card-title fw-bold mt-1"><c:out value="${stats.upcomingAppointments}" default="0"/></h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body d-flex align-items-center">
                            <i class="bi bi-person-plus stat-card-icon me-3"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">New Patients (Month)</h6>
                                <h4 class="card-title fw-bold mt-1"><c:out value="${stats.newPatients}" default="0"/></h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body d-flex align-items-center">
                            <i class="bi bi-heart-pulse stat-card-icon me-3"></i>
                            <div>
                                <h6 class="card-subtitle text-muted">Total Doctors</h6>
                                <h4 class="card-title fw-bold mt-1"><c:out value="${stats.totalDoctors}" default="0"/></h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-lg-8">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-header bg-light">
                            <h5 class="mb-0">Today's Appointments</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table align-middle mb-0">
                                    <thead>
                                    <tr>
                                        <th>Time</th>
                                        <th>Patient</th>
                                        <th>Doctor</th>
                                        <th>Status</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="appt" items="${todaysAppointments}">
                                        <tr>
                                            <td class="fw-medium"><c:out value="${appt.time}"/></td>
                                            <td><c:out value="${appt.patientName}"/></td>
                                            <td class="text-muted"><c:out value="${appt.doctorName}"/></td>
                                            <td><span class="badge rounded-pill fw-medium bg-status-scheduled px-2 py-1">Scheduled</span></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty todaysAppointments}">
                                        <tr><td colspan="4" class="text-center p-4">No appointments scheduled for today.</td></tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-header bg-light">
                            <h5 class="mb-0">Appointments This Week</h5>
                        </div>
                        <div class="card-body d-flex align-items-center justify-content-center">
                            <canvas id="appointmentChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-header bg-light">
                            <h5 class="mb-0">Quick Actions</h5>
                        </div>
                        <div class="card-body text-center p-4">
                            <a href="${contextPath}/receptionist/create-appointment" class="btn btn-primary btn-lg mb-2 w-100">
                                <i class="bi bi-plus-circle me-2"></i>Create New Appointment
                            </a>
                            <a href="${contextPath}/receptionist/patients" class="btn btn-outline-primary btn-lg w-100">
                                <i class="bi bi-person-plus me-2"></i>Register New Patient
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-header bg-light">
                            <h5 class="mb-0">Recent Activity</h5>
                        </div>
                        <div class="card-body p-2">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="activity" items="${recentActivities}">
                                    <li class="list-group-item">${activity.description}</li>
                                </c:forEach>
                                <c:if test="${empty recentActivities}">
                                    <li class="list-group-item text-center text-muted">No recent activities.</li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <hr class="my-5">

            <h2 class="h3 fw-bold mb-4">Detailed Appointment Lists</h2>
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
                                    <c:forEach var="appt" items="${pastAppointments}">
                                        <tr>
                                            <td class="p-3 fw-medium"><c:out value="${appt.doctorName}" /></td>
                                            <td class="p-3 fw-medium"><c:out value="${appt.patientName}" /></td>
                                            <td class="p-3 text-muted"><c:out value="${appt.date}" /></td>
                                            <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-completed px-2 py-1">Completed</span></td>
                                            <td class="p-3 text-end"><button class="btn btn-sm btn-outline-secondary">View Details</button></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty pastAppointments}">
                                        <tr><td colspan="5" class="text-center p-4">No past appointments found.</td></tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade show active" id="nav-upcoming" role="tabpanel" aria-labelledby="nav-upcoming-tab">
                    <div class="py-4">
                        <div class="card shadow-sm overflow-hidden">
                            <div class="table-responsive">
                                <table class="table align-middle mb-0">
                                    <thead>
                                    <tr>
                                        <th class="p-3">Doctor Name</th>
                                        <th class="p-3">Patient Name</th>
                                        <th class="p-3">Date</th>
                                        <th class="p-3">Time</th>
                                        <th class="p-3">Status</th>
                                        <th class="p-3"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="appt" items="${upcomingAppointments}">
                                        <tr>
                                            <td class="p-3 fw-medium"><c:out value="${appt.doctorName}" /></td>
                                            <td class="p-3 fw-medium"><c:out value="${appt.patientName}" /></td>
                                            <td class="p-3 text-muted"><c:out value="${appt.date}" /></td>
                                            <td class="p-3 text-muted"><c:out value="${appt.time}" /></td>
                                            <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-scheduled px-2 py-1">Scheduled</span></td>
                                            <td class="p-3 text-end"><button class="btn btn-sm btn-outline-danger">Cancel</button></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty upcomingAppointments}">
                                        <tr><td colspan="6" class="text-center p-4">No upcoming appointments found.</td></tr>
                                    </c:if>
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
                                    <c:forEach var="appt" items="${canceledAppointments}">
                                        <tr>
                                            <td class="p-3 fw-medium"><c:out value="${appt.doctorName}" /></td>
                                            <td class="p-3 fw-medium"><c:out value="${appt.patientName}" /></td>
                                            <td class="p-3 text-muted"><c:out value="${appt.date}" /></td>
                                            <td class="p-3"><span class="badge rounded-pill fw-medium bg-status-canceled px-2 py-1">Canceled</span></td>
                                            <td class="p-3 text-end"><button class="btn btn-sm btn-outline-danger">Delete</button></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty canceledAppointments}">
                                        <tr><td colspan="5" class="text-center p-4">No canceled appointments found.</td></tr>
                                    </c:if>
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
            <p class="text-center text-muted small mb-0">&copy; 2025 Medisphere. All rights reserved.</p>
        </div>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const themeToggle = document.getElementById('themeToggle');
        const themeIcon = document.getElementById('themeIcon');
        const body = document.body;

        const applyTheme = (theme) => {
            if (theme === 'dark') {
                body.classList.add('dark-theme');
                themeIcon.textContent = 'light_mode';
            } else {
                body.classList.remove('dark-theme');
                themeIcon.textContent = 'dark_mode';
            }
        };

        const savedTheme = localStorage.getItem('theme');
        applyTheme(savedTheme || 'light');

        themeToggle.addEventListener('click', () => {
            let currentTheme = body.classList.contains('dark-theme') ? 'dark' : 'light';
            let newTheme = currentTheme === 'light' ? 'dark' : 'light';
            applyTheme(newTheme);
            localStorage.setItem('theme', newTheme);
        });

        // Chart.js implementation
        const ctx = document.getElementById('appointmentChart');
        if (ctx) {
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                        label: 'Appointments',
                        data: [12, 19, 8, 14, 10, 15, 7], // Placeholder data
                        backgroundColor: 'rgba(19, 164, 236, 0.6)',
                        borderColor: 'rgba(19, 164, 236, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { display: false }
                        },
                        x: {
                            grid: { display: false }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        }
    });
</script>
</body>
</html>
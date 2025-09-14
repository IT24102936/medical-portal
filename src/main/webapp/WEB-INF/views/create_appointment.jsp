<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medisphere - Create Appointment</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

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

        body.dark-theme .form-control,
        body.dark-theme .form-select {
            background-color: var(--dark-card-bg);
            border-color: var(--dark-card-border-color);
            color: var(--dark-body-color);
        }
        body.dark-theme .form-control::placeholder {
            color: var(--dark-text-muted);
        }
        body.dark-theme .form-select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%239ca3af' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
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

        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-700);
            box-shadow: 0 0 0 .25rem rgba(var(--bs-primary-rgb), 0.25);
        }

        .time-slots {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 0.75rem;
        }

        .time-slot.btn-outline-primary:not(.active):hover {
            background-color: var(--primary-100);
        }

        body.dark-theme .time-slot.btn-outline-primary {
            color: var(--primary-300);
            border-color: var(--primary-800);
        }
        body.dark-theme .time-slot.btn-outline-primary:not(.active):hover {
            background-color: #374151;
            border-color: var(--primary-700);
        }
        body.dark-theme .time-slot.btn-outline-primary.active {
            background-color: var(--primary-700);
            border-color: var(--primary-700);
            color: white;
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
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/receptionist/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${contextPath}/receptionist/appointments">Appointment</a></li>
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h2 fw-bold mb-0">Create New Appointment</h1>
                <a href="${contextPath}/receptionist/appointments" class="btn btn-outline-secondary d-flex align-items-center gap-2">
                    <i class="bi bi-arrow-left"></i>
                    Back to Appointments List
                </a>
            </div>

            <!-- Success/Error Message Display -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("success") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card shadow-sm">
                <div class="card-header bg-light py-3">
                    <h5 class="mb-0">Appointment Details</h5>
                </div>
                <div class="card-body p-4">
                    <%-- JSP Change: Added method and action to the form --%>
                    <form id="createAppointmentForm" action="${contextPath}/receptionist/create-appointment" method="POST">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label for="patientSelect" class="form-label fw-medium">Patient</label>
                                <select class="form-select" id="patientSelect" name="patientId" required>
                                    <option value="" selected disabled>Select a patient...</option>
                                    <%-- JSP Change: Dynamically populate patients from a servlet attribute 'patientsList' --%>
                                    <c:forEach var="patient" items="${patientsList}">
                                        <option value="${patient.patientId}">
                                            <c:out value="${patient.firstName}" /> <c:out value="${patient.lastName}" />
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="doctorSelect" class="form-label fw-medium">Doctor</label>
                                <select class="form-select" id="doctorSelect" name="doctorId" required>
                                    <option value="" selected disabled>Select a doctor...</option>
                                    <%-- JSP Change: Dynamically populate doctors from a servlet attribute 'doctorsList' --%>
                                    <c:forEach var="doctor" items="${doctorsList}">
                                        <option value="${doctor.eid}">Dr. <c:out value="${doctor.eid}" /> (<c:out value="${doctor.specialization}" />)</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="appointmentDate" class="form-label fw-medium">Date</label>
                                <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" required>
                            </div>

                            <div class="col-md-6">
                                <label for="appointmentType" class="form-label fw-medium">Appointment Type</label>
                                <select class="form-select" id="appointmentType" name="appointmentType">
                                    <option value="New Consultation">New Consultation</option>
                                    <option value="Follow-up">Follow-up</option>
                                    <option value="Routine Check-up">Routine Check-up</option>
                                    <option value="Procedure">Procedure</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-medium">Available Time Slots</label>
                                <div class="time-slots" id="timeSlotsContainer">
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="09:00">09:00 AM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="09:30">09:30 AM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="10:00">10:00 AM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="10:30">10:30 AM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="11:00">11:00 AM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="11:30">11:30 AM</button>
                                    <button type="button" class="btn btn-outline-secondary time-slot" disabled>12:00 PM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="14:00">02:00 PM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="14:30">02:30 PM</button>
                                    <button type="button" class="btn btn-outline-primary time-slot" data-time="15:00">03:00 PM</button>
                                </div>
                                <input type="hidden" name="appointmentTime" id="appointmentTime" required>
                            </div>

                            <div class="col-12">
                                <label for="appointmentNotes" class="form-label fw-medium">Notes / Reason for Visit</label>
                                <textarea class="form-control" id="appointmentNotes" name="notes" rows="4" placeholder="Enter any additional details here..."></textarea>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                            <a href="${contextPath}/receptionist/appointments" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Create Appointment</button>
                        </div>
                    </form>
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
        // --- Theme Switcher Logic ---
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

        // --- Time Slot Selection Logic ---
        const timeSlotsContainer = document.getElementById('timeSlotsContainer');
        const timeSlotButtons = timeSlotsContainer.querySelectorAll('.time-slot');
        const hiddenTimeInput = document.getElementById('appointmentTime');

        timeSlotButtons.forEach(button => {
            if (!button.disabled) {
                button.addEventListener('click', () => {
                    const currentActive = timeSlotsContainer.querySelector('.time-slot.active');
                    if (currentActive) {
                        currentActive.classList.remove('active');
                    }
                    button.classList.add('active');
                    // Set the value of the hidden input field
                    hiddenTimeInput.value = button.getAttribute('data-time');
                });
            }
        });

        // --- Form Validation on Submit ---
        const form = document.getElementById('createAppointmentForm');
        form.addEventListener('submit', function(event) {
            if (!hiddenTimeInput.value) {
                alert('Please select an available time slot.');
                event.preventDefault(); // Stop form submission
            }
        });
    });
</script>
</body>
</html>